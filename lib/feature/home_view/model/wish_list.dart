import 'package:hive_flutter/adapters.dart';
part 'wish_list.g.dart';

@HiveType(typeId: 1)
class WishlistModel {
  @HiveField(0)
  late int id;

  @HiveField(1)
  final DateTime? timestamp;

  @HiveField(2)
  final double? open;

  @HiveField(3)
  final double? high;

  @HiveField(4)
  final double? low;

  @HiveField(5)
  final double? close;

  @HiveField(6)
  final num? volume;

  WishlistModel(
      {required this.id,
      this.timestamp,
      this.open,
      this.close,
      this.high,
      this.low,
      this.volume});
}
