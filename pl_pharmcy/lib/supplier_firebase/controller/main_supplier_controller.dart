import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pharmacyversiontow/core/firebase_db.dart';
import 'package:pharmacyversiontow/core/firebase_storge.dart';
import 'package:pharmacyversiontow/supplier_firebase/model/catgre_item.dart';
import 'package:pharmacyversiontow/supplier_firebase/model/medcin_item_model.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/screen/edit_view_medcine.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/screen/profile.dart';
import 'package:pharmacyversiontow/supplier_firebase/view/wideg/medcin_as_order_view.dart';
// import 'package:pharmacyversiontow/supplier_firebase/view/screen/view_medicin.dart';

enum MedicinAllTypes { palliative, antibiotic, chronicDiseases, skinCare }

class MainSupplierController extends GetxController {
  final Databasemethods databasemethods = Databasemethods();
  final FirebaseStorgeMothed firebaseStorgeMothed = FirebaseStorgeMothed();
  int selectedIndex = 0;
  String? cloadinryImageUrl;

  List<Widget> getPages = [EditViewMedcin(), Profile()];

  void chaingePage(int index) {
    selectedIndex = index;
    update();
  }

  //////////////////////////// add medicin to firebase  //////////////////////////////////////////
  final nameMedicin = TextEditingController();
  final priceMedicin = TextEditingController();
  final quantityMedicin = TextEditingController();
  final medicinDecription = TextEditingController();
  String medicinType = "palliative";
  File? file;
  var imagePicker = ImagePicker();
  var pikedImage;
  List medicinAllTypesList = ["205".tr, "206".tr, "207".tr, "208".tr];
  String selectedMedicinType = "205".tr;
  changMedicintype(String value) {
    selectedMedicinType = value;
    if (value == "205".tr) {
      medicinType = "palliative";
    } else if (value == "206".tr) {
      medicinType = "antibiotic";
    } else if (value == "207".tr) {
      medicinType = "chronicDiseases";
    } else if (value == "208".tr) {
      medicinType = "skinCare";
    }
    debugPrint(medicinType);
    update();
  }

  Future<XFile?> uploadImage(
      var pikeImagee, File? imageFile, ImageSource imagesources) async {
    pikeImagee = await imagePicker.pickImage(source: imagesources);
    debugPrint("$pikeImagee");
    if (pikeImagee != null) {
      pikedImage = File(pikeImagee.path);
      print("==========================================================");
      print("pikeImage.path :${pikeImagee.path}");
      return pikeImagee;
    } else {
      print("chose image please");
    }
    return null;
  }

