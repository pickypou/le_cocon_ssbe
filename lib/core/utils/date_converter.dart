import 'package:cloud_firestore/cloud_firestore.dart';

class DateConverter {
  static DateTime converToDateTime(dynamic value) {
    if(value is DateTime) {
      return value;
    }else if (value is Timestamp) {
      return value.toDate();
    }
    return DateTime.now();
  }
}