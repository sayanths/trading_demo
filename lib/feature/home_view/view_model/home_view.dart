import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app/feature/home_view/model/api.dart';
import 'package:trading_app/feature/home_view/model/wish_list.dart';

class HomeProvider extends ChangeNotifier {
  // HomeProvider() {
  //   getAllWaterDbDetails();
  // }

  // List<StockData> stockData = [];

  // Future<List<StockData>> fetchData() async {
  //   final response = await http.get(Uri.parse(
  //       'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=YOUR_API_KEY'));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> data = json.decode(response.body);
  //     Map<String, dynamic> timeSeries = data['Time Series (5min)'];

  //     timeSeries.forEach((key, value) {
  //       stockData.add(StockData(
  //         dateTime: DateTime.parse(key),
  //         open: double.parse(value['1. open']),
  //         high: double.parse(value['2. high']),
  //         low: double.parse(value['3. low']),
  //         close: double.parse(value['4. close']),
  //         volume: int.parse(value['5. volume']),
  //       ));
  //     });

  //     return stockData;
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  // final Stream<List<dynamic>> dataStream = fetchData();

  // static Stream<List<dynamic>> fetchData() async* {
  //   const url =
  //       'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=3WCCUFJAOII9K4MU';

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final parsedData = jsonDecode(response.body) as Map<String, dynamic>;
  //       final timeSeriesData =
  //           parsedData['Time Series (5min)'] as Map<String, dynamic>;
  //       final dataList = timeSeriesData.values.toList();

  //       yield dataList;
  //     } else {
  //       log('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  // }
  Stream<List<StockData>> fetchStockData() async* {
  while (true) {
    try {
      final response = await http.get(Uri.parse(
          'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=3WCCUFJAOII9K4MU'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> timeSeries = data['Time Series (5min)'];

        List<StockData> stockData = [];

        timeSeries.forEach((key, value) {
          stockData.add(StockData(
            dateTime: DateTime.parse(key),
            open: double.parse(value['1. open']),
            high: double.parse(value['2. high']),
            low: double.parse(value['3. low']),
            close: double.parse(value['4. close']),
            volume: int.parse(value['5. volume']),
          ));
        });

        yield stockData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      yield []; // Yield an empty list in case of an error
      await Future.delayed(Duration(minutes: 1)); // Delay for 1 minute before retrying
    }
    await Future.delayed(Duration(minutes: 5)); // Delay for 5 minutes
  }
}


  // final StreamController<List<StockData>> _stockDataController =
  //     StreamController<List<StockData>>();
  // Stream<List<StockData>> get stockDataStream => _stockDataController.stream;

  // void fetchStockData() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=3WCCUFJAOII9K4MU'));

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = json.decode(response.body);
  //       Map<String, dynamic> timeSeries = data['Time Series (5min)'];

  //       List<StockData> stockData = [];

  //       timeSeries.forEach((key, value) {
  //         stockData.add(StockData(
  //           dateTime: DateTime.parse(key),
  //           open: double.parse(value['1. open']),
  //           high: double.parse(value['2. high']),
  //           low: double.parse(value['3. low']),
  //           close: double.parse(value['4. close']),
  //           volume: int.parse(value['5. volume']),
  //         ));
  //       });

  //       return _stockDataController.add(stockData);
  //     } else {
  //       throw Exception('Failed to fetch data');
  //     }
  //   } catch (e) {
  //     _stockDataController.addError(e);
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _stockDataController.close();
  // }

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
}
