class Event {
  final String id;
  final String name;
  final String desc;
  final List<String> images;
  final String date;
  final int maxReservation;
  final String? createdAt;
  final String? updatedAt;

  Event({
    required this.id,
    required this.name,
    required this.desc,
    required this.images,
    required this.date,
    required this.maxReservation,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'].map((e) => e.toString()))
          : [],
      date: json['date']?.toString() ?? '',
      // safely parse max_reservation whether it comes as int or string
      maxReservation: int.tryParse(json['max_reservation']?.toString() ?? '0') ?? 0,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}