import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  // TextEditingController cho cân nặng và chiều cao
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  // Lựa chọn giới tính
  String _selectedGender = 'Nam';

  // Hàm tính BMI
  void _calculateBMI() {
    if (_weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty) {
      try {
        double weight = double.parse(_weightController.text);
        double height = double.parse(_heightController.text) /
            100; // Chuyển chiều cao sang mét
        if (weight > 0 && height > 0) {
          double bmi = weight / (height * height);
          _bmiController.text = _getBMICategory(bmi);
        } else {
          _bmiController.text = 'Vui lòng nhập giá trị hợp lệ';
        }
      } catch (e) {
        _bmiController.text = 'Lỗi: Vui lòng nhập số';
      }
    } else {
      _bmiController.text = '';
    }
  }

  // Hàm phân loại BMI
  String _getBMICategory(double bmi) {
    String category;
    if (bmi < 18.5) {
      category = 'Thiếu cân';
    } else if (bmi >= 18.5 && bmi < 25) {
      category = 'Bình thường';
    } else if (bmi >= 25 && bmi < 30) {
      category = 'Thừa cân';
    } else {
      category = 'Béo phì';
    }

    // Thêm giới tính vào thông báo
    return 'BMI: ${bmi.toStringAsFixed(2)} - $category (${_selectedGender})';
  }

  // Hàm xóa tất cả giá trị
  void _clearAll() {
    _weightController.clear();
    _heightController.clear();
    _bmiController.clear();
    setState(() {
      _selectedGender = 'Nam';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính chỉ số BMI'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lựa chọn giới tính
            Row(
              children: [
                Text(
                  'Giới tính:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedGender,
                  items: ['Nam', 'Nữ']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // Input cân nặng
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Cân nặng (kg)',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearAll,
                ),
              ),
              onChanged: (value) => _calculateBMI(),
            ),

            SizedBox(height: 20),

            // Input chiều cao
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Chiều cao (cm)',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearAll,
                ),
              ),
              onChanged: (value) => _calculateBMI(),
            ),

            SizedBox(height: 30),

            // Hiển thị BMI
            TextField(
              controller: _bmiController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Chỉ số BMI',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            // Nút xóa tất cả
            ElevatedButton.icon(
              onPressed: _clearAll,
              icon: Icon(Icons.refresh),
              label: Text('Xóa tất cả'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),

            SizedBox(height: 20),

            // Container hiển thị thông tin BMI
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Công thức tính BMI:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('BMI = Cân nặng (kg) / (Chiều cao (m) × Chiều cao (m))'),
                  SizedBox(height: 16),
                  Text(
                    'Phân loại BMI:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('• Dưới 18.5: Thiếu cân'),
                  Text('• 18.5 - 24.9: Bình thường'),
                  Text('• 25.0 - 29.9: Thừa cân'),
                  Text('• 30.0 trở lên: Béo phì'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
