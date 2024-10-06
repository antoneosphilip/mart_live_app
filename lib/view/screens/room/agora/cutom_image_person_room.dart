import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/controller/room_controller.dart';

import '../../../../data/model/response/room_model.dart';

class CustomImagePersonRoom extends StatefulWidget {
  final String image;
  final Chairs? chair;

  const CustomImagePersonRoom(
      {super.key, required this.image, required this.chair});

  @override
  State<CustomImagePersonRoom> createState() => _CustomImagePersonRoomState();
}

class _CustomImagePersonRoomState extends State<CustomImagePersonRoom>
    with SingleTickerProviderStateMixin {
  final roomController = Get.find<RoomController>();

  @override
  void initState() {
    roomController.userAnimation(
      vsync: this, // تمرير الـ vsync
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: roomController.animation!,
      builder: (context, child) {
        return Container(
          decoration: widget.chair!.teamNumber == 0
              ? const BoxDecoration()
              : BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.chair!.teamNumber == 1 ? Colors.red : Colors.green,
                ),
          child: Padding(
            padding:  EdgeInsets.all(widget.chair!.teamNumber == 0?0:1.0),
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder:
                      'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                  image: widget.image,
                  fit: BoxFit.cover,
                  // Ensure the image covers the entire circular area
                  imageErrorBuilder: (context, error, stackTrace) {
                    return const Image(
                        image: NetworkImage(
                            'https://www.bing.com/th?id=OIP.roQHQEuNf8SdJJ7wS3RxtgHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2')); // Handle image loading error
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
