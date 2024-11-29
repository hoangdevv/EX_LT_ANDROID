import 'NhanVien.dart';
import 'NhanVienBanHang.dart';

void main() {
  // Tạo và kiểm tra nhân viên thường
  var nhanVien1 = NhanVien("NV001", "Nguyen Van A", 5000);
  print("Thông tin nhân viên thường:");
  nhanVien1.hienThiThongTin();
  print("");

  // Tạo và kiểm tra nhân viên bán hàng
  var nhanVienBanHang = NhanVienBanHang("NV002", "Le Thi B", 4000, 10000, 0.1);
  print("Thông tin nhân viên bán hàng:");
  nhanVienBanHang.hienThiThongTin();
  print("");

  // Tính đa hình với danh sách nhân viên
  List<NhanVien> danhSachNhanVien = [nhanVien1, nhanVienBanHang];
  print("Thông tin tất cả nhân viên (dùng tính đa hình):");
  for (var nv in danhSachNhanVien) {
    nv.hienThiThongTin();
    print("---");
  }

  // Kiểm tra tính toán lương
  print("Kiểm tra lương thực nhận:");
  print("Nhân viên thường: ${nhanVien1.tinhLuong()}");
  print("Nhân viên bán hàng: ${nhanVienBanHang.tinhLuong()}");

  // Kiểm tra setter với dữ liệu không hợp lệ
  try {
    nhanVien1.luongCoBan = -1000; // Sai lương cơ bản
  } catch (e) {
    print("Lỗi khi đặt lương cơ bản: $e");
  }

  try {
    nhanVienBanHang.doanhSo = -5000; // Sai doanh số
  } catch (e) {
    print("Lỗi khi đặt doanh số: $e");
  }

  try {
    nhanVienBanHang.tyLeHoaHong = 1.5; // Sai tỷ lệ hoa hồng
  } catch (e) {
    print("Lỗi khi đặt tỷ lệ hoa hồng: $e");
  }
}
