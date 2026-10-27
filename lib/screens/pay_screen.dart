import 'package:flutter/material.dart';

import '../models/payment_category.dart';
import '../theme/app_colors.dart';
import '../utils/currency.dart';
import '../widgets/payment_category_grid.dart';
import '../widgets/payment_form.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({
    required this.walletBalance,
    required this.onPayment,
    super.key,
  });

  final double walletBalance;
  final ValueChanged<Map<String, dynamic>> onPayment;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  PaymentCategory _selectedCategory = PaymentCategory.mobileLoad;

  Future<void> _handleReview(PaymentDraft draft) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Review payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${draft.category.label}'),
            const SizedBox(height: 8),
            Text('${draft.category.destinationLabel}: ${draft.destination}'),
            const SizedBox(height: 8),
            Text('${draft.category.providerLabel}: ${draft.provider}'),
            const SizedBox(height: 8),
            Text('Amount: ${formatPeso(draft.amount)}'),
            const SizedBox(height: 12),
            const Text(
              'Demo only. No real payment is processed in this app.',
              style: TextStyle(color: muted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Edit'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    widget.onPayment({
      'category': draft.category.label,
      'provider': draft.provider,
      'amount': draft.amount,
      'title': draft.category.label,
      'type': 'Payment',
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 760;

        final categoryPanel = PaymentCategoryGrid(
          selected: _selectedCategory,
          onSelected: (category) =>
              setState(() => _selectedCategory = category),
        );

        final form = PaymentForm(
          key: ValueKey(_selectedCategory),
          category: _selectedCategory,
          availableBalance: widget.walletBalance,
          onContinue: _handleReview,
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: stacked
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    categoryPanel,
                    const SizedBox(height: 18),
                    form,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: categoryPanel),
                    const SizedBox(width: 18),
                    Expanded(flex: 5, child: form),
                  ],
                ),
        );
      },
    );
  }
}
