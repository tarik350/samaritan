import 'package:hive/hive.dart';
import 'package:project_samaritan/models/transaction.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('medicines');
}
