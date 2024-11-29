import 'NhanVien.dart';

class NhanVienBanHang extends NhanVien {
  double _doanhSo = 0.0;
  double _tyLeHoaHong = 0.0;

  // Constructor
  NhanVienBanHang(String maNhanVien, String hoTen, double luongCoBan,
      this._doanhSo, this._tyLeHoaHong)
      : super(maNhanVien, hoTen, luongCoBan);

  // Getter và Setter
  double get doanhSo => _doanhSo;
  set doanhSo(double value) {
    if (value < 0) {
      throw ArgumentError("Doanh số không được âm.");
    }
    _doanhSo = value;
  }

  double get tyLeHoaHong => _tyLeHoaHong;
  set tyLeHoaHong(double value) {
    if (value < 0 || value > 1) {
      throw ArgumentError("Tỷ lệ hoa hồng phải từ 0-1.");
    }
    _tyLeHoaHong = value;
  }

  // Phương thức tính lương
  @override
  double tinhLuong() {
    return luongCoBan + (_doanhSo * _tyLeHoaHong);
  }

  // Phương thức hiển thị thông tin
  @override
  void hienThiThongTin() {
    super.hienThiThongTin();
    print("Doanh số: $_doanhSo");
    print("Tỷ lệ hoa hồng: $_tyLeHoaHong");
    print("Lương thực nhận (đã tính hoa hồng): ${tinhLuong()}");
  }
}
