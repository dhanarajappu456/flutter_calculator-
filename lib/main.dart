import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calcy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SimpleCalculator> {
  String equaiton = '0';
  String result = '0';
  String expression = "";
  double equationfont = 38;
  double resultfont = 40;

  expi(String buttonText) {
    setState(() {
      if (buttonText == 'back') {
        equaiton = equaiton.substring(0, equaiton.length - 1);
        equationfont = 38;
        resultfont = 38;
      } else if (buttonText == 'C') {
        equaiton = '0';
        result = '0';
        equationfont = 38;
        resultfont = 38;
      } else if (buttonText == '=') {
        equationfont = 38;
        resultfont = 40;
        try {
          expression = equaiton;
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equaiton = '0';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equaiton == '0') {
          equaiton = buttonText;
          equationfont = 38;
          resultfont = 38;
        } else {
          equaiton = equaiton + buttonText;
        }
        equationfont = 38;
        resultfont = 38;
      }
    });
  }

  Widget buttonBuild(String buttonText, double buttonHeight, Color buttoColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttoColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => expi(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.8,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCY'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              equaiton,
              style: TextStyle(fontSize: equationfont),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultfont),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buttonBuild("C", 1, Colors.redAccent),
                        buttonBuild("<<", 1, Colors.blue),
                        buttonBuild("/", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild("7", 1, Colors.black54),
                        buttonBuild("8", 1, Colors.black54),
                        buttonBuild("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild("4", 1, Colors.black54),
                        buttonBuild("5", 1, Colors.black54),
                        buttonBuild("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild("1", 1, Colors.black54),
                        buttonBuild("2", 1, Colors.black54),
                        buttonBuild("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild(".", 1, Colors.black54),
                        buttonBuild("0", 1, Colors.black54),
                        buttonBuild("00", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [buttonBuild('+', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buttonBuild('-', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buttonBuild('*', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buttonBuild('=', 2, Colors.redAccent)],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
