class Ticket {
  final String id;
  final String userId;
  final String eventId;
  final String code;
  final String? checkedAt;
  final bool isCanceled;
  final String? createdAt;
  final String? updatedAt;
  final Map<String, dynamic>? event;

  Ticket({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.code,
    this.checkedAt,
    required this.isCanceled,
    this.createdAt,
    this.updatedAt,
    this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      checkedAt: json['checked_at']?.toString(),
      isCanceled: json['is_canceled'] == true || json['is_canceled'] == 1,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      event: json['event'] is Map ? Map<String, dynamic>.from(json['event']) : null,
    );
  }

  bool get isUsed => checkedAt != null;
  bool get isActive => !isCanceled && !isUsed;
}