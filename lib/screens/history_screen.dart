import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../theme/app_colors.dart';
import '../utils/currency.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    required this.transactions,
    super.key,
  });

  final List<AppTransaction> transactions;

  IconData _iconFor(String type) {
    switch (type) {
      case 'Send':
        return Icons.send_rounded;
      case 'Payment':
        return Icons.receipt_long_rounded;
      case 'Load':
        return Icons.phone_android_rounded;
      case 'Wallet':
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.swap_horiz_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recent = List<AppTransaction>.from(transactions)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: recent.length,
      itemBuilder: (context, index) {
        final transaction = recent[index];
        final isOutgoing = transaction.amount > 0;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8EDE8)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5ED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _iconFor(transaction.type),
                  color: cashGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${transaction.category} · ${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                      style: const TextStyle(
                        color: muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isOutgoing ? '-' : '+'}${formatPeso(transaction.amount)}',
                    style: TextStyle(
                      color: isOutgoing ? ink : cashGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: transaction.status == 'Completed'
                          ? const Color(0xFFEAF5ED)
                          : const Color(0xFFFFF0E8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      transaction.status,
                      style: TextStyle(
                        color: transaction.status == 'Completed'
                            ? cashGreen
                            : const Color(0xFFB47644),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
