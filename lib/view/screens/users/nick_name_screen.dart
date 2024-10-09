import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_app/util/dimensions.dart';
import 'package:live_app/util/styles.dart';
import 'package:live_app/view/widgets/app_bar.dart';

class NickNameScreen extends StatefulWidget {
  NickNameScreen({super.key});

  @override
  State<NickNameScreen> createState() => _NickNameScreenState();
}

class _NickNameScreenState extends State<NickNameScreen> {
  final TextEditingController _controller = TextEditingController();
  int _charCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        name: 'Nickname',
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                "Confirm",
                style: robotoWhite.copyWith(
                  color: _charCount > 0 ? Colors.pink : Colors.grey,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                maxLines: null,
                onChanged: (text) {
                  setState(() {
                    _charCount = text.length; // تحديث عدد الأحرف عند الكتابة
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'tony 3',
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${_charCount}/50',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
