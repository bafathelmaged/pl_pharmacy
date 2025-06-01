import 'package:flutter/material.dart';
import 'package:pharmacyversiontow/core/theme/app_theme.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';

class TitleAndIcon extends StatelessWidget {
  const TitleAndIcon({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.defaultSize!),
        border: Border.all(color: AppTheme.darkTheme.primaryColor),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
          ),
          SizedBox(
            width: SizeConfig.defaultSize! * .5,
          ),
          Icon(icon)
        ],
      ),
    );
  }
}
