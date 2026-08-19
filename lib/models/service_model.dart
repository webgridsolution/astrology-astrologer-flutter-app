class ServiceModel {
  final String id;
  final String name;
  final String type;
  final double price;
  final bool perMinute;
  final int durationMinutes;
  final String description;
  final bool enabled;
  final String icon;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.perMinute,
    required this.durationMinutes,
    required this.description,
    required this.enabled,
    required this.icon,
  });

  String get priceLabel =>
      perMinute ? '₹${price.toInt()} / min' : '₹${price.toInt()}';

  ServiceModel copyWith({
    String? name,
    String? type,
    double? price,
    bool? perMinute,
    int? durationMinutes,
    String? description,
    bool? enabled,
  }) {
    return ServiceModel(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      perMinute: perMinute ?? this.perMinute,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      description: description ?? this.description,
      enabled: enabled ?? this.enabled,
      icon: icon,
    );
  }
}
