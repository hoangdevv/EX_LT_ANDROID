import 'dart:ffi';
import 'DienThoai.dart';

class HoaDon {
  //thuoc tinh
  String _maHD;
  DateTime _ngayBan;
  // Điện thoại được bán
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhachHang;

  // constructor
  HoaDon(this._maHD, this._ngayBan, this._dienThoai, this._soLuongMua,
      this._giaBanThucTe, this._tenKhachHang, this._soDienThoaiKhachHang);

  // Getter/Setter
  String get maHD => _maHD;
  set maHD(String value) {
    if (value.isEmpty || value.startsWith("HD-")) {
      _maHD = value;
    } else {
      throw Exception("Mã hoá đơn không hợp lệ");
    }
  }

  DateTime get ngayBan => _ngayBan;
  // Ngày bán: không sau ngày hiện tại
  set ngayBan(DateTime value) {
    if (value.isBefore(DateTime.now())) {
      _ngayBan = value;
    } else {
      throw Exception("Ngày bán phải trước ngày hiện tại");
    }
  }

  DienThoai get dienThoai => _dienThoai;
  set dienThoai(DienThoai value) {
    _dienThoai = value;
  }

  int get soLuongMua => _soLuongMua;
  // Số lượng mua: > 0 và <= tồn kho
  set soLuongMua(int value) {
    if (value > 0 && value <= _dienThoai.soLuongTonKho) {
      _soLuongMua = value;
    } else {
      throw Exception(
          "Số lượng mua phải lớn hơn 0 và nhỏ hơn số lượng tồn kho điện thoại");
    }
  }

  double get giaBanThucTe => _giaBanThucTe;
  set giaBanThucTe(double value) {
    if (giaBanThucTe > 0) {
      _giaBanThucTe = value;
    } else {
      throw Exception("Giá bán thực tế phải lớn hơn 0");
    }
  }

  String get tenKhachHang => _tenKhachHang;
  set tenKhachHang(String value) {
    if (value.isNotEmpty) {
      _tenKhachHang = value;
    } else {
      throw Exception("Tên khách hàng không được để trống");
    }
  }

  String get soDienThoaiKhachHang => _soDienThoaiKhachHang;
  // đúng định dạng số điện thoại
  set soDienThoaiKhachHang(String value) {
    RegExp phoneRegExp = RegExp(r'^0[1-9][0-9]{8}$');

    if (value.isNotEmpty && phoneRegExp.hasMatch(value)) {
      _soDienThoaiKhachHang = value;
    } else {
      throw Exception("Số điện thoại khách hàng không hợp lệ");
    }
  }

  // phương thức tính tổng tiền
  double tinhTongTien() {
    return _soLuongMua * _giaBanThucTe;
  }

  //phương thức tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() {
    double giaNhap = _dienThoai.giaNhap;
    return (_giaBanThucTe - giaNhap) * _soLuongMua;
  }

  void hienThiThongTinHoaDon() {
    print(
        "===========================================================================================================");
    print(
        "| Mã hóa đơn | Ngày bán       | Tên điện thoại          | Số lượng mua | Giá tiền    | Tổng tiền    |");
    print(
        "|------------|----------------|-------------------------|--------------|-------------|--------------|");

    // In thông tin chi tiết hóa đơn
    print(
        "| $_maHD     | ${_ngayBan.toIso8601String().substring(0, 10)} | ${_dienThoai.tenDienThoai.padRight(23)} | $_soLuongMua        | ${_giaBanThucTe.toStringAsFixed(2).padLeft(10)} VND | ${tinhTongTien().toStringAsFixed(2).padLeft(12)} VND |");

    print(
        "===========================================================================================================");
    print("Thông tin khách hàng: ");
    print("Tên khách hàng: $_tenKhachHang");
    print("Số điện thoại khách hàng: $_soDienThoaiKhachHang");
    print(
        "-----------------------------------------------------------------------------------------------------------");
  }
}
