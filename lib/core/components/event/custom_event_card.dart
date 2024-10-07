import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomEventCard extends StatelessWidget {
  final String? title;

  final String? imageUrl;
  final VoidCallback? onPressed;
  final Function? onPressedIcon;
  final void Function()? inviter;
  final double? width;
  final double? height;
  const CustomEventCard({
    super.key,
    this.title,
    this.imageUrl,
    this.onPressed,
    this.width,
    this.height,
    this.onPressedIcon,
    this.inviter,
    //  this.idEvent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 400,
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: Image.network(
                    imageUrl!,
                    width: width,
                    height: 200.0,
                    //  fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "\t\t$title\n",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        //  Text.rich(
                        //   TextSpan(
                        //     text: "$title\n",
                        //     style: const TextStyle(
                        //       fontSize: 18.0,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     // children: [
                        //     //   TextSpan(
                        //     //     text: dispoDate,
                        //     //     style: const TextStyle(
                        //     //       fontSize: 18.0,
                        //     //       fontWeight: FontWeight.w500,
                        //     //     ),
                        //     //   )
                        //     // ],
                        //   ),
                        // ),
                        ),
                    const SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        print('comment------------------------');
                        onPressedIcon!();
                      },
                      icon: const Icon(
                        Icons.comment,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
