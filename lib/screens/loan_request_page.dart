import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabulador/models/loan_request.dart';

import '../main.dart';

const totalLoanAmountLabel = 'Cantidad del préstamo';
const monthlyPaymentAmountLabel = 'Pago mensual';
const termInMonthsLabel = 'Duración en meses';
const pageTitle = 'Detalles del Préstamo';
const mainButtonLabel = 'Calcular';
const clearButtonLabel = 'Reiniciar';

class LoanRequestPage extends StatefulWidget {
  const LoanRequestPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoanRequestPage();
}

class _LoanRequestPage extends State<LoanRequestPage> {
  bool isMainButtonEnabled = false;
  LoanRequest loanRequest = const LoanRequest.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
      ),
      body: Column(
        children: [
          _InputField(
            initialValue: loanRequest.totalAmount.toString(),
            label: totalLoanAmountLabel,
            onInputFieldListener: (value) {
              _updateMainButtonEnabledValue(() {
                double newValue = 0;
                if (value.isNotEmpty) {
                  newValue = double.parse(value);
                }
                return loanRequest.copyWith(
                  totalAmount: newValue,
                );
              });
            },
          ),
          _InputField(
            initialValue: loanRequest.monthlyPaymentAmount.toString(),
            label: monthlyPaymentAmountLabel,
            onInputFieldListener: (value) {
              _updateMainButtonEnabledValue(() {
                double newValue = 0;
                if (value.isNotEmpty) {
                  newValue = double.parse(value);
                }
                return loanRequest.copyWith(
                  monthlyPaymentAmount: newValue,
                );
              });
            },
          ),
          _InputField(
            initialValue: loanRequest.termInMonths.toString(),
            label: termInMonthsLabel,
            onInputFieldListener: (value) {
              _updateMainButtonEnabledValue(() {
                int newValue = 0;
                if (value.isNotEmpty) {
                  newValue = int.parse(value);
                }
                return loanRequest.copyWith(
                  termInMonths: newValue,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: isMainButtonEnabled ? _onCalculateTapped : null,
              child: const Text(mainButtonLabel),
            ),
          ),
        ],
      ),
    );
  }

  void _updateMainButtonEnabledValue(
    LoanRequest Function() callback,
  ) {
    setState(() {
      loanRequest = callback.call();
      isMainButtonEnabled = loanRequest.isNotEmpty();
    });
  }

  void _resetForm() {
    _updateMainButtonEnabledValue(
      () => const LoanRequest.empty(),
    );
  }

  void _onCalculateTapped() {
    if (loanRequest.isNotEmpty()) {
      Navigator.pushNamed(
        context,
        AppRoutes.details,
        arguments: loanRequest,
      );
      _resetForm();
    }
  }
}

typedef OnInputFieldListener = Function(String);

class _InputField extends StatefulWidget {
  const _InputField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onInputFieldListener,
  }) : super(key: key);

  final String label;
  final String initialValue;
  final OnInputFieldListener onInputFieldListener;

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.left,
          ),
          TextFormField(
            initialValue: widget.initialValue,
            onChanged: widget.onInputFieldListener,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
