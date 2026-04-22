class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  bool get isSuccess => status.toLowerCase() == 'success';

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromData,
  ) {
    return ApiResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: fromData != null && json['data'] != null
          ? fromData(json['data'])
          : null,
    );
  }
}