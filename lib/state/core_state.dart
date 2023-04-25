import 'package:hive/hive.dart';

import '../models/transaction.dart';

class AppState {
  final int medicineCount;

  late final medicineBox;

  List<Transaction> medicines = [];

  makebox() async {
    medicineBox = await Hive.openBox<Map>('medicnes');
  }

  AppState({
    this.medicineCount = 0,
  }) {
    makebox();
  }

  AppState copy({
    int? medicineCount,
  }) =>
      AppState(
        medicineCount: medicineCount ?? this.medicineCount,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          medicineCount == other.medicineCount;

  @override
  int get hashCode => medicineCount.hashCode;
}
