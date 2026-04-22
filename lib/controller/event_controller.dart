import 'dart:developer';
import 'package:get/get.dart';
import 'package:ikutan/models/event_model.dart';
import 'package:ikutan/providers/event_provider.dart';

class EventController extends GetxController {
  late final EventProvider _eventProvider;

  RxList<Event> events = <Event>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _eventProvider = Get.find<EventProvider>();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading(true);
    errorMessage('');
    try {
      final res = await _eventProvider.getEvents();
      log('=== EVENT FETCH ===');
      log('Status: ${res.statusCode}');
      log('Body: ${res.body}');
      log('Error: ${res.statusText}');
      log('===================');
      if (res.statusCode == 200 && res.body != null) {
        final List<dynamic> dataList = res.body['data'] ?? [];
        events.value = dataList.map((e) => Event.fromJson(e)).toList();
      } else {
        errorMessage(res.body?['message'] ?? 'Failed to fetch events (${res.statusCode})');
      }
    } catch (e, stack) {
      log('=== EVENT ERROR ===');
      log('Exception: $e');
      log('Stack: $stack');
      log('===================');
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> reserveTicket(String eventId) async {
    try {
      final res = await _eventProvider.reserveTicket(eventId);
      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.snackbar('Success', res.body?['message'] ?? 'Ticket reserved successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Failed', res.body?['message'] ?? 'Could not reserve ticket',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong', snackPosition: SnackPosition.BOTTOM);
    }
  }
}