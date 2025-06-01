import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacyversiontow/core/utils/sizeconfig.dart';
import 'package:pharmacyversiontow/supplier_firebase/controller/main_supplier_controller.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/add_supplier_medicin_widget.dart';

class AddSupplierMedicin extends StatelessWidget {
  AddSupplierMedicin({super.key});
  final MainSupplierController mainSupplierController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("118".tr)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: SizeConfig.screenHeiht! * 0.3,
                    padding: EdgeInsets.all(SizeConfig.defaultSize!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Container(
                              child: const Icon(
                            Icons.image_search,
                            size: 50,
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    mainSupplierController.uploadImage(
                                        mainSupplierController.pikedImage,
                                        mainSupplierController.file,
                                        ImageSource.gallery);
                                  },
                                  child: Text("119".tr)),
                            ),
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    mainSupplierController.uploadImage(
                                        mainSupplierController.pikedImage,
                                        mainSupplierController.file,
                                        ImageSource.camera);
                                  },
                                  child: Text("120".tr)),
                            )
                          ],
                        )
                      ],
                    )),
                AddSupplierMedicinWidget(
                  txtFormFildController: mainSupplierController.nameMedicin,
                  labelTextFiled: "121".tr,
                  hintTextFiled: "122".tr,
                ),
                AddSupplierMedicinWidget(
                  txtFormFildController: mainSupplierController.priceMedicin,
                  labelTextFiled: "123".tr,
                  hintTextFiled: "124".tr,
                ),
                AddSupplierMedicinWidget(
                  txtFormFildController: mainSupplierController.quantityMedicin,
                  labelTextFiled: "125".tr,
                  hintTextFiled: "126".tr,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize! * 1.5),
                  child: Title(
                      color: Colors.black,
                      child: Text(
                        "204".tr,
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize! * 2,
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.defaultSize! * 1.5,
                    left: SizeConfig.defaultSize! * 1.5,
                    right: SizeConfig.defaultSize! * 1.5,
                  ),
                  width: SizeConfig.screenWidth! * 0.7,

                  //width: SizeConfig.screenWidth!*0.25,
                  child: GetBuilder<MainSupplierController>(
                    builder: (controller) => DropdownButton(
                      isExpanded: true,
                      items: mainSupplierController.medicinAllTypesList
                          .map((e) => DropdownMenuItem(
                                value: "$e",
                                child: Text("$e"),
                              ))
                          .toList(),
                      onChanged: (val) {
                        mainSupplierController.changMedicintype(val!);
                      },
                      value: mainSupplierController.selectedMedicinType,
                    ),
                  ),
                ),
                AddSupplierMedicinWidget(
                  txtFormFildController:
                      mainSupplierController.medicinDecription,
                  labelTextFiled: "127".tr,
                  hintTextFiled: "128".tr,
                  maxLine: 9,
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 3,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        mainSupplierController.addMedicinToFierbase();
                        Get.back();
                      },
                      child: Text("129".tr)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
