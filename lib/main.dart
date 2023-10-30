import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants/constants.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var inputUser = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 28.0,
                            color: textGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 40.0,
                            color: textGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('AC', 'CE', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: getBackgroundColor(text1)),
            onPressed: () {
              if (text1 == 'AC') {
                setState(() {
                  inputUser = '';
                  result = '';
                });
              } else {
                buttonPressed(text1);
              }
            },
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 26.0,
                color: getTextColor(text1),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: getBackgroundColor(text2)),
            onPressed: () {
              if (text2 == 'CE') {
                setState(() {
                  if (inputUser.length > 0) {
                    inputUser = inputUser.substring(0, inputUser.length - 1);
                  }
                });
              } else {
                buttonPressed(text2);
              }
            },
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 26.0,
                color: getTextColor(text2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: getBackgroundColor(text3)),
            onPressed: () {
              buttonPressed(text3);
            },
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 26.0,
                color: getTextColor(text3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: getBackgroundColor(text4),
            ),
            onPressed: () {
              if (text4 == '=') {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contexModel = ContextModel();
                double eval =
                    expression.evaluate(EvaluationType.REAL, contexModel);

                setState(() {
                  result = eval.toString();
                });
              } else {
                buttonPressed(text4);
              }
            },
            child: Text(
              text4,
              style: TextStyle(
                fontSize: 26.0,
                color: getTextColor(text4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var list = ['AC', 'CE', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (item == text) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      if (text == 'AC') {
        return backgroundOrange;
      } else if (text == '=') {
        return backgroundGreen;
      } else {
        return backgroundGreyBlue;
      }
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      if (text == 'AC') {
        return Colors.white;
      } else {
        return Colors.white;
      }
    } else {
      return textGrey;
    }
  }
}
