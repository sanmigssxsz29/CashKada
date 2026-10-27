import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_navigation.dart';

class SideInformation extends StatelessWidget {
  const SideInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286,
      padding: const EdgeInsets.fromLTRB(22, 32, 22, 18),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F8F5),
        border: Border(left: BorderSide(color: Color(0xFFEDF0ED))),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CashKadaLogo(),
          SizedBox(height: 54),
          Text(
            'PAY WITH PEACE OF MIND',
            style: TextStyle(
              color: Color(0xFF6F9A79),
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
          SizedBox(height: 11),
          Text.rich(
            TextSpan(
              style: TextStyle(
                color: Color(0xFF1C2B21),
                fontSize: 25,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
              children: [
                TextSpan(text: 'Fast and secure\n'),
                TextSpan(
                  text: 'e-payments.',
                  style: TextStyle(color: Color(0xFF288458)),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your everyday payments, made simpler and safer.',
            style: TextStyle(color: muted, fontSize: 10, height: 1.55),
          ),
          SizedBox(height: 22),
          _Benefit(
              icon: Icons.verified_user_outlined,
              title: 'Safe',
              subtitle: 'Your transactions are protected.',
              tint: Color(0xFFE3F1E7),
              iconColor: Color(0xFF338251)),
          _Benefit(
              icon: Icons.bolt_rounded,
              title: 'Fast',
              subtitle: 'Get it done in seconds.',
              tint: Color(0xFFFFF0E8),
              iconColor: Color(0xFFCA7651)),
          _Benefit(
              icon: Icons.public_rounded,
              title: 'Convenient',
              subtitle: 'Pay anytime, anywhere.',
              tint: Color(0xFFE5EEF4),
              iconColor: Color(0xFF557E98)),
          Spacer(),
          _PromoCard(),
          SizedBox(height: 13),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xFF42A76A), size: 7),
              SizedBox(width: 6),
              Expanded(
                  child: Text('Trusted by Filipinos',
                      style: TextStyle(color: muted, fontSize: 8))),
              Text('SECURE · SIMPLE · ALWAYS',
                  style:
                      TextStyle(color: muted, fontSize: 6, letterSpacing: 0.6)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE7ECE7)))),
      child: Row(
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
                color: tint, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Color(0xFF354339),
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(color: muted, fontSize: 8)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_rounded,
              size: 12, color: Color(0xFFA4AFA6)),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 272,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: const Color(0xFF174D38),
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Positioned(
              top: -45,
              right: -40,
              child: Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0x22FFFFFF))))),
          const Positioned(
              top: 14,
              left: 14,
              child: Text('THE CASHKADA WAY',
                  style: TextStyle(
                      color: Color(0xFFB7D1BD),
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1))),
          const Positioned(
              top: 12,
              right: 14,
              child:
                  Icon(Icons.auto_awesome, color: Color(0xFFC9DC8C), size: 14)),
          Positioned(
            top: 32,
            left: 0,
            right: 0,
            height: 139,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    width: 173,
                    height: 106,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0x20FFFFFF)))),
                Transform.rotate(
                  angle: 0.08,
                  child: Container(
                    width: 83,
                    height: 126,
                    padding: const EdgeInsets.fromLTRB(8, 14, 8, 7),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF4F7F4),
                        border: Border.all(
                            color: const Color(0xFFDCE8DC), width: 2),
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x550B281B),
                              blurRadius: 15,
                              offset: Offset(0, 7))
                        ]),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('cashkada',
                            style: TextStyle(
                                color: cashGreen,
                                fontSize: 6,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 7),
                        Text('Good morning,\nMaria ✦',
                            style: TextStyle(
                                color: Color(0xFF324C39),
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                height: 1.3)),
                        SizedBox(height: 7),
                        Text('WALLET BALANCE',
                            style: TextStyle(
                                color: muted, fontSize: 4, letterSpacing: 0.6)),
                        Text('₱ 12,450',
                            style: TextStyle(
                                color: Color(0xFF245C3E),
                                fontSize: 11,
                                fontWeight: FontWeight.w800)),
                        Spacer(),
                        Row(children: [
                          Icon(Icons.call_made_rounded,
                              size: 12, color: cashGreen),
                          SizedBox(width: 7),
                          Icon(Icons.add_circle_outline,
                              size: 12, color: cashGreen),
                          SizedBox(width: 7),
                          Icon(Icons.history_rounded,
                              size: 12, color: cashGreen)
                        ]),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 22,
                  bottom: 14,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      width: 72,
                      height: 46,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: const Color(0xFF4B9C69),
                          border: Border.all(color: const Color(0xFFA9D1AB)),
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: const [
                            BoxShadow(color: Color(0x55092817), blurRadius: 10)
                          ]),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ck',
                              style: TextStyle(
                                  color: Color(0xFFDDEBCD),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800)),
                          Spacer(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text('₱',
                                  style: TextStyle(
                                      color: Color(0xFFE2EDC8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700))),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    left: 30,
                    top: 28,
                    child: Icon(Icons.paid_rounded,
                        color: Color(0xFFD9C77D), size: 23)),
              ],
            ),
          ),
          const Positioned(
            left: 14,
            bottom: 34,
            child: Text('Simple payments.\nGreater possibilities.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.4)),
          ),
          const Positioned(
              bottom: 12,
              left: 14,
              child: Text('Life moves. CashKada keeps up.',
                  style: TextStyle(color: Color(0xFFB3CCBA), fontSize: 8))),
        ],
      ),
    );
  }
}
