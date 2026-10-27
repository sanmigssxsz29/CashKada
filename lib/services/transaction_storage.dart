import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

class TransactionStorage {
  static const String _transactionsKey = 'cashkada_transactions';
  static const String _balanceKey = 'cashkada_wallet_balance';

  Future<List<AppTransaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_transactionsKey) ?? const <String>[];

    return stored
        .map((item) => AppTransaction.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<double> loadWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_balanceKey) ?? 12450;
  }

  Future<void> saveTransactions(
    List<AppTransaction> transactions,
    double balance,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();

    await prefs.setStringList(_transactionsKey, encoded);
    await prefs.setDouble(_balanceKey, balance);
  }
}
