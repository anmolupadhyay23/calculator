import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  dynamic displayText=20;
  // buttons
  Widget buttons(String btntxt, Color btncolor, Color textcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 25,
            color: textcolor,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(btncolor),
          // Figure out why colors is not showing and how to change colors
          // shadowColor: MaterialStateProperty.all(btncolor),
          padding: MaterialStateProperty.all(EdgeInsets.all(20.0))
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('CALCULATOR'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // calling buttons
                buttons('AC', Colors.white30, Colors.black),
                buttons('+/-', Colors.white30, Colors.black),
                buttons('%', Colors.white30, Colors.black),
                buttons('/', Colors.amber, Colors.black)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // calling buttons
                buttons('7', Colors.grey, Colors.black),
                buttons('8', Colors.grey, Colors.black),
                buttons('9', Colors.grey, Colors.black),
                buttons('x', Colors.amber, Colors.black)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // calling buttons
                buttons('4', Colors.grey, Colors.black),
                buttons('5', Colors.grey, Colors.black),
                buttons('6', Colors.grey, Colors.black),
                buttons('+', Colors.amber, Colors.black)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // calling buttons
                buttons('1', Colors.grey, Colors.black),
                buttons('2', Colors.grey, Colors.black),
                buttons('3', Colors.grey, Colors.black),
                buttons('-', Colors.amber, Colors.black)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // calling buttons
                buttons('', Colors.grey, Colors.black),
                buttons('0', Colors.grey, Colors.black),
                buttons('.', Colors.grey, Colors.black),
                buttons('=', Colors.amber, Colors.black)
              ],
            ),
          ],
        ),
      ),
   );

  }

  // logic for calculator
  dynamic num1=0;
  dynamic num2=0;
  dynamic finalresult='';
  dynamic opr='';
  dynamic preopr='';
  dynamic result='';
  dynamic text='0';

  void calculation(btnText) {
    if (btnText == 'AC') {
      num1 = 0;
      num2 = 0;
      finalresult = '0';
      opr = '';
      preopr = '';
    }
    else if (btnText == '=' && opr == '=') {
      if (preopr == '+') {
        finalresult = add();
      }
      else if (preopr == '-') {
        finalresult = sub();
      }
      else if (preopr == 'x') {
        finalresult = mul();
      }
      else if (preopr == '/') {
        finalresult = div();
      }
    }
    else
    if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      }
      else {
        num2 = double.parse(result);
      }

      if (opr == '+') {
        finalresult = add();
      }
      else if (opr == '-') {
        finalresult = sub();
      }
      else if (opr == 'x') {
        finalresult = mul();
      }
      else if (opr == '/') {
        finalresult = div();
      }

      preopr = opr;
      opr = btnText;
      result = '';
    }
    else if (btnText == '%') {
      result = num1 / 100;
      finalresult = decimal_string(result);
    }
    else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalresult = result;
    }
    else if (btnText == '+/-') {
      result.toString().startsWith('-') ?
      result = result.toString().substring(1) : result =
          '-' + result.toString();
      finalresult = result;
    }
    else {
      result = result + btnText;
      finalresult = result;
    }

    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return decimal_string(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return decimal_string(result);
  }
  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return decimal_string(result);
  }
  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return decimal_string(result);
  }

  String decimal_string(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}


