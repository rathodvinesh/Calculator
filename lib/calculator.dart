import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CaclulatorPage());
}

class CaclulatorPage extends StatefulWidget {
  const CaclulatorPage({super.key});

  @override
  State<CaclulatorPage> createState() => _CaclulatorPageState();
}

class _CaclulatorPageState extends State<CaclulatorPage> {
  String eqn = '0';
  String res = '0';
  String expression = '';

  buttonClicked(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        eqn = '0';
        res = '0';
        expression = '';
      } else if (btnText == 'Del') {
        eqn = eqn.substring(0, eqn.length - 1);
        if (eqn == '') {
          eqn = '0';
        }
      } else if (btnText == '=') {
        expression = eqn;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          res = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          res = 'Error';
        }
      } else {
        if (eqn == '0') {
          eqn = '';
        }
        eqn = eqn + btnText;
      }
    });
  }

  Widget buildButton(String btnText, double btnWidth,Color btnColor) {
    return InkWell(
      onTap: () {
        buttonClicked(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90), color: btnColor),
        child: Text(btnText,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator", style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),backgroundColor: Colors.orange,),
      body: Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              height: 90,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Text(
                  eqn,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              height: 90,
              width: double.infinity,
              child: Text(
                res,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
        
                buildButton("AC", 80,Colors.orange[400]!),
                buildButton("Del", 80,Colors.red[500]!),
                buildButton("%", 80,Colors.orange[400]!),
                buildButton("/", 80,Colors.orange[400]!),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton("7", 80,Colors.white),
                buildButton("8", 80,Colors.white),
                buildButton("9", 80,Colors.white),
                buildButton("*", 80,Colors.orange[400]!),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton("4", 80,Colors.white),
                buildButton("5", 80,Colors.white),
                buildButton("8", 80,Colors.white),
                buildButton("-", 80,Colors.orange[400]!),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton("1", 80,Colors.white),
                buildButton("2", 80,Colors.white),
                buildButton("3", 80,Colors.white),
                buildButton("+", 80,Colors.orange[400]!),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton("0", 160,Colors.orange[400]!),
                buildButton(".", 80,Colors.white),
                buildButton("=", 80,Colors.orange[400]!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
