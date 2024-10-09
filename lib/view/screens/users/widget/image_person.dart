import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImagePerson extends StatelessWidget {
  const ProfileImagePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 16.w,),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage('https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'), // استخدم صورة موجودة لديك
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          SizedBox(width: 20.w),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child:  Center(
                child: Icon(Icons.add,color: Colors.grey[400],size: 40.sp,)
            ),
          ),
        ],
      ),
    );
  }
}
