import 'package:flutter/material.dart';
import 'vidu1/vidu1.dart';
import 'vidu2/vidu2.dart';
import 'baitap1/baitap1.dart';
import 'baitap2/baitap2.dart';
import 'baitap3/baitap3.dart';
import 'baitap4/baitap4.dart';
import 'baitap5/baitap5.dart';
import 'baitap6/baitap6.dart';
import 'baitap7/baitap7.dart';

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
          buildMenuItem(context, "Bài tập 2", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap2Screen()))),
          buildMenuItem(context, "Bài tập 3", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap3Screen()))),
          buildMenuItem(context, "Bài tập 4", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap4Screen()))),
          buildMenuItem(context, "Bài tập 5", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap5Screen()))),
          buildMenuItem(context, "Bài tập 6", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap6Screen()))),
          buildMenuItem(context, "Bài tập 7", () => Navigator.push(context, MaterialPageRoute(builder: (context) => BaiTap7Screen()))),
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
