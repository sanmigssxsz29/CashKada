import 'package:flutter/material.dart';

import '../models/payment_category.dart';
import '../theme/app_colors.dart';

class PaymentCategoryGrid extends StatelessWidget {
  const PaymentCategoryGrid({required this.selected, required this.onSelected, super.key});

  final PaymentCategory selected;
  final ValueChanged<PaymentCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: _SectionHeading()),
            Text('Choose one', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 9)),
          ],
        ),
        const SizedBox(height: 13),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 330 ? 1 : 2;
            final cardWidth = (constraints.maxWidth - (columns - 1) * 9) / columns;
            return Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                for (final category in PaymentCategory.values)
                  _CategoryCard(
                    category: category,
                    selected: selected == category,
                    width: cardWidth,
                    onTap: () => onSelected(category),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFCFA),
            border: Border.all(color: const Color(0xFFEDF1ED)),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Row(
            children: [
              Icon(Icons.verified_user_outlined, color: cashGreen, size: 17),
              SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your payments are protected', style: TextStyle(color: Color(0xFF3B5944), fontSize: 9, fontWeight: FontWeight.w700)),
                    SizedBox(height: 3),
                    Text('Encrypted and monitored around the clock.', style: TextStyle(color: muted, fontSize: 8)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('STEP 01', style: TextStyle(color: muted, fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
        const SizedBox(height: 4),
        Text('Select payment type', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.selected,
    required this.width,
    required this.onTap,
  });

  final PaymentCategory category;
  final bool selected;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 67,
      child: Material(
        color: selected ? const Color(0xFFF7FBF8) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(
            color: selected ? const Color(0xFF31935E) : const Color(0xFFE8EDE8),
            width: selected ? 1.3 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(7),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(color: category.tint, borderRadius: BorderRadius.circular(7)),
                      child: Icon(category.icon, color: _iconColor(category), size: 17),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        category.label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFF364239), fontSize: 10, fontWeight: FontWeight.w600, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(color: cashGreen, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, color: Colors.white, size: 11),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _iconColor(PaymentCategory category) => switch (category) {
        PaymentCategory.mobileLoad => const Color(0xFF29794C),
        PaymentCategory.billPayment => const Color(0xFFC4794F),
        PaymentCategory.onlineShopping => const Color(0xFF7964A5),
        PaymentCategory.qrPayment => const Color(0xFFAD8632),
        PaymentCategory.government => const Color(0xFF4A7894),
        PaymentCategory.other => const Color(0xFFAE5D7B),
      };
}