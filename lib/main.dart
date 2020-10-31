import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Work",
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  MyCalculator({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  //ประกาศตัวแปร
  String answer;
  String answerTemp;
  String inputFull;
  String operator;
  bool calculateMode;

  //ตัวแปรใน State
  @override
 void initState() {
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    calculateMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arnont Photdoung 6130613011"),
      ),
      body: Column(
        children: <Widget>[
          buildAnswerWidget(),
          buildNumPadWidget(),
        ],
      ),
    );
  }

  // widget แสดงหน้าจอ
  Widget buildAnswerWidget() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xffdbdbdb),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(inputFull + " " + operator, style: TextStyle(fontSize: 18)),
                      Text(answer,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold))
                    ]))));
  }
// สร้างปุ่มกด
  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffecf0f1),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("-", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("x", numberButton: false, onTap: () {
                addOperatorToAnswer("x");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
              buildNumberButton("/", numberButton: false, onTap: () {
                addOperatorToAnswer("/");
              }),
            ]),
          ],
        ));
  }
// รับค้าตัวเลข
  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }
// เคลียคำตอบ อยู่ใน "C"
  void clearAll() {
    setState(() {
      answer = "0";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }

// รับค่าสัญลักษณ์ที่ไม่ใช่ตัวเลข
  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = "0";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          inputFull = "";
          operator = "";
        } else {
          operator = op;
        }
      }
    });
  }
 // ประมวลผลลัพธ์
  void calculate() {
    setState(() {
      if (calculateMode) {
        bool decimalMode = false;
        double value = 0;
        if (answer.contains(".") || answerTemp.contains(".")) {
          decimalMode = true;
        }

        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "x") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "/") {
          value = (double.parse(answerTemp) / double.parse(answer));
        }

        if (!decimalMode) {
          answer = value.toInt().toString();
        } else {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";
      }
    });
  }
// ปุ่มกด
  Expanded buildNumberButton(String str,
      {@required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = GestureDetector(
          onTap: onTap,
          child: Container(
              color: Colors.white,
              height: 100,
              child: Center(
                  child: Text(str,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)))));
    } else {
      widget = GestureDetector(
          onTap: onTap,
          child: Container(
              color: Colors.white,
              height: 100,
              child: Center(
                  child: Text(str,
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)))));
    }
    return Expanded(child: widget);
  }
}
