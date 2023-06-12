import 'package:flutter/material.dart';
import 'package:trading_app/core/color/color.dart';
import 'package:trading_app/responsive/responsive.dart';

class ButtonWithDraw extends StatelessWidget {
  final Color color;
  final String title;
  final void Function()? ontap;
  const ButtonWithDraw({
    super.key,
    required this.color,
    required this.title,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: Responsive.heightMultiplier! * 7,
        width: Responsive.widthMultiplier! * 35,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Apc.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidgetForAppBAR extends StatelessWidget {
  final Widget child1;

  const CircleAvatarWidgetForAppBAR({
    super.key,
    required this.child1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Apc.white.withOpacity(0.5),
            radius: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Apc.white,
              child: child1,
            ),
          ),
        ],
      ),
    );
  }
}
