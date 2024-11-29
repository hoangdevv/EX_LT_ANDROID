import 'CuaHang.dart';
import 'DienThoai.dart';

void main() {
  CuaHang cuaHang = CuaHang("Cửa hàng ABC", "123 Đường XYZ");

  // Thêm điện thoại
  DienThoai dienThoai1 =
      DienThoai("DT-001", "iPhone 13", "Apple", 15000, 18000, 50, true);
  cuaHang.themDienThoai(dienThoai1);

  DienThoai dienThoai2 = DienThoai(
      "DT-002", "Samsung Galaxy S21", "Samsung", 12000, 14000, 30, true);
  cuaHang.themDienThoai(dienThoai2);

  // Tạo hóa đơn
  cuaHang.taoHoaDonMoi("HD-001", DateTime.now(), "DT-001", 2, 20000,
      "Nguyễn Văn A", "0987654321");

  // Thống kê doanh thu và lợi nhuận
  print(
      "Doanh thu từ 01/01/2023 đến 31/12/2023: ${cuaHang.tongDoanhThu(DateTime(2023, 1, 1), DateTime(2023, 12, 31))}");
  print(
      "Lợi nhuận từ 01/01/2023 đến 31/12/2023: ${cuaHang.tongLoiNhuan(DateTime(2023, 1, 1), DateTime(2023, 12, 31))}");

  // Thống kê tồn kho
  cuaHang.thongKeTonKho();

  // Thống kê top bán chạy
  cuaHang.thongKeTopDienThoaiBanChay();
}
