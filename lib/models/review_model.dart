class ReviewModel {
  final String id;
  final String clientId;
  final String clientName;
  final String clientImage;
  final double rating;
  final String comment;
  final DateTime date;
  final String? reply;

  const ReviewModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.reply,
  });

  ReviewModel copyWith({String? reply}) {
    return ReviewModel(
      id: id,
      clientId: clientId,
      clientName: clientName,
      clientImage: clientImage,
      rating: rating,
      comment: comment,
      date: date,
      reply: reply ?? this.reply,
    );
  }
}
