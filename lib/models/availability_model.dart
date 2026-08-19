class AvailabilityModel {
  final String day;
  final bool enabled;
  final String startTime;
  final String endTime;

  const AvailabilityModel({
    required this.day,
    required this.enabled,
    required this.startTime,
    required this.endTime,
  });

  AvailabilityModel copyWith({
    bool? enabled,
    String? startTime,
    String? endTime,
  }) {
    return AvailabilityModel(
      day: day,
      enabled: enabled ?? this.enabled,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
