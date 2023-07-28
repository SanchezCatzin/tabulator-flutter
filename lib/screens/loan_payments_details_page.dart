import 'package:flutter/material.dart';

import '../models/loan_request.dart';
import '../models/payment.dart';

const pageTitle = 'Listado de pagos';

class LoanPaymentDetailsPage extends StatelessWidget {
  const LoanPaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final loanRequest = arguments as LoanRequest;

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
      ),
      body: PaymentsList(loanRequest: loanRequest),
    );
  }
}

class PaymentsList extends StatefulWidget {
  final LoanRequest loanRequest;

  const PaymentsList({Key? key, required this.loanRequest}) : super(key: key);

  @override
  State<PaymentsList> createState() => _PaymentsListState();
}

class _PaymentsListState extends State<PaymentsList> {
  List<Payment> _payments = [];
  final Map<int, bool> _expandedIndexes = {};

  @override
  void initState() {
    super.initState();
    _payments = PaymentsListDataGenerator.generatePaymentsFrom(
      widget.loanRequest,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            final paymentIndex = _payments[index].index;
            _expandedIndexes[paymentIndex] = !isExpanded;
          });
        },
        children: _payments.map(
          (payment) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text('Pago ${payment.index}'),
                );
              },
              body: PaymentListTileData(payment: payment),
              isExpanded: _expandedIndexes[payment.index] ?? false,
            );
          },
        ).toList(),
      ),
    );
  }
}

class PaymentListTileData extends StatelessWidget {
  const PaymentListTileData({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    //TODO: Remove magic strings.
    return Column(
      children: [
        Text('Numero de pago: ${payment.index}'),
        Text('Balance del pago: ${payment.currentBalance}'),
        Text('Cantidad del pago: ${payment.amount}'),
        Text('Balance siguiente: ${payment.nextBalance}'),
      ],
    );
  }
}

class PaymentsListDataGenerator {
  static List<Payment> generatePaymentsFrom(LoanRequest loanRequest) {
    List<Payment> paymentList = [];
    double currentBalance = loanRequest.totalAmount;

    for (var i = 0; i < loanRequest.termInMonths; i++) {
      paymentList.add(
        Payment(
          index: i + 1,
          currentBalance: currentBalance,
          amount: loanRequest.monthlyPaymentAmount,
          nextBalance: currentBalance - loanRequest.monthlyPaymentAmount,
        ),
      );
      currentBalance -= loanRequest.monthlyPaymentAmount;
    }
    return paymentList;
  }
}
