import 'package:get/get.dart';
import 'package:ikutan/models/scan_result_model.dart';
import 'package:ikutan/providers/ticket_provider.dart';

enum ScanState { idle, loading, success, error }

class ScanController extends GetxController {
  late final TicketProvider _ticketProvider;

  Rx<ScanState> scanState = ScanState.idle.obs;
  Rx<ScanResult?> scanResult = Rx<ScanResult?>(null);
  RxString lastScannedCode = ''.obs;
  RxBool isCameraActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    _ticketProvider = Get.find<TicketProvider>();
  }

  Future<void> onQRScanned(String code) async {
    if (scanState.value == ScanState.loading) return;
    if (code == lastScannedCode.value && scanState.value != ScanState.idle) return;

    lastScannedCode(code);
    isCameraActive(false);
    scanState(ScanState.loading);
    scanResult.value = null;

    try {
      final res = await _ticketProvider.checkin(code);
      if (res.body != null) {
        final result = ScanResult.fromJson(res.body);
        scanResult.value = result;
        scanState(result.isSuccess ? ScanState.success : ScanState.error);
      } else {
        scanResult.value = ScanResult(status: 'Error', message: 'No response from server');
        scanState(ScanState.error);
      }
    } catch (e) {
      scanResult.value = ScanResult(status: 'Error', message: 'Network error. Please check your connection.');
      scanState(ScanState.error);
    }
  }

  void reset() {
    scanState(ScanState.idle);
    scanResult.value = null;
    lastScannedCode('');
    isCameraActive(true);
  }
}