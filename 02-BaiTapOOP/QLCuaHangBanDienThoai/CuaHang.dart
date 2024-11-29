import 'DienThoai.dart';
import 'HoaDon.dart';

class CuaHang {
  // Thuộc tính
  String _tenCH;
  String _diaChi;
  late List<DienThoai> _dienThoai;
  late List<HoaDon> _hoaDon;

  // Constructor
  CuaHang(this._tenCH, this._diaChi) {
    _dienThoai = [];
    _hoaDon = [];
  }

  // getter/sêtter
  List<HoaDon> get hoaDon => _hoaDon;

  // ===================start: Nhóm Phương Thức Quản Lý Điện Thoại ===================

  // Phương thức thêm điện thoại mới
  void themDienThoai(DienThoai dienThoai) {
    _dienThoai.add(dienThoai);
    print("Đã thêm điện thoại: ${dienThoai.tenDienThoai}");
  }

  // Phương thức cập nhập thông tin điện thoại
  void capNhatDienThoai(String maDienThoai, DienThoai capNhatDienThoai) {
    for (int i = 0; i < _dienThoai.length; i++) {
      if (_dienThoai[i].maDienThoai == maDienThoai) {
        _dienThoai[i] = capNhatDienThoai;
        _dienThoai[i].hienThiThongTin();
        return;
      }
    }
    print("Không tìm thấy điện thoại với mã: $maDienThoai");
  }

  // Phương thức ngừng kinh doanh điện thoại
  void ngungKinhDoanhDienThoai(String maDienThoai) {
    for (int i = 0; i < _dienThoai.length; i++) {
      if (_dienThoai[i].maDienThoai == maDienThoai) {
        _dienThoai[i].trangThai = false;
        print(
            "Đã ngừng kinh doanh điện thoại: ${_dienThoai[i].maDienThoai} - ${_dienThoai[i].tenDienThoai}");
        return;
      }
    }
    print("Không tìm thấy điện thoại với mã: $maDienThoai");
  }

