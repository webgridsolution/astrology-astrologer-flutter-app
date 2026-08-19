import '../models/payout_model.dart';
import '../models/transaction_model.dart';

final mockTransactions = <TransactionModel>[
  TransactionModel(
    id: 't1',
    title: 'Chat with Aman',
    amount: 297,
    date: DateTime(2026, 8, 18, 10, 30),
    category: 'Chat',
  ),
  TransactionModel(
    id: 't2',
    title: 'Call with Priya',
    amount: 474,
    date: DateTime(2026, 8, 18, 11, 50),
    category: 'Audio',
  ),
  TransactionModel(
    id: 't3',
    title: 'Kundli Analysis',
    amount: 299,
    date: DateTime(2026, 8, 12, 17, 40),
    category: 'Other',
  ),
  TransactionModel(
    id: 't4',
    title: 'Video with Rohit',
    amount: 387,
    date: DateTime(2026, 8, 8, 13, 30),
    category: 'Video',
  ),
  TransactionModel(
    id: 't5',
    title: 'Tarot Reading',
    amount: 199,
    date: DateTime(2026, 8, 16, 16, 30),
    category: 'Other',
  ),
];

final mockPayouts = <PayoutModel>[
  PayoutModel(
    id: 'p1',
    amount: 8500,
    date: DateTime(2026, 8, 1),
    status: 'Paid',
    method: 'HDFC ****4521',
  ),
  PayoutModel(
    id: 'p2',
    amount: 7200,
    date: DateTime(2026, 7, 1),
    status: 'Paid',
    method: 'HDFC ****4521',
  ),
  PayoutModel(
    id: 'p3',
    amount: 2100,
    date: DateTime(2026, 8, 18),
    status: 'Pending',
    method: 'HDFC ****4521',
  ),
];

final mockEarningsPoints = <Map<String, dynamic>>[
  {'label': '1 Aug', 'value': 1500.0},
  {'label': '5 Aug', 'value': 2400.0},
  {'label': '10 Aug', 'value': 3200.0},
  {'label': '15 Aug', 'value': 4850.0},
  {'label': '20 Aug', 'value': 4100.0},
  {'label': '25 Aug', 'value': 5800.0},
  {'label': '30 Aug', 'value': 6700.0},
];
