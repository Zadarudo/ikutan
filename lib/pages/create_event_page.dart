import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/create_event_controller.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateEventController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Images picker ──────────────────────────────
              _SectionLabel(label: 'Event Images'),
              const SizedBox(height: 8),
              Obx(() {
                return SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Add button
                      GestureDetector(
                        onTap: controller.pickImages,
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.deepPurpleAccent, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate,
                                  color: Colors.deepPurpleAccent, size: 32),
                              SizedBox(height: 4),
                              Text('Add',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.deepPurpleAccent)),
                            ],
                          ),
                        ),
                      ),
                      // Selected images
                      ...controller.selectedImages.asMap().entries.map((entry) {
                        return Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(entry.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 14,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(entry.key),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),

              // ── Event Name ─────────────────────────────────
              _SectionLabel(label: 'Event Name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Flutter Conference 2026',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Name is required' : null,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // ── Description ────────────────────────────────
              _SectionLabel(label: 'Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.descController,
                decoration: const InputDecoration(
                  hintText: 'Describe your event...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Description is required' : null,
                maxLines: 4,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // ── Date picker ────────────────────────────────
              _SectionLabel(label: 'Event Date'),
              const SizedBox(height: 8),
              Obx(() => GestureDetector(
                    onTap: () => controller.pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            controller.displayDate,
                            style: TextStyle(
                              color: controller.selectedDate.value == null
                                  ? Colors.grey
                                  : theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 16),

              // ── Max Reservation ────────────────────────────
              _SectionLabel(label: 'Max Reservations'),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.maxReservationController,
                decoration: const InputDecoration(
                  hintText: 'e.g. 100',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final n = int.tryParse(v.trim());
                  if (n == null || n < 1) return 'Must be at least 1';
                  return null;
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),

              // ── Submit ─────────────────────────────────────
              Obx(() => ElevatedButton.icon(
                    onPressed:
                        controller.isLoading.value ? null : controller.submit,
                    icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.check),
                    label: Text(
                        controller.isLoading.value ? 'Creating...' : 'Create Event'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}