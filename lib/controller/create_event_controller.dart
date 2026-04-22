import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ikutan/providers/event_provider.dart';
import 'package:ikutan/controller/event_controller.dart';

class CreateEventController extends GetxController {
  late final EventProvider _eventProvider;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final maxReservationController = TextEditingController();

  RxBool isLoading = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<File> selectedImages = <File>[].obs;

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _eventProvider = Get.find<EventProvider>();
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    maxReservationController.dispose();
    super.onClose();
  }

  String get formattedDate {
    if (selectedDate.value == null) return '';
    final d = selectedDate.value!;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}T00:00:00.000Z';
  }

  String get displayDate {
    if (selectedDate.value == null) return 'Pick a date';
    final d = selectedDate.value!;
    return '${d.day}/${d.month}/${d.year}';
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) selectedDate.value = picked;
  }

  Future<void> pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage(imageQuality: 80);
    if (picked.isNotEmpty) {
      selectedImages.addAll(picked.map((x) => File(x.path)));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedDate.value == null) {
      Get.snackbar('Error', 'Please pick an event date',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please add at least one image',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading(true);
    try {
      final images = selectedImages.map((file) {
        final filename = file.path.split('/').last;
        final ext = filename.split('.').last.toLowerCase();
        final contentType = ext == 'png' ? 'image/png' : 'image/jpeg';
        return MultipartFile(
          file.readAsBytesSync(),
          filename: filename,
          contentType: contentType,
        );
      }).toList();

      final res = await _eventProvider.createEvent(
        name: nameController.text.trim(),
        desc: descController.text.trim(),
        date: formattedDate,
        maxReservation: int.parse(maxReservationController.text.trim()),
        images: images,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.back(); // close the page
        Get.snackbar('Success', res.body?['message'] ?? 'Event created!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF2E7D32),
            colorText: const Color(0xFFFFFFFF));
        // Refresh the events list
        Get.find<EventController>().fetchEvents();
      } else {
        final msg = res.body?['message'] ?? 'Failed to create event';
        Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}