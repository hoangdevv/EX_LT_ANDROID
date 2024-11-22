import 'dart:io';
import 'dart:math';

void main() {
/*1. Viết chương trình chuyển đổi 1 số 
 nguyên (b>=1) được nhập từ bàn phím 
 thành số nhị phân.*/

  stdout.write('Nhập số nguyên (≥1): ');
  String? input = stdin.readLineSync();
  // Kiểm tra đầu vào
  int? n = int.tryParse(input ?? '');
  if (n == null || n < 1) {
    stdout.write('Số bạn vừa nhập không hợp lệ.\n');
    return;
  }
  // Chuyển đổi sang nhị phân
  String binary = convertToBinary(n);

  // In ra kết quả
  print('Số nhị phân của $n là: $binary');
}

// Hàm chuyển đổi số nguyên thành nhị phân
String convertToBinary(int num) {
  String binary = '';
  while (num > 0) {
    binary = '${num % 2}' +
        binary; // Lấy phần dư (0 hoặc 1) và thêm vào trước chuỗi nhị phân
    num = num ~/ 2; // Chia lấy phần nguyên
  }
  return binary;
}
