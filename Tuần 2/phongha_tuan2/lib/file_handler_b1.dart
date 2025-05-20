import 'dart:io';
import 'phong.dart';

class FileHandler {
  static List<Phong> docDanhSachPhong(String filePath) {
    List<Phong> danhSachPhong = [];

    try {
      List<String> lines = File(filePath).readAsLinesSync();

      for (var line in lines) {
        List<String> parts = line.split('#');
        if (parts.isNotEmpty) {
          if (parts[0].startsWith('A')) {
            danhSachPhong.add(
              PhongA(
                parts[0],
                int.parse(parts[1]),
                int.parse(parts[2]),
                int.parse(parts[3]),
                int.parse(parts[4]),
              ),
            );
          } else if (parts[0].startsWith('B')) {
            danhSachPhong.add(
              PhongB(
                parts[0],
                int.parse(parts[1]),
                int.parse(parts[2]),
                int.parse(parts[3]),
                int.parse(parts[4]),
                int.parse(parts[5]),
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Lỗi khi đọc file: $e');
    }

    return danhSachPhong;
  }
}
