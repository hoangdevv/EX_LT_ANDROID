import 'dart:io';
import 'dart:math';

/*Viết chương trình tính tổng
 các ước số của một số nguyên được 
 nhập từ bàn phím (n>=1). 
 */

void main() {
  stdout.write("Nhập số nguyên (≥1): ");
  String? input = stdin.readLineSync();

  int? n = int.tryParse(input ?? '');
  if (n == null || n < 1) {
    print("Số bạn vừa nhập không hợp lệ.");
    return;
  }

  // Tính tổng các ước số
  int sumOfDivisors = calculateSumOfDivisors(n);

  print("Tổng các ước số của $n là: $sumOfDivisors");
}

// Hàm tính tổng các ước số của một số nguyên
int calculateSumOfDivisors(int num) {
  int sum = 0;
  for (int i = 1; i <= num; i++) {
    if (num % i == 0) {
      sum += i;
    }
  }
  return sum;
}
