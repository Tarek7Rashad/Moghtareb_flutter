import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:moghtareb/model/Unit_Model.dart';
import 'package:moghtareb/shared/constant.dart';

class Store {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUnit(UnitModel unitModel) {
    firebaseFirestore.collection(kUnitCollection).add({
      kUnitImages: unitModel.unitImages,
      kUnitLocation: unitModel.unitLocation,
      kUnitPrice: unitModel.unitPrice,
      kUnitDescription: unitModel.unitDescription,
      kUnitRooms: unitModel.unitRooms,
      kUnitBeds: unitModel.unitBeds,
    });
  }

  Stream<QuerySnapshot> updateUnit() {
    return firebaseFirestore.collection(kUnitCollection).snapshots();
  }

  deleteDocument(documentId) {
    firebaseFirestore.collection(kUnitCollection).doc(documentId).delete();
  }

  editUnit(Map<String, dynamic> data, String documentId) async {
    try {
      await firebaseFirestore
          .collection(kUnitCollection)
          .doc(documentId)
          .update(data);
    } catch (e) {
      if (e is FirebaseException) {
        log('Document not found');
      }
    }
  }
}
