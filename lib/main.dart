import 'package:flutter/material.dart';

import 'models/payment_category.dart';
import 'models/transaction.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pay_screen.dart';
import 'screens/send_screen.dart';
import 'screens/wallet_screen.dart';
import 'services/transaction_storage.dart';
import 'theme/app_colors.dart';
import 'widgets/app_navigation.dart';

void main() {
  runApp(const CashKadaApp());
}

class CashKadaApp extends StatelessWidget {
  const CashKadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashKada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cashGreen,
          primary: cashGreen,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: ink,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
          titleLarge: TextStyle(
            color: ink,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(color: ink, fontSize: 13),
          bodySmall: TextStyle(color: muted, fontSize: 11),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Color(0xFFA7B0A9), fontSize: 12),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE4EAE5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE4EAE5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: cashGreen, width: 1.4),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  double _walletBalance = 12450;
  final List<AppTransaction> _transactions = [];
  final bool _isReady = true;

  @override
  void initState() {
    super.initState();
    _transactions.addAll(_defaultTransactions());
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    final storage = TransactionStorage();
    final savedTransactions = await storage.loadTransactions();
    final savedBalance = await storage.loadWalletBalance();

    if (!mounted) return;

    setState(() {
      _transactions
        ..clear()
        ..addAll(savedTransactions.isEmpty
            ? _defaultTransactions()
            : savedTransactions);
      _walletBalance = savedBalance;
    });
  }

  Future<void> _persistState() async {
    if (!_isReady) return;
    final storage = TransactionStorage();
    await storage.saveTransactions(_transactions, _walletBalance);
  }

  List<AppTransaction> _defaultTransactions() {
    final now = DateTime.now();
    return [
      AppTransaction(
        id: 'tx-1',
        title: 'Meralco Bill',
        category: 'Bill Payment',
        amount: 1840,
        date: now.subtract(const Duration(days: 2)),
        status: 'Completed',
        type: 'Payment',
      ),
      AppTransaction(
        id: 'tx-2',
        title: 'Globe Load',
        category: 'Mobile Load',
        amount: 300,
        date: now.subtract(const Duration(days: 4)),
        status: 'Completed',
        type: 'Load',
      ),
      AppTransaction(
        id: 'tx-3',
        title: 'Shopee Order',
        category: 'Online Shopping',
        amount: 1250,
        date: now.subtract(const Duration(days: 8)),
        status: 'Completed',
        type: 'Payment',
      ),
    ];
  }

  void _handlePayment(Map<String, dynamic> data) {
    setState(() {
      final amount = (data['amount'] as num).toDouble();
      _walletBalance = (_walletBalance - amount).clamp(0, double.infinity);
      _transactions.insert(
        0,
        AppTransaction(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: data['title'] as String? ?? 'Payment',
          category: data['category'] as String? ?? 'General',
          amount: amount,
          date: DateTime.now(),
          status: 'Completed',
          type: data['type'] as String? ?? 'Payment',
        ),
      );
    });
    _persistState();
  }

  void _handleSend(Map<String, dynamic> data) {
    setState(() {
      final amount = (data['amount'] as num).toDouble();
      _walletBalance = (_walletBalance - amount).clamp(0, double.infinity);
      _transactions.insert(
        0,
        AppTransaction(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: 'Send to ${data['recipient']}',
          category: 'Send Money',
          amount: amount,
          date: DateTime.now(),
          status: 'Completed',
          type: 'Send',
        ),
      );
    });
    _persistState();
  }

  String get _screenTitle {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Pay';
      case 2:
        return 'Send';
      case 3:
        return 'History';
      case 4:
        return 'Wallet';
      default:
        return 'CashKada';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
          balance: _walletBalance,
          transactions: _transactions.map((tx) {
            final category = tx.category == 'Send Money'
                ? PaymentCategory.other
                : tx.category == 'Bill Payment'
                    ? PaymentCategory.billPayment
                    : tx.category == 'Mobile Load'
                        ? PaymentCategory.mobileLoad
                        : tx.category == 'Online Shopping'
                            ? PaymentCategory.onlineShopping
                            : PaymentCategory.other;

            return PaymentRecord(
              category: category,
              description: tx.title,
              amount: tx.amount,
              date: tx.date,
            );
          }).toList()),
      PayScreen(
        walletBalance: _walletBalance,
        onPayment: _handlePayment,
      ),
      SendScreen(
        walletBalance: _walletBalance,
        onSend: _handleSend,
      ),
      HistoryScreen(transactions: _transactions),
      WalletScreen(
        walletBalance: _walletBalance,
        transactions: _transactions,
      ),
    ];

    return Scaffold(
      backgroundColor: canvas,
      body: Column(
        children: [
          CashKadaHeader(title: _screenTitle),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CashKadaBottomNav(
        selectedIndex: _selectedIndex,
        onSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
