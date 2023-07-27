class Payment {
  const Payment({
    required this.index,
    required this.currentBalance,
    required this.amount,
    required this.nextBalance,
  });

  final int index;
  final double currentBalance;
  final double amount;
  final double nextBalance;
}
