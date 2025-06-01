import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharmacyversiontow/core/stateces/custom_title.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';
import 'package:pharmacyversiontow/supplier_firebase/controller/main_supplier_controller.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/custom_categories_item.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/medcin_item_wideg.dart';

class EditViewMedcin extends StatelessWidget {
  const EditViewMedcin({super.key});

  @override
  Widget build(BuildContext context) {
    MainSupplierController mainSupplierController =
        Get.put(MainSupplierController());
    mainSupplierController.getTheMostViwes();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
            title: "201".tr,
            fontSize: SizeConfig.defaultSize! * 2,
          ),
          Container(
            height: SizeConfig.screenHeiht! * 0.15,
            width: SizeConfig.screenWidth,
            child: ListView.builder(
              itemCount: mainSupplierController.catgresList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => CustomCategoriesItem(
                ontap: () {
                  return mainSupplierController.onChaingCatgre(i);
                },
                image: mainSupplierController.catgresList[i].catgreURL,
                catgoreName: mainSupplierController.catgresList[i].catgreName,
                imgeContainerHeight: SizeConfig.screenHeiht! * .1,
                imgeContainerwidth: SizeConfig.screenWidth! * 0.2,
              ),
            ),
          ),
          CustomTitle(
            title: "202".tr,
            fontSize: SizeConfig.defaultSize! * 2,
          ),
          Container(
            height: SizeConfig.screenHeiht! * 0.3,
            width: SizeConfig.screenWidth,
            child: GetBuilder<MainSupplierController>(
              builder: (controler) =>
                  mainSupplierController.medcinItemList.length == 0
                      ? Center(
                          child: LinearProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount:
                              mainSupplierController.medcinItemList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => MedcinItemWideg(
                            medcinItemModel:
                                mainSupplierController.medcinItemList[i],
                            imgeContainerHeight: SizeConfig.screenHeiht! * .2,
                            imgeContainerwidth: SizeConfig.screenWidth! * 0.9,
                          ),
                        ),
            ),
          ),
          CustomTitle(
            title: "203".tr,
            fontSize: SizeConfig.defaultSize! * 2,
          ),
          Container(
            height: SizeConfig.screenHeiht! * 0.3,
            width: SizeConfig.screenWidth,
            child: GetBuilder<MainSupplierController>(
              builder: (controler) =>
                  mainSupplierController.medcinItemList.length == 0
                      ? Center(
                          child: LinearProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount:
                              mainSupplierController.medcinItemList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => MedcinItemWideg(
                            medcinItemModel:
                                mainSupplierController.medcinItemList[i],
                            imgeContainerHeight: SizeConfig.screenHeiht! * .2,
                            imgeContainerwidth: SizeConfig.screenWidth! * 0.9,
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
