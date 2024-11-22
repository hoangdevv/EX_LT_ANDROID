import 'dart:io';

void main() {
  final value = 0x22;
  final bitmask = 0x0f;

  print((value & bitmask).toRadixString(16));

  print((value | bitmask).toRadixString(16));

  print((value ^ bitmask).toRadixString(16));

  print((value & ~bitmask).toRadixString(16));

  print((value << 1).toRadixString(16));

  print((value >> 1).toRadixString(16));

  print((value << 3).toRadixString(16));

  print((value >> 3).toRadixString(16));

  print((value << 5).toRadixString(16));

  print((value >> 5).toRadixString(16));

  print((value & 0x00).toRadixString(16));
}
