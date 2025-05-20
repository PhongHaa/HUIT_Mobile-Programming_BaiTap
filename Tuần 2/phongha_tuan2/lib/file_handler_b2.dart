import 'dart:io';
import 'monhoc.dart';

class FileHelper {
  static void writeToFile(List<MonHoc> danhSach, String fileName) {
    File file = File(fileName);
    file.writeAsStringSync(danhSach.join("\n"));
    print("Dữ liệu đã lưu vào $fileName");
  }

  static List<MonHoc> readFromFile(String fileName) {
    File file = File(fileName);
    if (!file.existsSync()) return [];

    List<String> lines = file.readAsLinesSync();
    return lines.map((line) {
      var parts = line.split(" - ");
      return LyThuyet(parts[0], parts[1], int.parse(parts[2]), 8, 9);
    }).toList();
  }
}
