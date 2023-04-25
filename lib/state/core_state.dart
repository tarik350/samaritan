import 'package:hive/hive.dart';

import '../models/transaction.dart';

class AppState {
  late final medicineBox;

  List<Transaction> medicines = [];

  makebox() async {
    medicineBox = await Hive.openBox<Map>('medicnes');
  }

  AppState() {
    makebox();
  }

  AppState copy() => AppState();
}
