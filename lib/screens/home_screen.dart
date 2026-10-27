import 'package:flutter/material.dart';

import '../models/payment_category.dart';
import '../theme/app_colors.dart';
import '../utils/currency.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.balance,
    required this.transactions,
    super.key,
  });

  final double balance;
  final List<PaymentRecord> transactions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE8EDE8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wallet balance',
                  style: TextStyle(
                      color: muted, fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  formatPeso(balance),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: ink,
                    letterSpacing: -0.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Quick actions',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: ink),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.9,
            children: const [
              QuickActionTile(label: 'Transfer', icon: Icons.send_rounded),
              QuickActionTile(label: 'Bills', icon: Icons.receipt_long_rounded),
              QuickActionTile(
                  label: 'Top up', icon: Icons.phone_android_rounded),
              QuickActionTile(label: 'Scan', icon: Icons.qr_code_2_rounded),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Recent activity',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: ink),
          ),
          const SizedBox(height: 12),
          ...transactions.take(4).map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDE8)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: item.category.tint,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(item.category.icon, color: cashGreen, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.category.label,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, color: ink),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: const TextStyle(color: muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '- ${formatPeso(item.amount)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class QuickActionTile extends StatelessWidget {
  const QuickActionTile({
    required this.label,
    required this.icon,
    super.key,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EDE8)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5ED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: cashGreen),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
