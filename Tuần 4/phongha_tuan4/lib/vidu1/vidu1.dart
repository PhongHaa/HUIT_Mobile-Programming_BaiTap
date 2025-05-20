import 'package:flutter/material.dart';

class Vidu1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lập trình di động"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hàng đầu tiên - 2 ô đỏ
            Row(
              children: [
                Expanded(child: buildBox(Colors.red)),
                SizedBox(width: 16),
                Expanded(child: buildBox(Colors.red)),
              ],
            ),
            SizedBox(height: 16),

            // Hàng thứ hai - 1 ô xanh dương lớn
            buildBox(Colors.blue, height: 120),

            SizedBox(height: 16),

            // Hàng thứ ba - 2 ô xanh ngọc
            Row(
              children: [
                Expanded(child: buildBox(Colors.cyan)),
                SizedBox(width: 16),
                Expanded(child: buildBox(Colors.cyan)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBox(Color color, {double height = 80}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
