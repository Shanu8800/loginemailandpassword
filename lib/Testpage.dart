import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
              child: Container(
                child: Row(children: [
                  TextButton( onPressed: (){}, child: Text('   '))

              ],),)),
          Expanded(
            flex: 8,
              child: Text('Bottom'))
        ],
      ),
    );
  }
}
