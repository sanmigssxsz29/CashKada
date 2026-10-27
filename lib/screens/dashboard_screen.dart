import 'package:flutter/material.dart';

import '../models/payment_category.dart';
import '../models/transaction.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    this.walletBalance = 12450,
    this.transactions = const [],
    super.key,
  });

  final double walletBalance;
  final List<AppTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      balance: walletBalance,
      transactions: transactions.map((tx) {
        final category = tx.category == 'Bill Payment'
            ? PaymentCategory.billPayment
            : tx.category == 'Mobile Load'
                ? PaymentCategory.mobileLoad
                : tx.category == 'Online Shopping'
                    ? PaymentCategory.onlineShopping
                    : PaymentCategory.other;

        return PaymentRecord(
          category: category,
          description: tx.title,
          amount: tx.amount,
          date: tx.date,
        );
      }).toList(),
    );
  }
}
