import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/payment_category.dart';
import '../utils/currency.dart';
import '../theme/app_colors.dart';

class PaymentDraft {
  const PaymentDraft({
    required this.category,
    required this.destination,
    required this.provider,
    required this.amount,
  });

  final PaymentCategory category;
  final String destination;
  final String provider;
  final double amount;
}

class PaymentForm extends StatefulWidget {
  const PaymentForm({
    required this.category,
    required this.availableBalance,
    required this.onContinue,
    super.key,
  });

  final PaymentCategory category;
  final double availableBalance;
  final ValueChanged<PaymentDraft> onContinue;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _amountController = TextEditingController();
  String? _provider;

  @override
  void dispose() {
    _destinationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final destination = _destinationController.text.trim();
    widget.onContinue(
      PaymentDraft(
        category: widget.category,
        destination: widget.category.isPhilippineMobile
            ? destination.replaceAll(RegExp(r'\s+'), '')
            : destination,
        provider: _provider!,
        amount: double.parse(_amountController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE9EDE9)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Color(0x08152C1B), blurRadius: 16, offset: Offset(0, 4))
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PAYMENT DETAILS',
                          style: TextStyle(
                              color: muted,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1)),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF0F6F1),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text('1 OF 3',
                      style: TextStyle(
                          color: Color(0xFF5A8869),
                          fontSize: 8,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            Text(widget.category.label,
                style: const TextStyle(
                    color: ink, fontSize: 14, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            _FormLabel(widget.category.destinationLabel),
            TextFormField(
              key: ValueKey(widget.category),
              controller: _destinationController,
              keyboardType: widget.category.isPhilippineMobile
                  ? TextInputType.phone
                  : TextInputType.text,
              inputFormatters: widget.category.isPhilippineMobile
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                      LengthLimitingTextInputFormatter(12),
                    ]
                  : null,
              decoration: InputDecoration(
                prefixText: widget.category.isPhilippineMobile ? '+63  ' : null,
                prefixStyle: const TextStyle(
                    color: Color(0xFF728178),
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
                hintText: widget.category.destinationHint,
              ),
              validator: (value) {
                final destination = (value ?? '').trim();
                if (widget.category.isPhilippineMobile) {
                  final number = destination.replaceAll(RegExp(r'\s+'), '');
                  return RegExp(r'^9\d{9}$').hasMatch(number)
                      ? null
                      : 'Enter a valid 10-digit number starting with 9';
                }
                return destination.length >= 4
                    ? null
                    : 'Enter at least 4 characters';
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 12),
              child: Text(
                widget.category.isPhilippineMobile
                    ? 'Enter your 10-digit Philippine number'
                    : 'Enter the reference shown on your bill or order',
                style: const TextStyle(color: muted, fontSize: 8),
              ),
            ),
            _FormLabel(widget.category.providerLabel),
            DropdownButtonFormField<String>(
              initialValue: _provider,
              isExpanded: true,
              hint:
                  Text('Select ${widget.category.providerLabel.toLowerCase()}'),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              decoration: const InputDecoration(),
              items: widget.category.providers
                  .map((provider) =>
                      DropdownMenuItem(value: provider, child: Text(provider)))
                  .toList(),
              onChanged: (value) => setState(() => _provider = value),
              validator: (value) =>
                  value == null ? 'Select a network provider' : null,
            ),
            const SizedBox(height: 13),
            const _FormLabel('Amount'),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,5}(\.\d{0,2})?'))
              ],
              decoration: const InputDecoration(
                prefixText: '₱  ',
                prefixStyle: TextStyle(
                    color: Color(0xFF536B5A),
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
                hintText: 'Enter amount',
              ),
              validator: (value) {
                final amount = double.tryParse(value ?? '');
                return amount == null ||
                        amount < 10 ||
                        amount > 50000 ||
                        amount > widget.availableBalance
                    ? 'Enter at least ₱10, within your available balance'
                    : null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Min ₱10 · ${formatPeso(widget.availableBalance)} available',
                style: const TextStyle(color: muted, fontSize: 8),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 41,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const SizedBox.shrink(),
                label: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Continue to review',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w700)),
                    SizedBox(width: 9),
                    Icon(Icons.arrow_forward_rounded, size: 16),
                  ],
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: cashGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline_rounded,
                    color: Color(0xFF8FA797), size: 11),
                SizedBox(width: 5),
                Text('Your details are encrypted and secure',
                    style: TextStyle(color: muted, fontSize: 8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(label,
          style: const TextStyle(
              color: Color(0xFF48544B),
              fontSize: 9,
              fontWeight: FontWeight.w700)),
    );
  }
}
