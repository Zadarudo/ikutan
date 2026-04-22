class ScanResult {
  final String status;
  final String message;
  final Map<String, dynamic>? data;

  ScanResult({
    required this.status,
    required this.message,
    this.data,
  });

  bool get isSuccess => status.toLowerCase() == 'success';

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] is Map ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}