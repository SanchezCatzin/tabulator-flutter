import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabulador/models/loan.dart';

class LoanRequestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoanRequestPage();
}

class _LoanRequestPage extends State<LoanRequestPage> {
  final TextEditingController _totalLoan = TextEditingController();
  final TextEditingController _montlyPaymentAmount = TextEditingController();
  final TextEditingController _loanTermInMonths = TextEditingController();

  late FocusNode myFocusNode1;
  late FocusNode myFocusNode2;
  late FocusNode myFocusNode3;

  bool monthCheck = false;
  bool loanCheck = false;
  bool paymenCheck = false;

  @override
  void initState() {
    super.initState();

    myFocusNode1 = FocusNode(debugLabel: 'TextField1');
    myFocusNode2 = FocusNode(debugLabel: 'TextField2');
    myFocusNode3 = FocusNode(debugLabel: 'TextField3');

    myFocusNode1.addListener(() {
      if (!myFocusNode1.hasFocus) {
        if (_totalLoan.text != "") {
          loanCheck = true;
        } else {
          loanCheck = false;
        }
      }
    });

    myFocusNode2.addListener(() {
      if (!myFocusNode2.hasFocus) {
        if (_montlyPaymentAmount.text != "") {
          paymenCheck = true;
        } else {
          paymenCheck = false;
        }
      }
    });

    myFocusNode3.addListener(() {
      if (!myFocusNode3.hasFocus) {
        if (_loanTermInMonths.text != "") {
          monthCheck = true;
        } else {
          monthCheck = false;
        }
      }
    });
  }

  @override
  void dispose() {
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tabulador'),
        ),
        body: Column(
          children: <Widget>[
            _createTextField(myFocusNode1, 'Cantidad del préstamo', _totalLoan),
            _createTextField(
                myFocusNode2, 'Pago mensual', _montlyPaymentAmount),
            _createTextField(
                myFocusNode3, 'Duración en meses', _loanTermInMonths),
            ElevatedButton(
                onPressed: () {
                  myFocusNode1.unfocus();
                  myFocusNode2.unfocus();
                  myFocusNode3.unfocus();

                  Future.delayed(Duration.zero, () {
                    print('Loan: ${loanCheck} '
                        'Payment: ${paymenCheck} '
                        'Month: ${monthCheck}');

                    if (monthCheck && loanCheck && paymenCheck) {
                      LoanRequest loanRequest = LoanRequest(
                          double.parse(_totalLoan.text),
                          double.parse(_montlyPaymentAmount.text),
                          int.parse(_loanTermInMonths.text));

                      Navigator.pushNamed(context, '/LoanPaymentsDetails',
                          arguments: loanRequest);
                    }
                  });
                },
                child: Text("Calcular"))
          ],
        ) /*  */
        );
  }

  Widget _createTextField(FocusNode focusNode, String labelText,
      TextEditingController textEditingController) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              labelText,
              textAlign: TextAlign.left,
            ),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
            ),
          ],
        ));
  }
}
