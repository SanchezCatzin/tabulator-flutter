import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tabulador/models/loan.dart';

/* class Item {
  Item(
      {required this.headerText,
      required this.expandedText,
      this.isExpanded = false});

  String headerText;
  String expandedText;
  bool isExpanded;
}

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaymentList();
}

class _PaymentList extends State<PaymentList> {
  final List<Item> _data = List<Item>.generate(10, (int index) {
    return Item(
        headerText: 'Item $index', expandedText: 'This is item number $index');
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerText),
              );
            },
            body: ListTile(
              title: Text(item.expandedText),
              subtitle: const Text('To delete this item, click trash icon'),
              trailing: const Icon(
                Icons.delete,
                color: Colors.orangeAccent,
              ),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
} */

class Payment {
  Payment(this.paymentNumber, this.currentBalance, this.paymentAmount,
      this.nextBalance,
      [this.isExpanded = false]);

  int paymentNumber;
  double currentBalance;
  double paymentAmount;
  double nextBalance;
  bool isExpanded;
}

List<Payment> getPayment(LoanRequest loanRequest) {
  List<Payment> paymentList = [];
  double currentBalance = loanRequest.loan;

  for (var i = 0; i < loanRequest.duration; i++) {
    paymentList.add(Payment(i + 1, currentBalance, loanRequest.monthPayment,
        currentBalance - loanRequest.monthPayment));
    currentBalance -= loanRequest.monthPayment;
  }

  print(paymentList[23].currentBalance);
  return paymentList;
}

class Payments extends StatefulWidget {
  final LoanRequest loanRequest;

  const Payments({Key? key, required this.loanRequest}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<Payment> _payments = [];

  @override
  void initState() {
    super.initState();
    _payments = getPayment(widget.loanRequest);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(child: _renderPayments()),
    );
  }

  Widget _renderPayments() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _payments[index].isExpanded = !isExpanded;
        });
      },
      children: _payments.map<ExpansionPanel>((Payment payment) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('Pago ${payment.paymentNumber}'),
              );
            },
            body: Column(
              children: [
                Text('Numero de pago: ${payment.paymentNumber}'),
                Text('Balance del pago: ${payment.currentBalance}'),
                Text('Cantidad del pago: ${payment.paymentAmount}'),
                Text('Balance siguiente: ${payment.nextBalance}'),
              ],
            ),
            isExpanded: payment.isExpanded);
      }).toList(),
    );
  }
}

/* class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step('Step 0: Install Flutter',
        'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Create a project',
        'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Run the app',
        'Change your terminal directory to the project directory, enter `flutter run`.'),
  ];
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Pago ${payment.title}'),
            );
          },
          body: ListTile(
            title: Text('Deuda actual ${step.body}'),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
} */

class LoanPaymentDetails extends StatefulWidget {
  const LoanPaymentDetails({super.key});

  @override
  State<StatefulWidget> createState() => _LoanPaymentDetails();
}

class _LoanPaymentDetails extends State<LoanPaymentDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LoanRequest;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Listado de pagos"),
        ),
        body: Payments(loanRequest: args));
  }
}
