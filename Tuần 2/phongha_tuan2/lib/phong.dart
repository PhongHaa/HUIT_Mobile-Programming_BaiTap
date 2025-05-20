class Phong {
  String maSo;
  int soNguoi;
  int soDien;
  int soNuoc;

  Phong(this.maSo, this.soNguoi, this.soDien, this.soNuoc);

  double tinhTien() {
    return 0;
  }

  @override
  String toString() {
    return 'Mã: $maSo, Số người: $soNguoi, Số điện: $soDien, Số nước: $soNuoc, Tiền phòng: ${tinhTien()}';
  }
}

class PhongA extends Phong {
  int soNguoiThan;

  PhongA(String maSo, int soNguoi, int soDien, int soNuoc, this.soNguoiThan)
    : super(maSo, soNguoi, soDien, soNuoc);

  @override
  double tinhTien() {
    return (1400 + 2 * soDien + 8 * soNuoc + 50 * soNguoiThan).toDouble();
  }
}

class PhongB extends Phong {
  int giatUi;
  int soMayInternet;

  PhongB(
    String maSo,
    int soNguoi,
    int soDien,
    int soNuoc,
    this.giatUi,
    this.soMayInternet,
  ) : super(maSo, soNguoi, soDien, soNuoc);

  @override
  double tinhTien() {
    return 2000 + 2 * soDien + 8 * soNuoc + giatUi * 5 + soMayInternet * 100;
  }
}
