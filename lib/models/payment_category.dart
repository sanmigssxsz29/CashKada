import 'package:flutter/material.dart';

enum PaymentCategory {
  mobileLoad(
    'Mobile Load', Icons.phone_android_rounded, Color(0xFFE5F3E8),
    destinationLabel: 'Mobile number',
    destinationHint: 'e.g. 917 123 4567',
    providerLabel: 'Network provider',
    providers: ['Globe Telecom', 'Smart Communications', 'DITO Telecommunity', 'TNT', 'TM'],
    isPhilippineMobile: true,
  ),
  billPayment(
    'Bill Payment', Icons.receipt_long_rounded, Color(0xFFFFF0E7),
    destinationLabel: 'Account / reference number',
    destinationHint: 'Enter your account number',
    providerLabel: 'Biller',
    providers: ['Meralco', 'Manila Water', 'Maynilad', 'PLDT', 'Converge'],
  ),
  onlineShopping(
    'Online Shopping', Icons.shopping_bag_outlined, Color(0xFFF0EDFA),
    destinationLabel: 'Order / reference number',
    destinationHint: 'e.g. CK-2026-1048',
    providerLabel: 'Merchant',
    providers: ['Lazada', 'Shopee', 'TikTok Shop', 'Other merchant'],
  ),
  qrPayment(
    'QR Payment', Icons.qr_code_2_rounded, Color(0xFFFAF2DA),
    destinationLabel: 'Merchant reference',
    destinationHint: 'Enter the QR payment reference',
    providerLabel: 'Payment network',
    providers: ['QR Ph', 'Participating bank', 'CashKada wallet'],
  ),
  government(
    'Government Services', Icons.account_balance_outlined, Color(0xFFE7F0F6),
    destinationLabel: 'Reference number',
    destinationHint: 'Enter your payment reference',
    providerLabel: 'Agency',
    providers: ['BIR', 'SSS', 'PhilHealth', 'Pag-IBIG Fund'],
  ),
  other(
    'Other Services', Icons.grid_view_rounded, Color(0xFFF9EAF0),
    destinationLabel: 'Account / reference number',
    destinationHint: 'Enter your payment reference',
    providerLabel: 'Service provider',
    providers: ['Education', 'Healthcare', 'Insurance', 'Other service'],
  );

  const PaymentCategory(
    this.label,
    this.icon,
    this.tint, {
    required this.destinationLabel,
    required this.destinationHint,
    required this.providerLabel,
    required this.providers,
    this.isPhilippineMobile = false,
  });

  final String label;
  final IconData icon;
  final Color tint;
  final String destinationLabel;
  final String destinationHint;
  final String providerLabel;
  final List<String> providers;
  final bool isPhilippineMobile;
}

class PaymentRecord {
  const PaymentRecord({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  final PaymentCategory category;
  final String description;
  final double amount;
  final DateTime date;
}