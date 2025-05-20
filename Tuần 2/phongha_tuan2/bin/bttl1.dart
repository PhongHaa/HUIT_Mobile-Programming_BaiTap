import 'package:phongha_tuan2/phong.dart';
import 'package:phongha_tuan2/file_handler_b1.dart';

void main() {
  String filePath = 'lib/phongthue.txt';
  List<Phong> danhSachPhong = FileHandler.docDanhSachPhong(filePath);

  print('--- Danh sách phòng trọ ---');
  danhSachPhong.forEach((phong) => print(phong));

  print('\n--- Phòng có số người lớn hơn 2 ---');
  danhSachPhong
      .where((phong) => phong.soNguoi > 2)
      .forEach((phong) => print(phong));

  double tongTien = danhSachPhong.fold(
    0,
    (sum, phong) => sum + phong.tinhTien(),
  );
  print('\nTổng tiền thu được: $tongTien');

  print('\n--- Danh sách phòng sắp xếp theo số điện giảm dần ---');
  danhSachPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  danhSachPhong.forEach((phong) => print(phong));

  print('\n--- Danh sách phòng loại A ---');
  danhSachPhong.whereType<PhongA>().forEach((phong) => print(phong));
}
