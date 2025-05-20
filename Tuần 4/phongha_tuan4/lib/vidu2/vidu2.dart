import 'package:flutter/material.dart';

class Vidu2Screen extends StatelessWidget {
  const Vidu2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack demo"),
        backgroundColor: const Color.fromARGB(255, 239, 168, 4),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context); // Quay lại menu chính
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40),
              image: const DecorationImage(
                image: AssetImage('assets/images/dong-phong-nha.webp'), // Sửa đường dẫn ảnh
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Động Phong Nha",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Động Phong Nha, nằm trong vườn quốc gia Phong Nha - Kẻ Bàng, tỉnh Quảng Bình, Việt Nam, là một trong những hang động nổi tiếng và hấp dẫn nhất trên thế giới.",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
