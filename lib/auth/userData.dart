import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class UserDatabaseService {
  UserDatabaseService({this.uid});
  final String? uid;

  final CollectionReference brewCollection = _firestore.collection('brews');

  Future updateUserData(
      String? name,
      String? phone,
      String? upi,
      String? email,
      String? degree,
      String? branch,
      String? year,
      int? carpool,
      int? role,
      String? department,
      String? vehicleNo) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'mobile': phone,
      'email': email,
      'upi': upi,
      'degree': degree,
      'branch': branch,
      'year': year,
      'carpool': carpool,
      'role': role,
      'department': department,
      'vehicle_no': vehicleNo,
    });
  }
}
