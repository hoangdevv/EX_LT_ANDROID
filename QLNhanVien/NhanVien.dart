class NhanVien {
  // Thuộc tính
  String _maNhanVien = "";
  String _hoTen = "";
  double _luongCoBan = 0.0;

  // Constructor
  NhanVien(this._maNhanVien, this._hoTen, this._luongCoBan);

  // Getter và Setter
  String get maNhanVien => _maNhanVien;
  set maNhanVien(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Mã nhân viên không được rỗng.");
    }
    _maNhanVien = value;
  }

  String get hoTen => _hoTen;
  set hoTen(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Họ tên không được rỗng.");
    }
    _hoTen = value;
  }

  double get luongCoBan => _luongCoBan;
  set luongCoBan(double value) {
    if (value <= 0) {
      throw ArgumentError("Lương cơ bản phải lớn hơn 0.");
    }
    _luongCoBan = value;
  }

  // Phương thức tính lương (virtual)
  double tinhLuong() {
    return _luongCoBan;
  }

  // Phương thức hiển thị thông tin
  void hienThiThongTin() {
    print("Mã nhân viên: $_maNhanVien");
    print("Họ tên: $_hoTen");
    print("Lương cơ bản: $_luongCoBan");
    print("Lương thực nhận: ${tinhLuong()}");
  }
}
