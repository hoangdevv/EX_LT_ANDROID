import 'CuaHang.dart';
import 'DienThoai.dart';
import 'HoaDon.dart';

void main() {
  CuaHang cuaHang = CuaHang("Cửa Hàng Điện Thoại", "123 Đường A");
  DienThoai dienThoai =
      DienThoai("DT-001", "iPhone 13", "Apple", 10000, 12000, 50, true);
  // Thêm điện thoại vào cửa hàng
  cuaHang.themDienThoai(dienThoai);

  // Kiểm tra tạo hóa đơn hợp lệ
  try {
    cuaHang.taoHoaDonMoi("HD-001", DateTime.now(), "DT-001", 5, 13000,
        "Nguyễn Văn A", "0123456789");
    print("Test tạo hóa đơn hợp lệ: Thành công!");
  } catch (e) {
    print("Test tạo hóa đơn hợp lệ: Thất bại - ${e}");
  }
  print(
      "---------------------------------------------------------------------------------");
  // Kiểm tra số lượng mua vượt quá tồn kho
  try {
    cuaHang.taoHoaDonMoi(
        "HD-002",
        DateTime.now(),
        "DT-001",
        60, // Số lượng lớn hơn tồn kho
        13000,
        "Nguyễn Văn B",
        "0123456790");
    print("Test kiểm tra số lượng: Thành công");
  } catch (e) {
    print("Test kiểm tra số lượng: Thất bại - ${e}");
  }
  print(
      "---------------------------------------------------------------------------------");
  // Kiểm tra giá bán không hợp lệ (giá bán <= 0)
  try {
    cuaHang.taoHoaDonMoi(
        "HD-003",
        DateTime.now(),
        "DT-001",
        5,
        -100, // Giá bán không hợp lệ
        "Nguyễn Văn C",
        "0123456700");
    print("Test kiểm tra giá bán: Thành công");
  } catch (e) {
    print("Test kiểm tra giá bán: Thất bại - ${e}");
  }
  print(
      "---------------------------------------------------------------------------------");
  // Kiểm tra thông tin khách hàng không hợp lệ (số điện thoại sai)
  try {
    cuaHang.taoHoaDonMoi("HD-004", DateTime.now(), "DT-001", 5, 13000,
        "Nguyễn Văn D", "123456789");
    print("Test kiểm tra thông tin khách hàng: Thành công");
  } catch (e) {
    print("Test kiểm tra thông tin khách hàng: Thất bại - ${e}");
  }

  // Kiểm tra tính toán tiền và lợi nhuận
  try {
    cuaHang.taoHoaDonMoi("HD-005", DateTime.now(), "DT-001", 3, 13000,
        "Nguyễn Văn E", "0123456711");
    HoaDon hoaDon = cuaHang.hoaDon.last; // Lấy hóa đơn cuối cùng
    double tongTien = hoaDon.soLuongMua * hoaDon.giaBanThucTe;
    double loiNhuan =
        (hoaDon.giaBanThucTe - hoaDon.dienThoai.giaNhap) * hoaDon.soLuongMua;

    print("Test tính toán tiền và lợi nhuận: Thành công!");
    print("Tổng tiền: $tongTien VND");
    print("Lợi nhuận: $loiNhuan VND");
  } catch (e) {
    print("Test tính toán tiền và lợi nhuận: Thất bại - ${e}");
  }

  //
  HoaDon hoaDon1 = HoaDon(
      "HD-001",
      DateTime(2024, 11, 15),
      DienThoai(
          "DT-001", "Samsung Galaxy", "Samsung", 10000000, 12000000, 50, true),
      2,
      12000000,
      "Nguyễn Văn A",
      "0123456789");
  HoaDon hoaDon2 = HoaDon(
      "HD-002",
      DateTime(2024, 11, 16),
      DienThoai("DT-002", "iPhone 13", "Apple", 20000000, 22000000, 30, true),
      1,
      22000000,
      "Trần Thị B",
      "0123456790");
  HoaDon hoaDon3 = HoaDon(
      "HD-003",
      DateTime(2024, 11, 17),
      DienThoai(
          "DT-003", "Xiaomi Mi 11", "Xiaomi", 15000000, 16000000, 20, true),
      3,
      16000000,
      "Lê Minh C",
      "0123456700");

  cuaHang.hoaDon.addAll([hoaDon1, hoaDon2, hoaDon3]);

  // Tìm kiếm hóa đơn theo mã hóa đơn
  print("Tìm kiếm theo mã hóa đơn:");
  var ketQuaMaHD = cuaHang.timKiemHoaDon(maHD: "HD-002");
  for (var hoaDon in ketQuaMaHD) {
    print(
        "Mã HD: ${hoaDon.maHD}, Ngày bán: ${hoaDon.ngayBan}, Khách hàng: ${hoaDon.tenKhachHang}");
  }

  // Tìm kiếm hóa đơn theo tên khách hàng
  print("\nTìm kiếm theo tên khách hàng:");
  var ketQuaTenKH = cuaHang.timKiemHoaDon(tenKhachHang: "Nguyễn Văn A");
  for (var hoaDon in ketQuaTenKH) {
    print(
        "Mã HD: ${hoaDon.maHD}, Ngày bán: ${hoaDon.ngayBan}, Khách hàng: ${hoaDon.tenKhachHang}");
  }

  // Tìm kiếm theo khoảng thời gian
  print("\nTìm kiếm theo khoảng thời gian (từ 2024-11-15 đến 2024-11-16):");
  var ketQuaThoiGian = cuaHang.timKiemHoaDon(
      ngayBatDau: DateTime(2024, 11, 15), ngayKetThuc: DateTime(2024, 11, 16));
  for (var hoaDon in ketQuaThoiGian) {
    print(
        "Mã HD: ${hoaDon.maHD}, Ngày bán: ${hoaDon.ngayBan}, Khách hàng: ${hoaDon.tenKhachHang}");
  }
}
