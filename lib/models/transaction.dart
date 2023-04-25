import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String adverseReaction;

  @HiveField(2)
  late String overdossage;

  @HiveField(3)
  late String description;

  @HiveField(5)
  late String medId;
}
