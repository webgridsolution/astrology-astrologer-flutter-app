import '../models/review_model.dart';
import '../utils/constants.dart';

final mockReviews = <ReviewModel>[
  ReviewModel(
    id: 'rv1',
    clientId: 'c1',
    clientName: 'Aman Verma',
    clientImage: AppAssets.aman,
    rating: 5,
    comment: 'Excellent guidance! Your prediction was very accurate.',
    date: DateTime(2026, 8, 15),
  ),
  ReviewModel(
    id: 'rv2',
    clientId: 'c2',
    clientName: 'Priya Sharma',
    clientImage: AppAssets.priya,
    rating: 5,
    comment: 'Very calm and clear. Helped me understand my marriage timing.',
    date: DateTime(2026, 8, 12),
    reply: 'Thank you Priya. Wishing you a blessed journey.',
  ),
  ReviewModel(
    id: 'rv3',
    clientId: 'c3',
    clientName: 'Rohit Singh',
    clientImage: AppAssets.rohit,
    rating: 4,
    comment: 'Good session. Would love a longer video consultation next time.',
    date: DateTime(2026, 8, 8),
  ),
  ReviewModel(
    id: 'rv4',
    clientId: 'c4',
    clientName: 'Neha Patel',
    clientImage: AppAssets.neha,
    rating: 5,
    comment: 'The kundli analysis was detailed and practical.',
    date: DateTime(2026, 8, 3),
  ),
  ReviewModel(
    id: 'rv5',
    clientId: 'c5',
    clientName: 'Vikram Joshi',
    clientImage: AppAssets.vikram,
    rating: 4,
    comment: 'Helpful tarot reading. Waiting for the next chat.',
    date: DateTime(2026, 7, 28),
  ),
];
