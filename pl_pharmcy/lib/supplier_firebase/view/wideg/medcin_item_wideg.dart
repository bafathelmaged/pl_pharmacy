import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';
import 'package:pharmacyversiontow/supplier_firebase/controller/main_supplier_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pharmacyversiontow/supplier_firebase/model/medcin_item_model.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/medcin_details_view.dart';
import 'package:pharmacyversiontow/supplierlogin/view/widget/coustom_textformviled_vildetion.dart';

class MedcinItemWideg extends StatelessWidget {
  const MedcinItemWideg(
      {super.key,
      this.imgeContainerHeight,
      this.imgeContainerwidth,
      required this.medcinItemModel,
      this.outerContainerWidth});
  final double? imgeContainerHeight;
  final double? imgeContainerwidth;
  final double? outerContainerWidth;
  final MedcinItemModel medcinItemModel;

  @override
  Widget build(BuildContext context) {
    MainSupplierController mainSupplierController = Get.find();
    debugPrint(
        "medcinItemModel.name ${medcinItemModel.medcinAmge}==-=-== ${medcinItemModel.medcinAmge == null}");
    return Card(
      surfaceTintColor: Colors.white,
      child: InkWell(
        onTap: () {
          Get.to(() => MedcinDetailsView(
                medcinItemModel: medcinItemModel,
                addTofavirt: () {
                  mainSupplierController.addToFavirt(
                    medcinItemModel.medcinName!,
                    medcinItemModel.medicinQuantity!,
                    medcinItemModel.salare!,
                    medcinItemModel.medcinAmge!,
                    medcinItemModel.medcinDescrption!,
                    medcinItemModel.supplerName!,
                    medcinItemModel.numberOfViews!,
                    medcinItemModel.ownerId!,
                  );
                },
                orderMedicin: () {
                  Get.defaultDialog(
                      title: "maged",
                      middleText: "my name is maged",
                      content: Column(
                        children: [
                          CoustomTextFormFiledVildtion(
                            validator: mainSupplierController.isQuantityValide,
                            name: "132".tr,
                            hintText: "155".tr,
                            myController: mainSupplierController.validQantity,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    mainSupplierController.addMedicinOrder(
                                        medcinItemModel.medcinName!,
                                        medcinItemModel.salare!,
                                        medcinItemModel.ownerId!);
                                    Get.back();
                                  },
                                  child: Text("62".tr)),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("156".tr)),
                            ],
                          )
                        ],
                      ));
                },
              ));
        },
        child: SizedBox(
          width: SizeConfig.screenWidth! * 0.5,
          // margin: EdgeInsets.all(SizeConfig.defaultSize!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              medcinItemModel.medcinAmge == null
                  ? Container(
                      color: Colors.black,
                      height: imgeContainerHeight,
                      width: imgeContainerwidth,
                      child: const Center(
                        child: Text(
                          "no image",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: imgeContainerHeight,
                      width: SizeConfig.screenWidth, //imgeContainerwidth,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: medcinItemModel.medcinAmge!,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),

                      // Image.network(
                      //   medcinItemModel.medcinAmge!,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
              Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.defaultSize!,
                    right: SizeConfig.defaultSize!),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.defaultSize! * 1.5),
                          child:
                              const Icon(Icons.medical_information_outlined)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: SizeConfig.screenWidth! * 0.5,
                        padding: EdgeInsets.only(
                            left: SizeConfig.defaultSize! * 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medcinItemModel.medcinName!.length > 10
                                  ? "${medcinItemModel.medcinName!.substring(0, 10)} ..."
                                  : medcinItemModel.medcinName!,
                              style: TextStyle(
                                  fontSize: SizeConfig.defaultSize! * 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              medcinItemModel.medcinDescrption!.length > 35
                                  ? "${medcinItemModel.medcinDescrption!.substring(0, 35)} ..."
                                  : medcinItemModel.medcinDescrption!,
                              style: TextStyle(
                                  fontSize: SizeConfig.defaultSize! * 1.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
