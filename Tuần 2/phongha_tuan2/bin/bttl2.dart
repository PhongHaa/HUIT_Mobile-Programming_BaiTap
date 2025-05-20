import 'package:phongha_tuan2/monhoc.dart';
import 'package:phongha_tuan2/file_handler_b2.dart';
import 'dart:io';

void main() {
  List<MonHoc> danhSachMonHoc = [
    LyThuyet("MH01", "Lập trình", 3, 8, 9),
    ThucHanh("MH02", "Cấu trúc dữ liệu", 4, [7, 8, 9]),
    DoAn("MH03", "Đồ án cuối kỳ", 5, 9, 8),
  ];

  print("Danh sách môn học:");
  danhSachMonHoc.forEach(print);

  bool sortedByName = isSortedByName(danhSachMonHoc);
  print("\nDanh sách đã sắp xếp theo tên: $sortedByName");

  danhSachMonHoc.sort((a, b) => a.soTC.compareTo(b.soTC));
  print("\nDanh sách sau khi sắp xếp theo tín chỉ:");
  danhSachMonHoc.forEach(print);

  int maxTC = danhSachMonHoc.map((e) => e.soTC).reduce((a, b) => a > b ? a : b);
  print("\nMôn học có số tín chỉ cao nhất:");
  danhSachMonHoc.where((mh) => mh.soTC == maxTC).forEach(print);

  stdout.write("\nNhập tên môn học cần tìm: ");
  String tenMH = stdin.readLineSync()!;
  var found = danhSachMonHoc.where(
    (mh) => mh.tenMH.toLowerCase() == tenMH.toLowerCase(),
  );
  if (found.isEmpty) {
    print("Môn học không tồn tại, thêm vào danh sách.");
    danhSachMonHoc.add(LyThuyet("MH04", tenMH, 3, 7, 8));
  } else {
    print("Thông tin môn học: ${found.first}");
  }

  FileHelper.writeToFile(danhSachMonHoc, "monhoc.txt");

  List<MonHoc> danhSachTuFile = FileHelper.readFromFile("monhoc.txt");
  print("\nDanh sách môn học đọc từ file:");
  danhSachTuFile.forEach(print);

  double avgTC =
      danhSachMonHoc.map((e) => e.soTC).reduce((a, b) => a + b) /
      danhSachMonHoc.length;
  print("\nSố tín chỉ trung bình: ${avgTC.toStringAsFixed(2)}");
}

bool isSortedByName(List<MonHoc> list) {
  for (int i = 0; i < list.length - 1; i++) {
    if (list[i].tenMH.compareTo(list[i + 1].tenMH) > 0) {
      return false;
    }
  }
  return true;
}
