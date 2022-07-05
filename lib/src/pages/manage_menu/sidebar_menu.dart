import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? fontSize;
  final VoidCallback? onPressed;

  const SideBarMenu({Key? key,
    this.fontSize,
    required this.title,
    required this.icon,
    required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFontScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.0),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.center),
        child: Container(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20,),
              Text(
                title,
                style: TextStyle(
                  fontSize: (fontSize ?? 11)/userFontScale,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
