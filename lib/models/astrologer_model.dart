class AstrologerModel {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String title;
  final String image;
  final String about;
  final int experienceYears;
  final double rating;
  final int reviewCount;
  final int clients;
  final int profileViews;
  final List<String> specializations;
  final List<String> languages;
  final bool verified;
  final bool online;
  final String kycStatus;

  const AstrologerModel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.title,
    required this.image,
    required this.about,
    required this.experienceYears,
    required this.rating,
    required this.reviewCount,
    required this.clients,
    required this.profileViews,
    required this.specializations,
    required this.languages,
    this.verified = true,
    this.online = true,
    this.kycStatus = 'Approved',
  });

  AstrologerModel copyWith({
    String? name,
    String? mobile,
    String? email,
    String? title,
    String? image,
    String? about,
    int? experienceYears,
    List<String>? specializations,
    List<String>? languages,
    bool? online,
  }) {
    return AstrologerModel(
      id: id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      title: title ?? this.title,
      image: image ?? this.image,
      about: about ?? this.about,
      experienceYears: experienceYears ?? this.experienceYears,
      rating: rating,
      reviewCount: reviewCount,
      clients: clients,
      profileViews: profileViews,
      specializations: specializations ?? this.specializations,
      languages: languages ?? this.languages,
      verified: verified,
      online: online ?? this.online,
      kycStatus: kycStatus,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'title': title,
        'image': image,
        'about': about,
        'experienceYears': experienceYears,
        'rating': rating,
        'reviewCount': reviewCount,
        'clients': clients,
        'profileViews': profileViews,
        'specializations': specializations,
        'languages': languages,
        'verified': verified,
        'online': online,
        'kycStatus': kycStatus,
      };

  factory AstrologerModel.fromJson(Map<String, dynamic> json) {
    return AstrologerModel(
      id: json['id'] ?? 'ast-1',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      title: json['title'] ?? 'Vedic Astrologer',
      image: json['image'] ?? '',
      about: json['about'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      rating: (json['rating'] ?? 4.9).toDouble(),
      reviewCount: json['reviewCount'] ?? 128,
      clients: json['clients'] ?? 156,
      profileViews: json['profileViews'] ?? 248,
      specializations: List<String>.from(json['specializations'] ?? const []),
      languages: List<String>.from(json['languages'] ?? const []),
      verified: json['verified'] ?? true,
      online: json['online'] ?? true,
      kycStatus: json['kycStatus'] ?? 'Approved',
    );
  }
}
