
import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:bhaashini/res/routes/approutes.dart';
import 'package:flutter/material.dart';

class AppBarReusable extends StatelessWidget implements PreferredSizeWidget {
  const AppBarReusable(
      {super.key, required this.title, this.onpressedHome, this.onPressedBack});
  final String title;
  final void Function()? onpressedHome, onPressedBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: onPressedBack != null
              ? onPressedBack
              : () {
                  Navigator.pop(context);
                },
          icon: Icon(Icons.arrow_back)),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: ColorConstants.appColor,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            onTap: onpressedHome != null
                ? onpressedHome
                : () {
                    Navigator.pushNamed(context, AppRoutes.dashboard);
                  })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
