import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  void initState() {
    super.initState();
    // فتح الـ Country Code Picker تلقائيًا عند تحميل الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCountryPicker();
    });
  }

  void showCountryPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // إزالة الزوايا المنحنية
          child: Container(
            width: double.infinity, // عرض كامل
            height: double.infinity, // ارتفاع كامل
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن دولة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: CountryCodePicker(
                    onChanged: (countryCode) {
                      print("تم اختيار كود الدولة: ${countryCode.dialCode}");
                      Navigator.of(context).pop(); // إغلاق الحوار بعد الاختيار
                    },
                    showFlag: true, // لعرض العلم بجانب اسم الدولة
                    showFlagDialog: true, // عرض العلم في القائمة داخل الحوار
                    showCountryOnly: true, // عرض الدول فقط
                    favorite: ['+20', 'EG', '+1', 'US'], // يمكنك إضافة الدول المفضلة هنا
                    initialSelection: 'EG', // الدولة الافتراضية (مثال مصر)
                    dialogTextStyle: TextStyle(fontSize: 16), // لتغيير حجم النص في الحوار
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار كود الدولة'),
      ),
      body: Center(
        child: Text('Loading...'), // يمكنك إضافة أي محتوى هنا
      ),
    );
  }
}
