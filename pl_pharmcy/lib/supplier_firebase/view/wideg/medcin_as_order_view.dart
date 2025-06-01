import 'package:flutter/material.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';
import 'package:pharmacyversiontow/supplier_firebase/model/medcin_item_model.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/medcin_item_wideg.dart';

class MedcinAsOrderView extends StatelessWidget {
  const MedcinAsOrderView(
      {super.key,
      required this.title,
      required this.listMedcinView,
      this.onOpenPage});
  final String title;
  final List<MedcinItemModel> listMedcinView;
  final Function? onOpenPage;

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "title = $title \n list medicin $listMedcinView \n onopenpage true or false ${onOpenPage == null}");
    if (onOpenPage != null) {
      onOpenPage!();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          shrinkWrap: true,
          itemCount: listMedcinView.length,
          itemBuilder: (contxt, i) {
            print(
                "--- listMedcinView[i]  ${listMedcinView[i].medcinDescrption!.length > 20 ? listMedcinView[i].medcinDescrption!.substring(0, 20) : listMedcinView[i].medcinDescrption}");
            return MedcinItemWideg(
              medcinItemModel: listMedcinView[i],
              imgeContainerHeight: SizeConfig.screenHeiht! * 0.13,
              imgeContainerwidth: SizeConfig.screenWidth! * 0.9,
            );
          }),
    );
  }
}
