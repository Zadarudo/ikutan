import 'package:get/get_connect/connect.dart';
import 'package:ikutan/providers/api_provider.dart';

class TicketProvider extends ApiProvider {
  Future<Response> getMyTickets() async {
    return get('/my-tickets');
  }

  Future<Response> cancelTicket(String ticketId) async {
    return patch('/ticket/$ticketId/cancel', {});
  }

  Future<Response> checkin(String code) async {
    return patch('/checkin', {'code': code});
  }
}