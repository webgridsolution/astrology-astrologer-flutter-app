class KundliDetails {
  final String dateOfBirth;
  final String timeOfBirth;
  final String placeOfBirth;
  final String rashi;
  final String nakshatra;
  final String lagna;
  final String sunSign;
  final String moonSign;
  final Map<String, String> planets;

  const KundliDetails({
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.rashi,
    required this.nakshatra,
    required this.lagna,
    required this.sunSign,
    required this.moonSign,
    required this.planets,
  });
}

class ClientModel {
  final String id;
  final String name;
  final String mobile;
  final String image;
  final String gender;
  final int totalConsultations;
  final String lastConsultation;
  final double totalSpent;
  final String notes;
  final KundliDetails kundli;

  const ClientModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.image,
    required this.gender,
    required this.totalConsultations,
    required this.lastConsultation,
    required this.totalSpent,
    required this.notes,
    required this.kundli,
  });

  ClientModel copyWith({String? notes}) {
    return ClientModel(
      id: id,
      name: name,
      mobile: mobile,
      image: image,
      gender: gender,
      totalConsultations: totalConsultations,
      lastConsultation: lastConsultation,
      totalSpent: totalSpent,
      notes: notes ?? this.notes,
      kundli: kundli,
    );
  }
}
