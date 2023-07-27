import 'package:flutter/material.dart';
import 'package:tabulador/screens/loan_payments_details_page.dart';
import 'package:tabulador/screens/loan_request_page.dart';

class AppRoutes {
  static const root = '/';
  static const details = '/details';
}

void main() {
  runApp(
    MaterialApp(
      title: 'Routes Tabulator',
      initialRoute: AppRoutes.root,
      routes: {
        AppRoutes.root: (context) => const LoanRequestPage(),
        AppRoutes.details: (context) => const LoanPaymentDetailsPage()
      },
    ),
  );
}
