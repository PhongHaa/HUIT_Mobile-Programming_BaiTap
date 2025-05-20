import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDemoScreen(),
    );
  }
}

class GestureDemoScreen extends StatefulWidget {
  @override
  _GestureDemoScreenState createState() => _GestureDemoScreenState();
}

class _GestureDemoScreenState extends State<GestureDemoScreen> {
  bool isDropped = false;
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPress: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Long Press Detected!")));
              },
              child: _buildLongPressItem(),
            ),
            SizedBox(height: 20),
            Draggable<Widget>(
              data: Container(),
              child: _buildDraggableItem(Colors.red),
              feedback: _buildDraggableItem(Colors.red.withOpacity(0.5)),
              childWhenDragging: _buildDraggableItem(Colors.grey),
            ),
            SizedBox(height: 20),
            DragTarget<Widget>(
              onWillAccept: (data) => true,
              onAccept: (data) {
                setState(() {
                  isDropped = true;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: isDropped ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(75),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isDropped ? "Success!" : "Drop Here",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _position += details.delta;
                });
              },
              child: Transform.translate(
                offset: _position,
                child: _buildPanItem(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onScaleStart: (details) {
                _previousScale = _scale;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = _previousScale * details.scale;
                });
              },
              onScaleEnd: (details) {
                _previousScale = 1.0;
              },
              child: Transform.scale(scale: _scale, child: _buildScaleItem()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLongPressItem() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text("Long Press", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildDraggableItem(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: Text("Drag Me", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildPanItem() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text("Pan Me", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildScaleItem() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(s
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text("Scale Me", style: TextStyle(color: Colors.white)),
    );
  }
}
