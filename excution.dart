import 'dart:ffi';
import 'dart:io';

void main() {
  final namesd;
  namesd = 123;
  print(namesd);
  var ten = 'Trung';
  int tuoi = 18;
  String? tenNullAble;
  tenNullAble = null;
  print(tenNullAble);

  tenNullAble = 'Hoang';
  print(tenNullAble);
  int? soLuong;
  soLuong = null;
  soLuong = tuoi;

  late String location;
  location = 'Hanoi';
  print("Thanh pho toi song la o $location");
}
