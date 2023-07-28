class LoanRequest {
  const LoanRequest({
    required this.totalAmount,
    required this.monthlyPaymentAmount,
    required this.termInMonths,
  });

  const LoanRequest.empty()
      : totalAmount = 0,
        monthlyPaymentAmount = 0,
        termInMonths = 0;

  final double totalAmount;
  final double monthlyPaymentAmount;
  final int termInMonths;

  LoanRequest copyWith({
    double? totalAmount,
    double? monthlyPaymentAmount,
    int? termInMonths,
  }) {
    return LoanRequest(
      totalAmount: totalAmount ?? this.totalAmount,
      monthlyPaymentAmount: monthlyPaymentAmount ?? this.monthlyPaymentAmount,
      termInMonths: termInMonths ?? this.termInMonths,
    );
  }

  bool isNotEmpty() {
    return totalAmount != 0 && monthlyPaymentAmount != 0 && termInMonths != 0;
  }

  @override
  String toString() {
    return 'totalAmount: $totalAmount, '
        'monthlyPaymentAmount: $monthlyPaymentAmount, '
        'termInMonths: $termInMonths';
  }
}
