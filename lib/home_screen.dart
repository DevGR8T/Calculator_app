import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List buttons = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    'C',
    '='
  ];

  var userInput = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: size.height / 2.65,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    result,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                color: Colors.black,
                width: double.infinity,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            userInput = '';
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            buttons[index],
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      );
                    } else if (index == 19) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            equalpressed();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            buttons[index],
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      );
                    } else if (index == 18) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            buttons[index],
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            buttons[index],
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: getcolor(buttons[index])
                                    ? Colors.green
                                    : Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                )),
          )
        ]),
      ),
    );
  }

  bool getcolor(String text) {
    if (text == '(' ||
        text == ')' ||
        text == '/' ||
        text == 'x' ||
        text == '-' ||
        text == '+' ||
        text == '=') {
      return true;
    }
    return false;
  }

  void equalpressed() {
    String finalinput = userInput;
    finalinput = finalinput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    result = eval.toString();
  }
}
