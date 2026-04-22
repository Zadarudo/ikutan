import 'package:get/get.dart';
import 'package:ikutan/models/ticket_model.dart';
import 'package:ikutan/providers/ticket_provider.dart';

class TicketController extends GetxController {
  late final TicketProvider _ticketProvider;

  RxList<Ticket> tickets = <Ticket>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  List<Ticket> get activeTickets =>
      tickets.where((t) => t.isActive).toList();
  List<Ticket> get usedTickets =>
      tickets.where((t) => t.isUsed && !t.isCanceled).toList();
  List<Ticket> get canceledTickets =>
      tickets.where((t) => t.isCanceled).toList();

  @override
  void onInit() {
    super.onInit();
    _ticketProvider = Get.find<TicketProvider>();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    isLoading(true);
    errorMessage('');
    try {
      final res = await _ticketProvider.getMyTickets();
      if (res.statusCode == 200 && res.body != null) {
        final List<dynamic> dataList = res.body['data'] ?? [];
        tickets.value = dataList.map((t) => Ticket.fromJson(t)).toList();
      } else {
        errorMessage(res.body?['message'] ?? 'Failed to fetch tickets');
      }
    } catch (e) {
      errorMessage('Something went wrong. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelTicket(String ticketId) async {
    try {
      final res = await _ticketProvider.cancelTicket(ticketId);
      if (res.statusCode == 200) {
        Get.snackbar('Success', res.body?['message'] ?? 'Ticket cancelled',
            snackPosition: SnackPosition.BOTTOM);
        await fetchTickets();
      } else {
        Get.snackbar('Failed', res.body?['message'] ?? 'Could not cancel ticket',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}