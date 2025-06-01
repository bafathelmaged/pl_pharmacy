import 'package:flutter/material.dart';

enum Season { spring, summer, autumn, winter }

enum MedcinType { pallative, antibiotic, chronicDiseases, skinCare }

class MedcinItemModel {
  final String? medcinAmge;
  final String? ownerId;
  final String? medcinName;
  final String? medcinDescrption;
  final String? salare;
  final String? typeOfMedcin;
  final String? medicinQuantity;
  final String? supplerName;
  final int? numberOfViews;

  const MedcinItemModel(
      {@required this.medicinQuantity,
      @required this.supplerName,
      @required this.ownerId,
      @required this.typeOfMedcin,
      @required this.salare,
      @required this.numberOfViews,
      @required this.medcinAmge,
      @required this.medcinName,
      @required this.medcinDescrption});
}
