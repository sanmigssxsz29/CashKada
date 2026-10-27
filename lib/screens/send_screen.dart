import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/currency.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({
    required this.walletBalance,
    required this.onSend,
    super.key,
  });

  final double walletBalance;
  final ValueChanged<Map<String, dynamic>> onSend;

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final recipient = _recipientController.text.trim();
    final amount = double.parse(_amountController.text.trim());
    final note = _noteController.text.trim().isEmpty
        ? 'Transfer'
        : _noteController.text.trim();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To: $recipient'),
            const SizedBox(height: 8),
            Text('Note: $note'),
            const SizedBox(height: 8),
            Text('Amount: ${formatPeso(amount)}'),
            const SizedBox(height: 10),
            const Text(
              'Demo only. No real transfer is processed.',
              style: TextStyle(color: muted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Edit'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onSend({
                'recipient': recipient,
                'amount': amount,
                'note': note,
              });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

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
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE8EDE8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SEND MONEY',
                  style: TextStyle(
                    color: muted,
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Available balance: ${formatPeso(widget.walletBalance)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _recipientController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Recipient mobile number',
                    prefixText: '+63 ',
                    hintText: '9XX XXX XXXX',
                  ),
                  validator: (value) {
                    final number = (value ?? '').replaceAll(RegExp(r'\s+'), '');
                    if (!RegExp(r'^9\d{9}$').hasMatch(number)) {
                      return 'Enter a valid 10-digit mobile number starting with 9';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '₱ ',
                    hintText: '0.00',
                  ),
                  validator: (value) {
                    final amount = double.tryParse(value ?? '');
                    if (amount == null ||
                        amount < 10 ||
                        amount > widget.walletBalance) {
                      return 'Enter an amount between ₱10 and your balance';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note (optional)',
                    hintText: 'School allowance',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Review transfer'),
                    style: FilledButton.styleFrom(
                      backgroundColor: cashGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
