import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WidgetAppBar extends StatelessWidget {
  final bool itHaveBack;
  final IconData? leadingIcon;
  final String? title;
  final Widget? trailing;
  const WidgetAppBar(
      {super.key,
      this.leadingIcon,
      this.title,
      this.trailing,
      required this.itHaveBack});

  @override
  Widget build(BuildContext context) {
    SizedBox empty = const SizedBox();
    return Container(
      width: double.infinity,
      height: 90,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurStyle: BlurStyle.outer, blurRadius: 4, color: grey)
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itHaveBack
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        leadingIcon ?? CupertinoIcons.back,
                        color: orange,
                      )),
                )
              : empty,
          title != null
              ? Align(
                  alignment: Alignment.center,
                  child: Text(title!,
                      style: const TextStyle(
                          color: black, fontWeight: FontWeight.bold)),
                )
              : empty,
          trailing != null
              ? Align(alignment: Alignment.centerRight, child: trailing!)
              : empty
        ],
      ),
    );
  }
}
