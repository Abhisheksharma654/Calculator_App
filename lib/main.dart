import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'colors.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: calculator(),
  ));
}

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
//variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith("0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputsize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideinput ? '' : input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: outputsize,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgcolor: operatorColor,
                  tcolor: oragneColor),
              button(
                  text: "<", buttonBgcolor: operatorColor, tcolor: oragneColor),
              button(text: "", buttonBgcolor: Colors.transparent),
              button(
                  text: "/", buttonBgcolor: operatorColor, tcolor: oragneColor),
            ],
          ),
          Row(
            children: [
              button(text: "7", tcolor: Colors.black),
              button(text: "8", tcolor: Colors.black),
              button(text: "9", tcolor: Colors.black),
              button(
                  text: "x", buttonBgcolor: operatorColor, tcolor: oragneColor)
            ],
          ),
          Row(
            children: [
              button(text: "4", tcolor: Colors.black),
              button(text: "5", tcolor: Colors.black),
              button(text: "6", tcolor: Colors.black),
              button(
                  text: "-", buttonBgcolor: operatorColor, tcolor: oragneColor)
            ],
          ),
          Row(
            children: [
              button(text: "1", tcolor: Colors.black),
              button(text: "2", tcolor: Colors.black),
              button(text: "3", tcolor: Colors.black),
              button(
                  text: "+", buttonBgcolor: operatorColor, tcolor: oragneColor)
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonBgcolor: operatorColor, tcolor: oragneColor),
              button(
                text: "0",
                tcolor: Colors.black,
              ),
              button(text: ".", tcolor: Colors.black),
              button(text: "=", buttonBgcolor: oragneColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, buttonBgcolor = buttonColor}) {
    return Container(
      margin: const EdgeInsets.all(11),
      child: Expanded(
        child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              padding: const EdgeInsets.all(25),
              primary: buttonBgcolor),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: tcolor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
