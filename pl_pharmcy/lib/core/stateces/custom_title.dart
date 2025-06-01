import 'package:flutter/material.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, this.title, this.fontSize});
  final String? title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue[100],
      padding: EdgeInsets.all(SizeConfig.defaultSize!),
      margin: EdgeInsets.all(SizeConfig.defaultSize!),
      child: Text(
        title == null ? "untitle" : title!,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
