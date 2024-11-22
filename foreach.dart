import 'dart:io';

void main() {
  // Vong lap for thong thuong
  for (var i = 1; i <= 5; i++) {
    print(i);
  }

  // Vong lap for -in
  var names = ['An ', 'Binh ', 'Chi '];
  for (var name in names) {
    print(name);
  }

  // For voi tap hop
  var numbers = [1, 2, 3];
  numbers.forEach((number) => print(number));
}
