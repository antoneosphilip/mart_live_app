import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/view/screens/room/agora/show_profile_container.dart';

import '../../../../controller/room_controller.dart';
import '../../../../data/model/response/room_model.dart';
import '../../../../util/styles.dart';

class CustomOwnerItem extends StatelessWidget {
  final Chairs? chair;
  final RoomModel roomModel;

  const CustomOwnerItem({super.key, this.chair, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    final roomController=Get.find<RoomController>();
    return GetBuilder<RoomController>(builder: (RoomController roomController) {
      return  InkWell(
        onTap: () {
          if(!roomModel.isOwner!)
          {
            if((chair!.user!=null)){
              showDialog(
                context: context,
                builder: (context) {
                  return showProfileUserContainer(
                    user: chair!.user!,
                  );
                },
              );
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.blue,
                      width: roomController.borderThickness
                  )
              ),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder:
                  'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                  // Provide a local placeholder image
                  image:
                  '${roomController.inRoom!.owner!.image}',
                  fit: BoxFit.cover,
                  // Ensure the image covers the entire circular area
                  imageErrorBuilder: (context,
                      error, stackTrace) {
                    return const Image(
                        image: NetworkImage(
                            'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2')); // Handle image loading error
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 4.0),
              // Reduce top padding
              child: Text(
                roomController
                    .inRoom!.owner!.name!,
                // Show only the first name
                style: robotoWhite.copyWith(
                    fontSize: 10),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                // Avoid overflow
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    },

    );
  }
}
