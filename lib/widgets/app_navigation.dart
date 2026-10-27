import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CashKadaHeader extends StatelessWidget {
  const CashKadaHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        height: 90,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16, safePadding > 0 ? 10 : 8, 16, 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFEDF0ED)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CashKadaLogo(),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5ED),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'Live',
                style: TextStyle(
                  color: cashGreen,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CashKadaMark extends StatelessWidget {
  const CashKadaMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: cashGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _MarkTile(),
                SizedBox(width: 3),
                _MarkTile(opacity: 0.72),
              ],
            ),
          ),
          SizedBox(height: 3),
          Expanded(
            child: Row(
              children: [
                _MarkTile(opacity: 0.72),
                SizedBox(width: 3),
                _MarkTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MarkTile extends StatelessWidget {
  const _MarkTile({this.opacity = 1.0});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class CashKadaLogo extends StatelessWidget {
  const CashKadaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CashKadaMark(),
        SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'cashkada',
              style: TextStyle(
                color: ink,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.7,
              ),
            ),
            Text(
              'Safe. Fast. Convenient.',
              style: TextStyle(
                color: muted,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CashKadaBottomNav extends StatelessWidget {
  const CashKadaBottomNav({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const List<NavItemData> items = [
    NavItemData(label: 'Home', icon: Icons.home_rounded),
    NavItemData(label: 'Pay', icon: Icons.receipt_long_rounded),
    NavItemData(label: 'Send', icon: Icons.send_rounded),
    NavItemData(label: 'History', icon: Icons.history_rounded),
    NavItemData(label: 'Wallet', icon: Icons.account_balance_wallet_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(14, 10, 14, 10 + bottomInset),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFEDF0ED)),
          ),
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  margin: EdgeInsets.symmetric(horizontal: isSelected ? 4 : 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEAF5ED)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          item.icon,
                          size: 22,
                          color:
                              isSelected ? cashGreen : const Color(0xFF6B746E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: Text(
                          item.label,
                          key: ValueKey<String>(item.label),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? cashGreen
                                : const Color(0xFF6B746E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class NavItemData {
  const NavItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
