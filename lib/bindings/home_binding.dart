import 'package:get/get.dart';
import 'package:ikutan/controller/event_controller.dart';
import 'package:ikutan/controller/scan_controller.dart';
import 'package:ikutan/controller/ticket_controller.dart';
import 'package:ikutan/providers/event_provider.dart';
import 'package:ikutan/providers/ticket_provider.dart';
import 'package:ikutan/services/auth_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Providers — use put() so they're immediately available
    Get.put<EventProvider>(EventProvider());
    Get.put<TicketProvider>(TicketProvider());

    // Controllers
    Get.put<EventController>(EventController());
    Get.put<ScanController>(ScanController());

    // TicketController only for attendees
    final authServices = Get.find<AuthServices>();
    if (authServices.user.value?.role == 'attendee') {
      Get.put<TicketController>(TicketController());
    }
  }
}