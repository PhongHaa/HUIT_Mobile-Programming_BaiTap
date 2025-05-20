import 'package:phongha_tuan2/NhanVien.dart';

void main() {
  Nhanvien nv = Nhanvien.fullPara(
    "NV001",
    "Nguyễn Trần Tuấn",
    2.34,
    "Tổ chức",
    23,
  );
  CanBo cb = CanBo.fullPara(
    'NV002',
    'Trần Văn Bình',
    2.34,
    "Tổ chức",
    26,
    "Trưởng phòng",
    2.0,
  );
  Nhanvien nv3 = Nhanvien.fullPara("NV003", "Nguyễn Nam", 2.34, "Nhân sự", 27);
  //Tạo danh sách các cán bộ và nhân viên
  List<Nhanvien> lstNhanVien = [];
  lstNhanVien.add(nv);
  lstNhanVien.add(cb);
  lstNhanVien.add(nv3);
  print("Danh sách nhân viên và cán bộ: ");
  for (Nhanvien x in lstNhanVien) {
    print(x);
  }
  //Danh sách các nhân viên và cán bộ xếp loại A
  List<Nhanvien> lstLoaiA =
      lstNhanVien.where((a) => a.xepLoai() == "A").toList();
  print('Danh sách nhân viên và cán bộ xếp loại A:');
  for (Nhanvien x in lstLoaiA) {
    print(x);
  }
  double tongLuong = lstNhanVien.fold(0, (sum, nv) => sum + nv.tinhLuong());
  print("Tổng lương của nhân viên và cán bộ:$tongLuong");
  lstNhanVien.sort((x, y) => x.tinhLuong().compareTo(y.tinhLuong()));
  print("Danh sách sau khi sắp xếp tăng dần theo lương là:");
  for (Nhanvien x in lstNhanVien) {
    print(x);
  }
}
