import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app/feature/home_view/model/wish_list.dart';

class HomeProvider extends ChangeNotifier {
  // HomeProvider() {
  //   getAllWaterDbDetails();
  // }

  final Stream<List<dynamic>> dataStream = fetchData();

  static Stream<List<dynamic>> fetchData() async* {
    const url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=3WCCUFJAOII9K4MU';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsedData = jsonDecode(response.body) as Map<String, dynamic>;
        final timeSeriesData =
            parsedData['Time Series (5min)'] as Map<String, dynamic>;
        final dataList = timeSeriesData.values.toList();

        yield dataList;
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  String dbName = 'whishList';
  List<WishlistModel> waterDbList = [];
  Future<void> addWaterDetails(WishlistModel value) async {
    final box = await Hive.openBox<WishlistModel>(dbName);
    await box.put(value.hashCode, value);
  }

  Future<void> getAllWaterDbDetails() async {
    waterDbList.clear();
    final obj = await Hive.openBox<WishlistModel>(dbName);
    waterDbList.addAll(obj.values.toList().reversed);
    log(waterDbList.toString());
    notifyListeners();
  }

  Future<void> deleteWaterDetails(int index) async {
    final box = await Hive.openBox<WishlistModel>(dbName);
    box.deleteAt(index);
    getAllWaterDbDetails();
  }
  // Future<void> deleteWaterDetails(String value) async {
  //   final obj = await Hive.openBox<WterEntryModel>(dbName);
  //   obj.delete(value);
  //   getAllWaterDbDetails();
  // }
}
