import 'dart:ffi';

class DienThoai {
  // Thuoc tinh
  String _maDienThoai;
  String _tenDienThoai;
  String _hangSX;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThai;

  // Construction
  DienThoai(this._maDienThoai, this._tenDienThoai, this._hangSX, this._giaNhap,
      this._giaBan, this._soLuongTonKho, this._trangThai);

  // Getter/ Setter
  String get maDienThoai => _maDienThoai;
  //Mã điện thoại: không rỗng, định dạng "DT-XXX"
  set maDienThoai(String value) {
    if (value.isEmpty || value.startsWith("DT-")) {
      _maDienThoai = value;
    } else {
      throw Exception("Mã điện thoại không hợp lệ");
    }
  }

  String get tenDienThoai => _tenDienThoai;
  set tenDienThoai(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Tên điện thoại không được rỗng");
    }
    _tenDienThoai = value;
  }

  String get hangSX => _hangSX;
  set hangSX(String value) {
    if (value.isEmpty) {
      throw ArgumentError("Hãng sản xuất không được rỗng");
    }
    _hangSX = value;
  }

  double get giaNhap => _giaNhap;
  set giaNhap(double value) {
    if (value < 0) {
      throw ArgumentError("Giá nhập phải lớn hơn hoặc bằng 0");
    }
    _giaNhap = value;
  }

  double get giaBan => _giaBan;
  // giá bán phải lớn hơn 0 và lớn hơn giá nhập
  set giaBan(double value) {
    if (value <= 0) {
      throw ArgumentError("Giá bán phải lớn hơn 0");
    }
    if (value <= _giaNhap) {
      throw ArgumentError("Giá bán phải lớn hơn giá nhập");
    }
    _giaBan = value;
  }

  int get soLuongTonKho => _soLuongTonKho;
  set soLuongTonKho(int value) {
    if (value < 0) {
      throw ArgumentError("Số lượng tồn kho phải lớn hơn hoặc bằng 0");
    }
    _soLuongTonKho = value;
  }

  bool get trangThai => _trangThai;
  set trangThai(bool value) {
    _trangThai = value;
  }

  //phương thức tính lợi nhuận dự kiến
  double tinhLoiNhuanDuKien() {
    return _giaBan - _giaNhap;
  }

  //phương thức hiện thị thông tin
  void hienThiThongTin() {
    print(
        "==========================================================================================================");
    print(
        "| Mã điện thoại| Tên điện thoại  | Hãng sản xuất     | Giá nhập  | Giá bán  | Số lượng tồn| Trạng thái   |");
    print(
        "|--------------|-----------------|------------------ |-----------|--------- |-------------|--------------|");
    print(
        "| ${_maDienThoai.padRight(12)} | ${_tenDienThoai.padRight(15)} | ${_hangSX.padRight(17)} |${_giaNhap.toStringAsFixed(2).padLeft(5)} VND | ${_giaBan.toStringAsFixed(2).padLeft(4)} VND | ${_soLuongTonKho.toString().padLeft(4)} | ${_trangThai ? 'Còn hàng' : 'Hết hàng'.padRight(12)} |");
    print(
        "---------------------------------------------------------------------------------------------------------");
  }

  //phương thức kiểm tra có thể bán không(còn hàng và đang kinh doanh)
  bool coTheBanKhong() {
    return _soLuongTonKho > 0 && _trangThai;
  }
}
