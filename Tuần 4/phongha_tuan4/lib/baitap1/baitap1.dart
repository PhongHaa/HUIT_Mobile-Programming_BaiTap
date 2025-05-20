import 'package:flutter/material.dart';

class BaiTap1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
        backgroundColor: Colors.green,
        actions: [
          Icon(Icons.camera_alt, size: 30), // Icon camera
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          // Phần trên cùng chứa chữ "Button"
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green[100],
            width: double.infinity,
            child: Text(
              'Button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),

          // Nút Gradient + Shadow + Text
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.6),
                    blurRadius: 20,
                    offset: Offset(-5, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  children: [
                    TextSpan(
                      text: "Sinh viên ",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: "FIT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: " - ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "HUIT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
