import 'DienThoai.dart';
import 'HoaDon.dart';
import 'CuaHang.dart';

void main() {
  // Khởi tạo cửa hàng
  CuaHang cuaHang = CuaHang('APPLE STORE', 'Q9, TP.HCM');

  // Tạo điện thoại mới
  DienThoai dienThoai1 =
      DienThoai('DT-001', 'iPhone 14', 'Apple', 12000.0, 15000.0, 10, true);
  DienThoai dienThoai2 =
      DienThoai('DT-002', 'Galaxy S23', 'Samsung', 10000.0, 13000.0, 15, true);
  DienThoai dienThoai3 =
      DienThoai('DT-003', 'Oppo F19', 'Oppo', 5000.0, 8000.0, 20, true);

  // Thêm điện thoại vào cửa hàng
  cuaHang.themDienThoai(dienThoai1);
  cuaHang.themDienThoai(dienThoai2);
  cuaHang.themDienThoai(dienThoai3);

  // Hiển thị danh sách điện thoại
  cuaHang.hienThiDanhSachDienThoai();

  // Tìm kiếm điện thoại theo mã
  print("\nTìm kiếm điện thoại theo mã 'DT-002':");
  cuaHang.timKiemDienThoai(maDienThoai: 'DT-002');

  // // Tìm kiếm điện thoại theo tên
  print("\nTìm kiếm điện thoại theo tên 'iPhone 14':");
  cuaHang.timKiemDienThoai(tenDienThoai: 'iPhone 14');

  // // Tìm kiếm điện thoại theo hãng sản xuất
  print("\nTìm kiếm điện thoại theo hangsx 'Samsung':");
  cuaHang.timKiemDienThoai(hangSX: 'Samsung');

  // Cập nhật thông tin điện thoại (ví dụ: thay đổi giá bán)
  print("\nCập nhật thông tin điện thoại 'DT-002':");
  DienThoai dienThoaiMoi = DienThoai(
      'DT-002', 'Galaxy S23 Ultra', 'Samsung', 10000.0, 14000.0, 0, false);
  cuaHang.capNhatDienThoai('DT-002', dienThoaiMoi);

  cuaHang.hienThiDanhSachDienThoai();

  // Ngừng kinh doanh điện thoại (đánh dấu hết hàng)
  print("\nNgừng kinh doanh điện thoại 'DT-003':");
  cuaHang.ngungKinhDoanhDienThoai('DT-003');

  cuaHang.hienThiDanhSachDienThoai();

  // Thử tạo hóa đơn với số lượng vượt quá tồn kho
  try {
    cuaHang.taoHoaDonMoi(
        "HD-002",
        DateTime.now(),
        "DT-001",
        20, // Số lượng mua (vượt quá tồn kho)
        20000, // Giá bán thực tế
        "Trần Thị B",
        "0981234567");
  } catch (e) {
    print("Lỗi khi tạo hóa đơn: $e");
  }

// Kiểm tra mã hóa đơn không hợp lệ
  try {
    cuaHang.taoHoaDonMoi(
      "HDX-004", // Mã hóa đơn không hợp lệ
      DateTime.now(),
      "DT-001",
      2,
      20000,
      "Nguyễn Thị D",
      "0981234569",
    );
  } catch (e) {
    print("Lỗi khi tạo hóa đơn (Mã hóa đơn không hợp lệ): $e");
  }
  // Kiểm tra ngày bán không hợp lệ (ngày bán sau ngày hiện tại)
  try {
    cuaHang.taoHoaDonMoi(
      "HD-005",
      DateTime.now().add(Duration(days: 1)), // Ngày bán sau ngày hiện tại
      "DT-001",
      2,
      20000,
      "Lê Thị E",
      "0981234570",
    );
  } catch (e) {
    print("Lỗi khi tạo hóa đơn (Ngày bán không hợp lệ): $e");
  }
}
