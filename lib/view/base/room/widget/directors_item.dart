import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/response/get_black_list_model.dart';
import '../../../../util/colors.dart';
import '../../../../util/styles.dart';

class DirectorsItem extends StatelessWidget {
  const DirectorsItem({super.key});
  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        SizedBox(width: 10.w,),
        Text('1.',style: robotoGreySmall.copyWith(color: Colors.black)),
        SizedBox(width: 5.w,),
        ClipOval(
          child: Image(
            image: const NetworkImage(
                'https://th.bing.com/th/id/OIP.hLTThhxHPeGqFQVjpD1-hwHaE8?rs=1&pid=ImgDetMain'),
            width: 50.w,
            height: 50.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            Text('aaa',style: robotoLargeBold.copyWith(fontWeight: FontWeight.w500),),
            Container(
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.lightBlueAccent.shade100  ,
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.male,color:  Colors.blue,),
              ),
            )
          ],
        ),
        const Spacer(),
        Container(
          height: 30.h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorManger.colorPurple),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Delete',style: robotoWhite.copyWith(color: ColorManger.colorPurple),),
            ),
          ),
        ),
        SizedBox(width: 15.w,)
      ],
    );
  }
}
