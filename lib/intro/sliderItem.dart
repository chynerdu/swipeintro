import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final Color color;
  final String slideImage;

  const SlideItem({super.key, required this.color, required this.slideImage});

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
        ),
        child: slideImage != ''
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 84, horizontal: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(slideImage))),
              )
            : const SizedBox.shrink());
  }
}
