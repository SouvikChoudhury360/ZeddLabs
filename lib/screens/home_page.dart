import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final cardData = <String>['card 1', 'card 2', 'card 3'];
var cardDataChangeable = <String>['card 1', 'card 2', 'card 3'];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const title = 'Zedd Labs Assignment';
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView(children: cardDataChangeable.map(_buildItem).toList()));
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
          height: 80.0,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: Center(
            child: Text(data),
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
