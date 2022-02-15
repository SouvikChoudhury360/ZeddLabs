import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

final List<String> cardData = ['card 1', 'card 2', 'card 3'];
List<String> cardDataChangeable = cardData;

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const title = 'Zedd Labs Assignment';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: ListView(children: cardDataChangeable.map(_buildItem).toList()),
        ),
      ),
    );
  }

  Widget _buildItem(String data) {
    return TestProxy(
      key: ValueKey(data),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              if (cardDataChangeable.length == 1) {
                cardDataChangeable.remove(data);
                cardDataChangeable = cardData;
                super.reassemble();
              } else {
                cardDataChangeable.remove(data);
              }
            });
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