  // Phương thức tìm kiếm điện thoại(theo mã, tên, hàngsx)
  void timKiemDienThoai(
      {String? maDienThoai, String? tenDienThoai, String? hangSX}) {
    List<DienThoai> ketQuaTimKiem = [];

    // Lọc điện thoại
    for (DienThoai dienThoai in _dienThoai) {
      bool kiemTra = true;

      // Kiểm tra các điều kiện tìm kiếm
      if (maDienThoai != null && !dienThoai.maDienThoai.contains(maDienThoai)) {
        kiemTra = false;
      }
      if (tenDienThoai != null &&
          !dienThoai.tenDienThoai
              .toLowerCase()
              .contains(tenDienThoai.toLowerCase())) {
        kiemTra = false;
      }
      if (hangSX != null && !dienThoai.hangSX.contains(hangSX)) {
        kiemTra = false;
      }
      if (kiemTra) {
        ketQuaTimKiem.add(dienThoai);
      }
    }
    // Hiển thị kết quả tìm kiếm
    if (ketQuaTimKiem.isEmpty) {
      print("Không tìm thấy điện thoại");
    } else {
      print("Kết quả tìm kiếm:");
      for (DienThoai dienThoai in ketQuaTimKiem) {
        dienThoai.hienThiThongTin();
      }
    }
  }

  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    if (_dienThoai.isEmpty) {
      print("Danh sách điện thoại hiện tại trống!");
      return;
    }
    print("===== DANH SÁCH ĐIỆN THOẠI =====");
    print(
        "| Mã điện thoại | Tên điện thoại      | Hãng sản xuất  | Giá bán   | Số lượng tồn | Trạng thái   |");
    print(
        "|----------------|---------------------|----------------|-----------|--------------|--------------|");
    // Duyệt qua danh sách dienThoai
    for (var dienThoai in _dienThoai) {
      String trangThai = dienThoai.trangThai ? "Còn hàng" : "Hết hàng";
      print(
          "| ${dienThoai.maDienThoai.padRight(14)} | ${dienThoai.tenDienThoai.padRight(20)} | ${dienThoai.hangSX.padRight(14)} | ${dienThoai.giaBan.toStringAsFixed(2).padLeft(9)} | ${dienThoai.soLuongTonKho.toString().padLeft(12)} | $trangThai |");
    }
    print(
        "------------------------------------------------------------------------------------------------");
  }

  // ===================end: Nhóm Phương Thức Quản Lý Điện Thoại ===================

  // ===================start: Nhóm Phương Thức Quản Lý Hóa Đơn ===================

  // Phương thức tạo hóa đơn mới và cập nhật tồn kho
  void taoHoaDonMoi(
      String maHD,
      DateTime ngayBan,
      String maDienThoai,
      int soLuongMua,
      double giaBanThucTe,
      String tenKhachHang,
      String soDienThoaiKhachHang) {
    // Kiểm tra mã hóa đơn hợp lệ
    if (maHD.isEmpty || !maHD.startsWith("HD-")) {
      throw Exception("Mã hóa đơn không hợp lệ");
    }

    // Kiểm tra ngày bán hợp lệ
    if (ngayBan.isAfter(DateTime.now())) {
      throw Exception("Ngày bán không được sau ngày hiện tại");
    }

    // Kiểm tra số lượng mua hợp lệ
    DienThoai? dienThoaiBan = _timDienThoai(maDienThoai);
    if (dienThoaiBan == null) {
      throw Exception("Điện thoại không tồn tại trong cửa hàng");
    }
    if (soLuongMua <= 0 || soLuongMua > dienThoaiBan.soLuongTonKho) {
      throw Exception(
          "Số lượng mua phải lớn hơn 0 và không vượt quá số lượng tồn kho");
    }

    // Kiểm tra giá bán hợp lệ
    if (giaBanThucTe <= 0) {
      throw Exception("Giá bán phải lớn hơn 0");
    }

    // Kiểm tra thông tin khách hàng hợp lệ
    if (tenKhachHang.isEmpty) {
      throw Exception("Tên khách hàng không được rỗng");
    }
    if (!soDienThoaiKhachHang.startsWith('0') ||
        soDienThoaiKhachHang.length != 10) {
      throw Exception("Số điện thoại khách hàng không hợp lệ");
    }

    // Tạo đối tượng hóa đơn mới
    HoaDon hoaDonMoi = HoaDon(maHD, ngayBan, dienThoaiBan, soLuongMua,
        giaBanThucTe, tenKhachHang, soDienThoaiKhachHang);

    // Cập nhật tồn kho
    dienThoaiBan.soLuongTonKho -= soLuongMua;

    _hoaDon.add(hoaDonMoi);
    print("Hóa đơn đã được tạo thành công!");
    hoaDonMoi.hienThiThongTinHoaDon();
  }

  // Phương thức tìm điện thoại theo mã
  DienThoai? _timDienThoai(String maDienThoai) {
    for (var dienThoai in _dienThoai) {
      if (dienThoai.maDienThoai == maDienThoai) {
        return dienThoai;
      }
    }
    return null;
  }

  // Phương thức tìm kiếm hóa đơn(theo mã, ngày, khách hàng)
  List<HoaDon> timKiemHoaDon(
      {String? maHD,
      DateTime? ngayBatDau,
      DateTime? ngayKetThuc,
      String? tenKhachHang}) {
    List<HoaDon> ketQuaTimKiem = [];

    for (var hoaDon in _hoaDon) {
      if (maHD != null && hoaDon.maHD != maHD) continue;
      if (tenKhachHang != null && hoaDon.tenKhachHang != tenKhachHang) continue;
      if (ngayBatDau != null && hoaDon.ngayBan.isBefore(ngayBatDau)) continue;
      if (ngayKetThuc != null && hoaDon.ngayBan.isAfter(ngayKetThuc)) continue;

      ketQuaTimKiem.add(hoaDon);
    }

    return ketQuaTimKiem;
  }

  // Phương thức hiển thị thông tin hóa đơn
  void hienThiDanhSachHoaDon() {
    print(
        "====================================================================================================");
    print(
        "| Mã HĐ     | Ngày bán       | Tên khách hàng | Số lượng | Giá bán (VNĐ) | Tổng tiền (VNĐ) |");
    print(
        "|-----------|----------------|-----------------|----------|----------------|-----------------|");

    for (var hoaDon in _hoaDon) {
      print(
          "| ${hoaDon.maHD.padRight(10)} | ${hoaDon.ngayBan.toIso8601String().substring(0, 10).padRight(14)} | "
          "${hoaDon.tenKhachHang.padRight(15)} | ${hoaDon.soLuongMua.toString().padRight(8)} | "
          "${hoaDon.giaBanThucTe.toStringAsFixed(2).padRight(14)} | "
          "${(hoaDon.soLuongMua * hoaDon.giaBanThucTe).toStringAsFixed(2).padRight(14)} |");
    }

    print(
        "====================================================================================================");
  }

  // ===================end: Nhóm Phương Thức Quản Lý Hóa Đơn ===================

  // ===================start: Nhóm Phương Thức Thông kê ===================

  // Phương thức tính tổng doanh thu theo khoảng thời gian
  double tongDoanhThu(DateTime startDate, DateTime endDate) {
    double doanhThu = 0;

    for (var hoaDon in _hoaDon) {
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        doanhThu += hoaDon.soLuongMua * hoaDon.giaBanThucTe;
      }
    }
    return doanhThu;
  }

  // Phương thức tính tổng lợi nhuận theo khoảng thời gian
  double tongLoiNhuan(DateTime startDate, DateTime endDate) {
    double loiNhuan = 0;

    for (var hoaDon in _hoaDon) {
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        double giaNhap = hoaDon.dienThoai.giaNhap;
        double doanhThu = hoaDon.soLuongMua * hoaDon.giaBanThucTe;
        double loiNhuanHoaDon = doanhThu - (hoaDon.soLuongMua * giaNhap);
        loiNhuan += loiNhuanHoaDon;
      }
    }
    return loiNhuan;
  }

  // Phương thức thống kê top điện thoại bán chạy
  void thongKeTopDienThoaiBanChay() {
    Map<String, int> soLuongBan = {};

    for (var hoaDon in _hoaDon) {
      if (soLuongBan.containsKey(hoaDon.dienThoai.maDienThoai)) {
        soLuongBan[hoaDon.dienThoai.maDienThoai] =
            soLuongBan[hoaDon.dienThoai.maDienThoai]! + hoaDon.soLuongMua;
      } else {
        soLuongBan[hoaDon.dienThoai.maDienThoai] = hoaDon.soLuongMua;
      }
    }

    var topDienThoai = soLuongBan.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    print("Top điện thoại bán chạy:");
    for (var entry in topDienThoai) {
      print("${entry.key}: ${entry.value} sản phẩm bán ra");
    }
  }

  // Phương thức thống kê tồn kho
  void thongKeTonKho() {
    print(
        "====================================================================================================");
    print("| Mã điện thoại | Tên điện thoại     | Tồn kho hiện tại |");
    print("|----------------|--------------------|------------------|");

    for (var dienThoai in _dienThoai) {
      print(
          "| ${dienThoai.maDienThoai.padRight(15)} | ${dienThoai.tenDienThoai.padRight(18)} | ${dienThoai.soLuongTonKho.toString().padRight(17)} |");
    }

    print(
        "====================================================================================================");
  }

  // ===================end: Nhóm Phương Thức Thông kê ===================
}
