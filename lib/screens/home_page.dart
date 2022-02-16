import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final cardData = <String>['Card 1', 'Card 2', 'Card 3'];
var cardDataChangeable = <String>['Card 1', 'Card 2', 'Card 3'];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const title = 'Zedd Labs Assignment';
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF150050),
          title: Center(child: const Text(title, style: TextStyle(color: Color(0xFFFEFBF3)),)),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF3F0071),
          child: ListView(children: cardDataChangeable.map(_buildItem).toList())));
  }

  Widget _buildItem(String data) {
    return TestProxy(
      key: ValueKey(data),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            if (cardDataChangeable.length == 1) {
              setState(() {
                cardDataChangeable.addAll(cardData);
                cardDataChangeable.removeAt(0);
              });
            } else {
              setState(() {
                cardDataChangeable.remove(data);
              });
            }
          } else {
            setState(() {
              cardDataChangeable.remove(data);
              cardDataChangeable.insert(0, data);
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 160.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0x4D000000),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xCC3F0071)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(data, style: TextStyle(color: Color(0xFFFEFBF3), fontSize: 36,),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.arrow_upward_sharp, color: Colors.green),
                        Text('Swipe Left', style: TextStyle(color: Color(0xFFFEFBF3), fontSize: 15,),),
                      ],
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.close, color: Colors.red,),
                        SizedBox(height: 8.0),
                        Text('Swipe Right', style: TextStyle(color: Color(0xFFFEFBF3), fontSize: 15,),),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestProxy extends SingleChildRenderObjectWidget {
  TestProxy({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('createRenderObject $key');
    return RenderProxyBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    print('updateRenderObject $key');
  }
}
