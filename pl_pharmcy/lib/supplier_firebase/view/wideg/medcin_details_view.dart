import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacyversiontow/core/stateces/custom_title.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';
import 'package:pharmacyversiontow/supplier_firebase/model/medcin_item_model.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/icon.dart';

class MedcinDetailsView extends StatelessWidget {
  const MedcinDetailsView({
    super.key,
    this.medcinItemModel,
    this.orderMedicin,
    this.addTofavirt,
  });
  final MedcinItemModel? medcinItemModel;
  final void Function()? orderMedicin;
  final void Function()? addTofavirt;

  @override
  Widget build(BuildContext context) {
    debugPrint("-=-=-=-final medcinItemModel $medcinItemModel =-=-=-=");
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          medcinItemModel!.medcinAmge == null
              ? SizedBox(
                  height: SizeConfig.screenHeiht! * 0.5,
                  width: SizeConfig.screenWidth,
                  child: const Text("No Image"),
                )
              : SizedBox(
                  height: SizeConfig.screenHeiht! * 0.5,
                  width: SizeConfig.screenWidth,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: medcinItemModel!.medcinAmge!,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),

                  // Image.network(
                  //   medcinItemModel!.medcinAmge!,
                  //   fit: BoxFit.cover,
                  // )
                ),
          Container(
            margin: EdgeInsets.all(SizeConfig.defaultSize!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medcinItemModel!.medcinName!,
                  style: TextStyle(fontSize: SizeConfig.defaultSize! * 4),
                ),
                CustomTitle(
                  title: "209".tr,
                  fontSize: SizeConfig.defaultSize! * 2,
                ),
                // Text(
                //   "Description",
                //   style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
                // ),
                SizedBox(
                  height: SizeConfig.screenHeiht! * 0.15,
                  child: Container(
                    height: SizeConfig.screenHeiht! * 0.19,
                    child: ListView(children: [
                      Text(
                        medcinItemModel!.medcinDescrption!,
                        style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 0.5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleAndIcon(
                      title: "${medcinItemModel!.numberOfViews!}",
                      icon: Icons.task_alt,
                    ),
                    SizedBox(
                      width: SizeConfig.defaultSize!,
                    ),
                    TitleAndIcon(
                      title: "${medcinItemModel!.salare!}",
                      icon: Icons.monetization_on,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.defaultSize! * 18,
                                    SizeConfig.defaultSize! * 5))),
                            onPressed: orderMedicin,
                            child: Text("153".tr)),
                        ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(Size(
                                    SizeConfig.defaultSize! * 18,
                                    SizeConfig.defaultSize! * 5))),
                            onPressed: addTofavirt,
                            child: Text("154".tr)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
