import 'package:hive_flutter/adapters.dart';
part 'wish_list.g.dart';

@HiveType(typeId: 1)
class WishlistModel {
  @HiveField(0)
  final int id;

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
  final dynamic volume;

  @HiveField(7)
  bool? whistListAdded;

  WishlistModel({
    required this.id,
    this.timestamp,
    this.open,
    this.close,
    this.high,
    this.low,
    this.volume,
    this.whistListAdded,
  });
}
