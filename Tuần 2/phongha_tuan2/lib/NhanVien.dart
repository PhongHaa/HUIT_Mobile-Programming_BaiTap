class Nhanvien {
  String _maNV = '';
  String _tenNV = '';
  double _heSoLuong = 0.0;
  // String _phongBan = '';
  double _soNgayLV = 0.0;
  static double LCB = 2340;
  //phương thức khởi tạo
  Nhanvien() {
    _maNV = "NV000";
    _tenNV = "Nguyễn Văn A";
    _heSoLuong = 2.34;
    // _phongBan = "Tổ chức";
    _soNgayLV = 22;
  }
  Nhanvien.fullPara(
    String manv,
    String tennv,
    double hsl,
    String pb,
    double songaylv,
  ) {
    _maNV = manv;
    _tenNV = tennv;
    _heSoLuong = hsl;
    // _phongBan = pb;
    _soNgayLV = songaylv;
  } //phương thức xếp loại
  String xepLoai() {
    if (_soNgayLV > 25) {
      return 'A';
    } else if (_soNgayLV > 22) {
      return 'B';
    } else {
      return 'C';
    }
  }

  //phương thức tính lương
  double tinhLuong() {
    String xLoai = xepLoai();
    double hsThiDua = 0.5;
    if (xLoai == 'A') {
      hsThiDua = 1;
    } else if (xLoai == 'B') {
      hsThiDua = 0.75;
    }
    return LCB * _heSoLuong * hsThiDua;
  }

  @override
  String toString() {
    return "$_maNV\t$_tenNV\t$_heSoLuong\t$_soNgayLV\t${xepLoai()}\t${tinhLuong()}";
  }
}

class CanBo extends Nhanvien {
  String _chucVu = '';
  double _hsChucVu = 0;
  CanBo() : super() {
    _chucVu = "Unknow";
    _hsChucVu = 0;
  }
  CanBo.fullPara(
    super.manv,
    super.tennv,
    super.hsl,
    super.pb,
    super.songaylv,
    String chucvu,
    double hscv,
  ) : super.fullPara() {
    _chucVu = chucvu;
    _hsChucVu = hscv;
  }
  @override
  String toString() {
    return "${super}\t$_chucVu\t$_hsChucVu";
  }

  @override
  double tinhLuong() {
    return super.tinhLuong() + _hsChucVu * 1100;
  }
}