  void addMedicinToFierbase() async {
    try {
      QuerySnapshot supplierInformation = await getusername();

      List<QueryDocumentSnapshot> supplier = supplierInformation.docs;

      String? supplierName;
      supplier.forEach((element) {
        supplierName = element["username"];
        print("$supplierName");
      });

      String? imageUrl;
      debugPrint("================ 0 =================");
      debugPrint("================ $pikedImage =================");

      if (pikedImage != null) {
        print("=================1======================");
        var saveImageName = basename(pikedImage!.path);
        print("=================2======  $saveImageName================");

        debugPrint("===== cloadIinry Image uploading ====");
        imageUrl = await coadinaryUploadImag();
        debugPrint("===== cloadIinry Image uploaded ====");
        debugPrint("===== cloadIinry Image url $imageUrl ====");
        // firebaseStorgeMothed.addImage(
        //     pikedImage!, "images/$saveImageName");
        print("=================3======================");
      }

      if (imageUrl != null) {
        databasemethods.addData({
          "medicinName": nameMedicin.text,
          "medicinQuantity": quantityMedicin.text,
          "unitprice": priceMedicin.text,
          "medicinType": medicinType,
          "imagUrl": "$imageUrl",
          "medicinDecription": medicinDecription.text,
          "ordernumber": 0,
          "suppliername": supplierName,
          "userId": FirebaseAuth.instance.currentUser!.uid,
        }, "${Random().nextInt(10000000)}", "medicinTable").then((value) {
          Fluttertoast.showToast(
              msg: "medicin infor have been edit successfully ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        Get.snackbar("SUCSSAFULE", "storde medicin firebase done");

        update();
      } else {
        Get.defaultDialog(title: "ERROR", middleText: "image can not be empty");
      }
    } catch (e) {
      Get.defaultDialog(title: "ERROR", middleText: "$e");
    }
  }

  Future<QuerySnapshot> getusername() async {
    return await databasemethods.sreachData(
        "users", "userid", FirebaseAuth.instance.currentUser!.uid);
  }

  ///////////get my medicin///////////////////////
  Future<QuerySnapshot> getMyMedicin() async {
    return await databasemethods.sreachData(
        "medicinTable", "userId", FirebaseAuth.instance.currentUser!.uid);
  }

  ////////////////////////////get fivert medicin/////////////////////////////////////////////////////
  Future<QuerySnapshot> getFivertMedicin() async {
    return await databasemethods.sreachData(
        "favirtTable", "userId", FirebaseAuth.instance.currentUser!.uid);
  }

  /////////////////////////////////////////////////////  delete my medicin   //////////////////////////////
  Future<void> deleteMedicin(String medicinId, String imageUrl) async {
    await databasemethods.deleteRecord("medicinTable", medicinId).then((value) {
      Fluttertoast.showToast(
          msg: "medicin infor have been delete successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  /////////////////////////////////////////////////delete fivert medicin//////////////////////////////////
  Future<void> deleteFivertMedicin(String medicinId, String imageUrl) async {
    await databasemethods.deleteRecord("favirtTable", medicinId).then((value) {
      Fluttertoast.showToast(
          msg: "medicin infor have been delete successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    //await firebaseStorgeMothed.deleteImage(imageUrl);
    update();
  }

  ////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////
  //////////////////////update my medicin//////////////////////////////
  final updateNameMedicin = TextEditingController();
  final updatePriceMedicin = TextEditingController();
  final updateQuantityMedicin = TextEditingController();
  final updateMedicinDecription = TextEditingController();
  String? oldImageUr;
  String? recoredId;
  File? updateFile;
  var updateImagePicker = ImagePicker();
  var updatePikedImage;
  void getAgrument() {
    updateNameMedicin.text = Get.arguments["medicinName"];
    updatePriceMedicin.text = Get.arguments["unitprice"];
    updateQuantityMedicin.text = Get.arguments["medicinQuantity"];
    updateMedicinDecription.text = Get.arguments["medicinDecription"];
    oldImageUr = Get.arguments["imagUrl"];
    recoredId = Get.arguments["recoredId"];
  }

  Future<void> updateMedicin() async {
    String? imageUrl;

    if (updateFile == null) {
      await databasemethods.updateRecord("medicinTable", recoredId!, {
        "medicinName": updateNameMedicin.text,
        "unitprice": updatePriceMedicin.text,
        "medicinQuantity": updateQuantityMedicin.text,
        "medicinDecription": updateMedicinDecription.text,
      }).then((value) {
        Fluttertoast.showToast(
            msg: "medicin infor have been edit successfully ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      var saveImageName = basename(updatePikedImage.path);
      imageUrl =
          await firebaseStorgeMothed.addImage(file!, "images/$saveImageName");

      await databasemethods.updateRecord("medicinTable", recoredId!, {
        "medicinName": updateNameMedicin.text,
        "unitprice": updatePriceMedicin.text,
        "medicinQuantity": updateQuantityMedicin.text,
        "medicinDecription": updateMedicinDecription.text,
        "imagUrl": imageUrl,
      }).then((value) {
        Fluttertoast.showToast(
            msg: "medicin infor have been edit successfully ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

      firebaseStorgeMothed.deleteImage(oldImageUr!);
    }
    update();
  }

  /////////////////     get data from firebase      //////////////////
  Future<QuerySnapshot>? listMedicin;
  //StreamBuilder<QuerySnapshot>? listMedicin;
  List<QueryDocumentSnapshot>? listDocs;
  Future<QuerySnapshot<Map<String, dynamic>>> getDataFirebase() async {
    print("==================== 2 ==================================");
    return await databasemethods.getMedicinData("medicinTable");
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirebasPalliativeMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.sreachData(
        "medicinTable", "medicinType", "palliative");
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirebasAntibioticMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.sreachData(
        "medicinTable", "medicinType", "antibiotic");
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirebasChronicDiseasesMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.sreachData(
        "medicinTable", "medicinType", "chronicDiseases");
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirebasSkinCareMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.sreachData(
        "medicinTable", "medicinType", "skinCare");
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFirebasNewMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.getMedicinData("medicinTable");
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getFirebasMostRequestedMedicin() async {
    print("==================== 2 ==================================");
    return await databasemethods.getMedicinData("medicinTable");
  }

  ///////////////////////////////////////////////  favirt screen  ///////////////////////////////////
  addToFavirt(
      String favirtMedicinName,
      String favirtMedicinQuantity,
      String favirtMedicinPrice,
      String favirtImageUrl,
      String favirtMedicinDecription,
      String favirtSupplierName,
      int favirtOrderNumber,
      String ownerId) {
    databasemethods.addData({
      "medicinName": favirtMedicinName,
      "medicinQuantity": favirtMedicinQuantity,
      "unitprice": favirtMedicinPrice,
      "imagUrl": favirtImageUrl,
      "medicinDecription": favirtMedicinDecription,
      "ordernumber": favirtOrderNumber,
      "suppliername": favirtSupplierName,
      "ownerId": ownerId,
      "userId": FirebaseAuth.instance.currentUser!.uid,
    }, "${Random().nextInt(10000000)}", "favirtTable").then((value) {
      Fluttertoast.showToast(
          msg: "medicin infor have been edit successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////// MEDICIN ORDER /////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  addMedicinOrder(
    String orderMedicinName,
    String orderMedicinPrice,
    String ownerId,
  ) async {
    QuerySnapshot customersInformation = await getusername();

    List<QueryDocumentSnapshot> customers = customersInformation.docs;

    String? customerName;
    customers.forEach((element) {
      customerName = element["username"];
      print("$customerName");
    });

    databasemethods.addData({
      "medicinName": orderMedicinName,
      "medicinQuantity": validQantity.text,
      "unitprice": orderMedicinPrice,
      "ordernumber": Random().nextInt(5000000),
      "ownerId": ownerId,
      "customerId": FirebaseAuth.instance.currentUser!.uid,
      "customerName": customerName,
      "orderType": "Not processed",
    }, "${Random().nextInt(10000000)}", "ordersTable").then((value) {
      Fluttertoast.showToast(
          msg: "medicin infor have been edit successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });

    update();
  }

  ////////////////////////////// valid Quantity  ///////////////////////////
  TextEditingController validQantity = TextEditingController();
  String? isQuantityValide(String? value) {
    if (value!.isEmpty ||
        !RegExp(r'(^(?:[+0]9)?[0-9a-z@#$&_]{1,12}$)').hasMatch(value)) {
      return 'the password can be only\n numbers and letters and @#\$&';
    }

    return null;
  }

  TextEditingController validNumber = TextEditingController();
  String? isPhoneNumberValide(String? value) {
    if (value!.isEmpty ||
        !RegExp(r'(^(?:[+0]9)?[0-9]{1,12}$)').hasMatch(value)) {
      return 'the phone number can be only numbers ';
    }

    return null;
  }

  TextEditingController validAddress = TextEditingController();
  String? isAddressValide(String? value) {
    if (value!.isEmpty ||
        !RegExp(r'(^(?:[+0]9)?[0-9a-zA-Z/]{1,12}$)').hasMatch(value)) {
      return 'the phone number can be only numbers ';
    }

    return null;
  }

  //////////////////////  get medicin orders //////////////////////////
  Future<QuerySnapshot> getOrdersMedicin() async {
    return await databasemethods.sreachData(
        "ordersTable", "ownerId", FirebaseAuth.instance.currentUser!.uid);
  }

  /////////////////////////////  delete order medicin

  Future<void> deleteOrderMedicin(String orderId, {String? imageUrl}) async {
    await databasemethods.deleteRecord("ordersTable", orderId).then((value) {
      Fluttertoast.showToast(
          msg: "order infor have been delete successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    //await firebaseStorgeMothed.deleteImage(imageUrl);
    update();
  }

  // ===================================================================================
  // ===================================================================================
  List<CategreItem> catgresList = [
    const CategreItem(
        catgreName: "palliative",
        catgreURL: "assets/images/hospice-care-icon-3.png"),
    const CategreItem(
        catgreName: "antibiotic", catgreURL: "assets/images/antibiotic_2.png"),
    const CategreItem(
        catgreName: "chronic diseases",
        catgreURL: "assets/images/medical-4.png"),
    const CategreItem(
        catgreName: "skin care", catgreURL: "assets/images/skin care_6.png"),
  ];
  getTheMostViwes() async {
    List<MedcinItemModel> firestMedcinItemList = [];
    QuerySnapshot<Map<String, dynamic>> medcinItemQuiry =
        await getDataFirebase();
    firestMedcinItemList = medcinItemQuiry.docs.map((e) {
      Map<String, dynamic> data = e.data();
      return MedcinItemModel(
          supplerName: data["suppliername"],
          medicinQuantity: data["medicinQuantity"],
          ownerId: data["userId"],
          medcinAmge: data["imagUrl"],
          medcinName: data["medicinName"],
          numberOfViews: data["ordernumber"],
          medcinDescrption: data["medicinDecription"],
          salare: data["unitprice"],
          typeOfMedcin: data["medicinType"]);
    }).toList();
    MedcinItemModel argumSaveValue;
    for (int i = 0; i < firestMedcinItemList.length - 1; i++) {
      if (firestMedcinItemList[i].numberOfViews! <
          firestMedcinItemList[i + 1].numberOfViews!) {
        argumSaveValue = firestMedcinItemList[i];
        firestMedcinItemList[i] = firestMedcinItemList[i + 1];
        firestMedcinItemList[i + 1] = argumSaveValue;
      }
      medcinItemList = firestMedcinItemList;
      update();
    }
  }

  getPalliativeMedicin() async {
    QuerySnapshot<Map<String, dynamic>> pallativeItemQuiry =
        await getFirebasPalliativeMedicin();
    pallativeItemList = pallativeItemQuiry.docs.map((e) {
      Map<String, dynamic> data = e.data();
      debugPrint("--------------$data -----------------");
      return MedcinItemModel(
          supplerName: data["suppliername"],
          medicinQuantity: data["medicinQuantity"],
          ownerId: data["userId"],
          medcinAmge: data["imagUrl"],
          medcinName: data["medicinName"],
          numberOfViews: data["ordernumber"],
          medcinDescrption: data["medicinDecription"],
          salare: data["unitprice"],
          typeOfMedcin: data["medicinType"]);
    }).toList();

    // debugPrint(
    //     "========//====${pallativeItemList[0].medcinName}======//========");
  }

  getAntibioticMedicin() async {
    QuerySnapshot<Map<String, dynamic>> antibioticItemQuiry =
        await getFirebasAntibioticMedicin();
    antibioticItemList = antibioticItemQuiry.docs.map((e) {
      Map<String, dynamic> data = e.data();
      return MedcinItemModel(
          supplerName: data["suppliername"],
          medicinQuantity: data["medicinQuantity"],
          ownerId: data["userId"],
          medcinAmge: data["imagUrl"],
          medcinName: data["medicinName"],
          numberOfViews: data["ordernumber"],
          medcinDescrption: data["medicinDecription"],
          salare: data["unitprice"],
          typeOfMedcin: data["medicinType"]);
    }).toList();
  }

  getChronicDiseasesMedicin() async {
    QuerySnapshot<Map<String, dynamic>> chronicdiseasesItemQuiry =
        await getFirebasChronicDiseasesMedicin();
    chronicdiseasesItemList = chronicdiseasesItemQuiry.docs.map((e) {
      Map<String, dynamic> data = e.data();
      return MedcinItemModel(
          supplerName: data["suppliername"],
          medicinQuantity: data["medicinQuantity"],
          ownerId: data["userId"],
          medcinAmge: data["imagUrl"],
          medcinName: data["medicinName"],
          numberOfViews: data["ordernumber"],
          medcinDescrption: data["medicinDecription"],
          salare: data["unitprice"],
          typeOfMedcin: data["medicinType"]);
    }).toList();
  }

  getSkinCareMedicin() async {
    QuerySnapshot<Map<String, dynamic>> skincareItemQuiry =
        await getFirebasSkinCareMedicin();
    skincareItemList = skincareItemQuiry.docs.map((e) {
      Map<String, dynamic> data = e.data();
      return MedcinItemModel(
          supplerName: data["suppliername"],
          medicinQuantity: data["medicinQuantity"],
          ownerId: data["userId"],
          medcinAmge: data["imagUrl"],
          medcinName: data["medicinName"],
          numberOfViews: data["ordernumber"],
          medcinDescrption: data["medicinDecription"],
          salare: data["unitprice"],
          typeOfMedcin: data["medicinType"]);
    }).toList();
  }

  List<MedcinItemModel> medcinItemList = [];

  // ====
  List<MedcinItemModel> pallativeItemList = [];
  // ====
  List<MedcinItemModel> skincareItemList = [];
  // ====
  List<MedcinItemModel> antibioticItemList = [];
  // ====
  List<MedcinItemModel> chronicdiseasesItemList = [];
  // ============================================================================================
  void onChaingCatgre(int catugreNumber) async {
    if (catugreNumber == 0) {
      debugPrint("pallativeItemList === $pallativeItemList");
      await getPalliativeMedicin();
      Get.to(() => MedcinAsOrderView(
            // onOpenPage: getPalliativeMedicin,
            listMedcinView: pallativeItemList,
            title: "pallative",
          ));
    } else if (catugreNumber == 1) {
      await getAntibioticMedicin();
      Get.to(() => MedcinAsOrderView(
            onOpenPage: getAntibioticMedicin,
            listMedcinView: antibioticItemList,
            title: "antibiotic",
          ));
    } else if (catugreNumber == 2) {
      await getChronicDiseasesMedicin();
      Get.to(() => MedcinAsOrderView(
            onOpenPage: getChronicDiseasesMedicin,
            listMedcinView: chronicdiseasesItemList,
            title: "chronic diseases",
          ));
    } else if (catugreNumber == 3) {
      await getSkinCareMedicin();
      Get.to(() => MedcinAsOrderView(
            onOpenPage: getSkinCareMedicin,
            listMedcinView: skincareItemList,
            title: "skin care",
          ));
    }
  }

  Future coadinaryUploadImag() async {
    try {
      var imageName = basename(pikedImage!.path);
      imageName = Random().nextInt(10000).toString() + imageName;

      final url =
          Uri.parse("https://api.cloudinary.com/v1_1/dzj5ql6sl/image/upload");
      final request = http.MultipartRequest('Post', url)
        ..fields['upload_preset'] = "pharamaupload"
        ..files.add(await http.MultipartFile.fromPath('file', pikedImage!.path,
            filename: imageName));
      final respons = await request.send();
      if (respons.statusCode == 200) {
        final responseData = await respons.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

        debugPrint('======[[[========${jsonMap['url']}=======]]]=======');
        cloadinryImageUrl = jsonMap['url'];
        return cloadinryImageUrl;
      }
      return null;
    } catch (e) {
      Get.defaultDialog(title: "Error", middleText: "$e");
    }
  }
}
