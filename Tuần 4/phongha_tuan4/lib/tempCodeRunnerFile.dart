import 'package:flutter/material.dart';
import 'vidu1/vidu1.dart';
import 'vidu2/vidu2.dart';
import 'baitap1/baitap1.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chọn Ví Dụ / Bài Tập")),
      body: ListView(
        children: [
          buildMenuItem(context, "Ví dụ 1", () => Navigator.push(context, MaterialPageRoute(builder: (context) => Vidu1Screen()))),
          buildMenuItem(context, "Ví dụ 2", () => Navigator.push(context, MaterialPageRoute(builder: (context) => Vidu2Screen()))),
          buildMenuItem(context, "Bài tập 1", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap1Screen()))),
        ],
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
