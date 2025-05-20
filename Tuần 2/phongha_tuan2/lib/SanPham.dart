class SanPham {
  String _maSP = '';
  String _tenSP = '';
  double _donGia = 0;
  double _giamGia = 0;
  SanPham() {
    _maSP = "SP000";
    _tenSP = "Unknow";
    _donGia = 0;
    _giamGia = 0;
  }
  SanPham.fullPara(String masp, String tensp, double gia, double giam) {
    _maSP = masp;
    _tenSP = tensp;
    _donGia = gia;
    _giamGia = giam;
  }
  //phuong thức get, set
  String get maSP => _maSP;
  set maSP(String value) {
    if (value.isNotEmpty) {
      _maSP = value;
    }
  }

  //SV tự khai báo cho tên Sản phẩm
  double get donGia => _donGia;
  set donGia(double value) {
    if (value > 0) {
      _donGia = value;
    }
  }

  //SV tự khai báo cho giảm giá
  //phương thức tính thuế nhập khẩu
  double tinhThueNhapKhau() {
    return 0.01 * _donGia;
  }

  void showInfo() {
    print(
      "Mã sản phẩm: $_maSP, tên: $_tenSP, giá bán:$_donGia, giảm giá: $_giamGia, thuế:${tinhThueNhapKhau()}",
    );
  }
}
