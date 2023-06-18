import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'logPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: TopPage()
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {

  int currentIndex = 0;
  List<String> numberList = ['0'];
  Operator? operator;
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets. only(right: 12),
                  child: Text(numberList[currentIndex], style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),),
                )
            ),



            Row(
              children: [
                botton(child: buildContent('AC', ColorType.blue),colorType: ColorType.grey, onTap: () {

                  numberList = ['0'];
                  currentIndex = 0;
                  setState(() {

                  });
                }),
                botton(child:Icon(CupertinoIcons.plus_slash_minus, size: 55, color: getTextColor(ColorType.blue)),colorType: ColorType.grey, onTap: () {
                  if(numberList[currentIndex].startsWith('-')){
                    setCurrentNumber(numberList[currentIndex].replaceAll('-', ''));
                  } else {
                    setCurrentNumber('-${numberList[currentIndex]}');
                  }
                }),
                botton(child:Icon(CupertinoIcons.percent, size: 55, color: getTextColor(ColorType.blue)),colorType: ColorType.grey, onTap: () {
                  double cache = double.parse(numberList[currentIndex]) / 100;
                  setCurrentNumber('$cache'.endsWith('0') ? '$cache'.replaceAll('0', ''): '$cache');
                }),
                botton(child:Icon(CupertinoIcons.folder, size: 55, color: getTextColor(ColorType.black)),colorType: ColorType.white, onTap: () => {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => logPage(),
                      ))
                }),
              ],
            ),
            Row(
              children: [
                botton(child: buildContent(7, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(7);

                }),
                botton(child: buildContent(8, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(8);

                }),
                botton(child: buildContent(9, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(9);

                }),
                botton(child:Icon(CupertinoIcons.divide, size: 55, color: getTextColor(ColorType.blue)),colorType: ColorType.orange, onTap: () {
                  operator = Operator.divide;
                  currentIndex++;
                }),
              ],
            ),
            Row(
              children: [
                botton(child: buildContent(4, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(4);

                }),
                botton(child: buildContent(5, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(5);

                }),
                botton(child: buildContent(6, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(6);

                }),
                botton(child:Icon(CupertinoIcons.multiply, size: 55, color: getTextColor(ColorType.blue)),colorType: ColorType.orange, onTap: () {
                  operator = Operator.multiply;
                  currentIndex++;
                }),
              ],
            ),
            Row(
              children: [
                botton(child: buildContent(1, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(1);

                }),
                botton(child: buildContent(2, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(2);

                }),
                botton(child: buildContent(3, ColorType.blue),colorType: ColorType.black, onTap: () {
                  inputNumber(3);

                }),
                botton(child:Icon(CupertinoIcons.minus, size: 55, color: getTextColor(ColorType.blue)),colorType: ColorType.orange, onTap: () {
                  operator = Operator.minus;
                  currentIndex++;
                }),
              ],
            ),
            Row(
              children: [
                botton(child: buildContent(0, ColorType.blue),colorType: ColorType.black,  onTap: () {
                  inputNumber(0);

                }),
                botton(child: buildContent('.', ColorType.blue),colorType: ColorType.black, onTap: () {
                  if(numberList[currentIndex] == '0') {
                    setCurrentNumber('0.');
                  } else if(!numberList.contains('.')) {
                    setCurrentNumber('$numberList.');
                  }
                }),
                botton(child: Icon(CupertinoIcons.equal, size: 55,color: getTextColor(ColorType.black)), colorType: ColorType.grey, onTap: () {
                  calculateTotal();

                }),
                botton(child: Icon(CupertinoIcons.add, size: 55,color: getTextColor(ColorType.blue)), colorType: ColorType.orange, onTap: () {
                  operator = Operator.plus;
                  currentIndex++;
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.only( bottom: 60,),
            ),
          ],
        ),
      ),
    );
  }

  void calculateTotal() {

    if(currentIndex == 1) {
      double resultNumber = 0;
      switch (operator) {

        case Operator.plus:
          resultNumber = double.parse( numberList[0]) + double.parse(numberList[1]);
          break;
        case Operator.minus:
          resultNumber = double.parse( numberList[0]) - double.parse(numberList[1]);
          break;
        case Operator.multiply:
          resultNumber = double.parse( numberList[0]) * double.parse(numberList[1]);
          break;
        case Operator.divide:
          resultNumber = double.parse( numberList[0]) / double.parse(numberList[1]);
          break;
      }
      String resultNumberText = '$resultNumber';
      if(resultNumberText.endsWith('0')) {
        resultNumberText = resultNumberText.replaceAll('.0', '');
      }
      setState(() {
        numberList = [resultNumberText];
        currentIndex = 0;
      });
    }
  }



  void inputNumber(int number) {
    print('$number');
    if(numberList.length == currentIndex) {
      numberList.add('$number');
      setState(() {

      });
    }else {
      if (numberList[currentIndex] == '0') {
        setCurrentNumber('$number');
      } else {
        setCurrentNumber('${numberList[currentIndex]}$number');
      }
    }
  }

  void setCurrentNumber(String number) {
    setState(() {
      numberList[currentIndex] = number;
    });
  }





  Expanded botton({required Widget child, required ColorType colorType, int flex = 1, required Function onTap,onPressed}) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () {
                onTap();
              },

              child: Container(
                decoration: BoxDecoration(
                  color: getBackgroundColor(colorType),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),

                child: AspectRatio(
                  aspectRatio: flex == 1 ? 1: 2,
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Text buildContent(dynamic text, ColorType colorType) {
    String _text;
    if(text is int) {
      _text = '$text';
    } else {
      _text = text;
    }
    // print('テキスト$_text');<=  textに値が入っているか確認するためのprint
    return Text(
      _text,
      style: TextStyle(fontSize: 35, color: getTextColor(colorType)),
    );
  }



  Color getBackgroundColor(ColorType colorType){
    Color _color;
    switch (colorType) {
      case ColorType.grey:
        _color = Colors.grey;
        break;
      case ColorType.orange:
        _color = Colors.orangeAccent;
        break;
      case ColorType.black:
        _color = Colors.white24;
        break;
      case ColorType.blue:
        _color = Colors.blue;
        break;
      case ColorType.white:
        _color = Colors.white;
        break;
    }
    return _color;
  }

  Color getTextColor(ColorType colorType){
    Color _color;
    switch (colorType) {
      case ColorType.grey:
        _color = Colors.grey;
        break;
      case ColorType.orange:
        _color = Colors.orange;
        break;
      case ColorType.black:
        _color = Colors.black;
        break;
      case ColorType.blue:
        _color = Colors.blue;
        break;
      case ColorType.white:
        _color = Colors.white;
        break;
    }
    return _color;
  }
}



enum ColorType {
  grey,
  orange,
  black,
  blue,
  white,
}

enum Operator {
  plus,
  minus,
  multiply,
  divide,
}