import 'package:flutter/material.dart';
import 'package:tabulador/screens/loan_payment_Details.dart';
import 'package:tabulador/screens/loan_request_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Routes Tabulator',
    initialRoute: '/',
    routes: {
      '/': (context) => LoanRequestPage(),
      '/LoanPaymentsDetails': (context) => LoanPaymentDetails()
    },
  ));
}
