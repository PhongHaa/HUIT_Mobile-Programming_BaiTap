import 'package:flutter/material.dart';

class Tuan5Bai1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('ListView Demo'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước đó
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chọn loại đề tài
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8),
            child: Text(
              'Chọn loại đề tài',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Đồ án', 'KLKS', 'Luận văn', 'Khác']
                  .map((text) => Chip(
                        label: Text(text, style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.purple,
                      ))
                  .toList(),
            ),
          ),
          // Chọn chuyên ngành thực hiện
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8),
            child: Text(
              'Chọn chuyên ngành thực hiện',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListTile('Công nghệ phần mềm', 'Phát triển ứng dụng thực tế'),
                _buildListTile('Hệ thống thông tin', 'Xử lý thông tin trong tổ chức'),
                _buildListTile('Mạng máy tính', 'Xử lý các vấn đề về mạng'),
                _buildListTile('An toàn thông tin', 'Bảo mật hệ thống máy tính'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      leading: Icon(Icons.home, color: Colors.brown),
      title: Text(title, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      tileColor: Colors.grey[200],
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
