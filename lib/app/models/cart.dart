import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  late String number;

  @HiveField(1)
  late int amount;

  @HiveField(2)
  late String houb;
}
