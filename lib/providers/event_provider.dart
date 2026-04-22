import 'package:get/get_connect/connect.dart';
import 'package:ikutan/providers/api_provider.dart';

class EventProvider extends ApiProvider {
  Future<Response> getEvents() async {
    return get('/event');
  }

  Future<Response> getEvent(String eventId) async {
    return get('/event/$eventId');
  }

  Future<Response> reserveTicket(String eventId) async {
    return post('/event/$eventId/reserve', {});
  }

  Future<Response> createEvent({
    required String name,
    required String desc,
    required String date,
    required int maxReservation,
    required List<MultipartFile> images,
  }) async {
    final form = FormData({
      'name': name,
      'desc': desc,
      'date': date,
      'max_reservation': maxReservation.toString(),
      'images': images,
    });
    return post('/event', form);
  }
}