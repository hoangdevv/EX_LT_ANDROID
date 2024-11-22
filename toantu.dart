void main() {
  Object obj = 'Hello world';

  if (obj is String) {
    print("obj la string");
  }
  if (obj is! int) {
    print('obj khong phai la int');
  }
  String str = obj as String;
  print(str.toUpperCase());
}
