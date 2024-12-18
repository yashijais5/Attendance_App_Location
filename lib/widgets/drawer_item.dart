import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(
        icon,
        size: 22,
        color: Color(0xFF4A3B83),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D2A4A),
        ),
      ),
      onTap: onTap,
      dense: true,
      horizontalTitleGap: 12,
    );
  }
}

