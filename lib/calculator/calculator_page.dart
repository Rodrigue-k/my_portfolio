import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final List<String> buttomTexts = [];

  String result = "";

  @override
  Widget build(BuildContext context) {
    final screemHeight = MediaQuery.of(context).size.height;
    final screemWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "CALCULATOR",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
              top: screemHeight * 0.060,
              left: screemHeight * 0.020,
              right: screemHeight * 0.020),
          margin: EdgeInsets.symmetric(horizontal: screemHeight * 0.020),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 10),
                    color: Colors.grey,
                    blurRadius: 50,
                    spreadRadius: 10)
              ]),
          //color: Colors.purple[50],
          height: screemHeight * 0.7,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                    )
                  ],
                ),
                height: screemHeight * 0.09,
                width: screemWidth * 1,
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      result == "" ? "0" : result,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screemHeight * 0.02,
              ),
              _buildRow([
                'clr',
                'DEL',
                '%',
                '/',
              ]),
              _buildRow([
                '7',
                '8',
                '9',
                '*',
              ]),
              _buildRow([
                '4',
                '5',
                '6',
                '-',
              ]),
              _buildRow([
                '1',
                '2',
                '3',
                '+',
              ]),
              _buildRow([
                '.',
                '0',
                '=',
              ]),
              SizedBox(
                height: screemHeight * 0.04,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> bTexts) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: bTexts
            .map((bText) => Expanded(
                  flex: bText == "=" ? 2 : 1,
                  child: _buildButton(bText),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: text == "="
            ? Colors.pink
            : text == "DEL"
                ? Colors.red
                : text == "clr"
                    ? Colors.pink
                    : Colors.white,
        minimumSize: const Size(64, 64),
        padding: const EdgeInsets.all(0.2),
        shape: text == "="
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
            : const CircleBorder(),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        softWrap: false,
      ),
    );
  }

  void _onButtonPressed(String input) {
    setState(() {
      if (input == "clr") {
        result = "";
      } else if (input == "DEL") {
        result =
            result.isNotEmpty ? result.substring(0, result.length - 1) : "";
      } else if (input == "=") {
        try {
          result = _calculate(result);
        } catch (e) {
          result = "$e";
        }
      } else {
        result += input;
      }
    });
  }

  String _calculate(String result) {
    Parser p = Parser();
    Expression exp = p.parse(result);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    if (kDebugMode) {
      print(eval);
    }
    return (eval == eval.toInt()) ? eval.toInt().toString() : eval.toString();

    /*final List<String> operations = ["%", "/", "*", "-", "+"];
    final List<String> operationsOrder = [];
    final List<String> s = [];
    final List<double> d = [];
    for (int i = 0; i < operations.length; i++) {
      if (result.contains(operations[i])) {
        s.addAll(result.split(operations[i]));
      }
    }
    for (int i = 0; i < s.length; i++) {
      d.add(double.parse(s[i]));
    }

    return;
  }*/
  }
}
