import 'package:flutter/material.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';

class CustomCategoriesItem extends StatelessWidget {
  const CustomCategoriesItem(
      {super.key,
      this.image,
      this.imgeContainerHeight,
      this.imgeContainerwidth,
      this.catgoreName,
      this.ontap});
  final String? image;
  final double? imgeContainerHeight;
  final double? imgeContainerwidth;
  final String? catgoreName;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        margin: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.5),
        child: Container(
          child: Column(
            children: [
              image == null
                  ? Container(
                      child: Center(
                        child: Text("no image"),
                      ),
                      height: imgeContainerHeight,
                      width: imgeContainerwidth,
                    )
                  : Container(
                      height: imgeContainerHeight,
                      width: imgeContainerwidth,
                      child: Image.asset(image!),
                    ),
              Text(catgoreName == null ? 'unknown name' : catgoreName!),
            ],
          ),
        ),
      ),
    );
  }
}
