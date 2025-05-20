abstract class MonHoc {
  String maMH;
  String tenMH;
  int soTC;

  MonHoc(this.maMH, this.tenMH, this.soTC);

  double tinhDTB();

  @override
  String toString() {
    return "$maMH - $tenMH - $soTC tín chỉ - DTB: ${tinhDTB().toStringAsFixed(2)}";
  }
}

class LyThuyet extends MonHoc {
  double diemTieuLuan;
  double diemCuoiKy;

  LyThuyet(
    String maMH,
    String tenMH,
    int soTC,
    this.diemTieuLuan,
    this.diemCuoiKy,
  ) : super(maMH, tenMH, soTC);

  @override
  double tinhDTB() => diemTieuLuan * 0.3 + diemCuoiKy * 0.7;
}

class ThucHanh extends MonHoc {
  List<double> diemKiemTra;

  ThucHanh(String maMH, String tenMH, int soTC, this.diemKiemTra)
    : super(maMH, tenMH, soTC);

  @override
  double tinhDTB() => diemKiemTra.reduce((a, b) => a + b) / diemKiemTra.length;
}

class DoAn extends MonHoc {
  double diemGVHD;
  double diemGVPB;

  DoAn(String maMH, String tenMH, int soTC, this.diemGVHD, this.diemGVPB)
    : super(maMH, tenMH, soTC);

  @override
  double tinhDTB() => (diemGVHD + diemGVPB) / 2;
}
