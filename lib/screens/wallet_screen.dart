import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../theme/app_colors.dart';
import '../utils/currency.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({
    required this.walletBalance,
    required this.transactions,
    super.key,
  });

  final double walletBalance;
  final List<AppTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5E3D),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available balance',
                  style: TextStyle(color: Color(0xFFD7F5E6), fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  formatPeso(walletBalance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Primary wallet',
                        style:
                            TextStyle(color: Color(0xFFD7F5E6), fontSize: 11),
                      ),
                    ),
                    Text(
                      '•••• 4821',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: _MiniWalletStat(
                  label: 'Income',
                  value: '₱ 9,600',
                  color: Color(0xFFEAF5ED),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MiniWalletStat(
                  label: 'Spent',
                  value: '₱ 3,750',
                  color: Color(0xFFFFF0E8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Wallet activity',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: ink),
          ),
          const SizedBox(height: 12),
          ...transactions.take(5).map((tx) {
            final isIncoming = tx.type == 'Wallet';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE8EDE8)),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEAF5ED),
                  child: Icon(
                    isIncoming
                        ? Icons.arrow_downward_rounded
                        : Icons.arrow_upward_rounded,
                    color: cashGreen,
                  ),
                ),
                title: Text(tx.title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(
                  '${tx.category} · ${tx.date.day}/${tx.date.month}/${tx.date.year}',
                  style: const TextStyle(color: muted, fontSize: 11),
                ),
                trailing: Text(
                  '${isIncoming ? '+' : '-'}${formatPeso(tx.amount)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: isIncoming ? cashGreen : ink,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MiniWalletStat extends StatelessWidget {
  const _MiniWalletStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800, color: ink),
          ),
        ],
      ),
    );
  }
}
