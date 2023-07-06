import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app/feature/home_view/model/search_model.dart';
import 'package:trading_app/feature/home_view/model/stock_data.dart';
import 'package:trading_app/feature/home_view/model/wish_list.dart';
import 'package:uuid/uuid.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getAllWaterDbDetails();
    //fetchStockData();
  }

  Uuid uuid = const Uuid();

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
              id: DateTime.now().millisecondsSinceEpoch,
              dateTime: DateTime.parse(key),
              open: double.parse(value['1. open']),
              high: double.parse(value['2. high']),
              low: double.parse(value['3. low']),
              close: double.parse(value['4. close']),
              volume: int.parse(value['5. volume']),
            ));
            log(stockData[0].id.toString());
          });

          yield stockData;
        } else {
          throw Exception('Failed to fetch data');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching data: $e');
        }
        yield [];
        await Future.delayed(const Duration(minutes: 1));
      }
      await Future.delayed(const Duration(minutes: 5));
    }
  }

  // final TextEditingController _searchText = TextEditingController();
  // get searchText => _searchText;

  // List<StockData> foundUsers = [];
  // String enteredKeyword = "";
  // void runFilter(String enteredKeyword) {
  //   this.enteredKeyword = enteredKeyword;
  //   log(enteredKeyword.toString());
  //   List<StockData> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = searchText;
  //     notifyListeners();
  //   } else {
  //     results = searchText
  //         .where((user) =>
  //             user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }

  //   foundUsers = results;
  //   notifyListeners();
  // }

  // final searchController = TextEditingController();
  bool valueFav = false;

  void wishListAdded(bool val) {
    valueFav = val;
    log(valueFav.toString());
    notifyListeners();
  }

  String dbName = 'whishList';
  List<WishlistModel> waterDbList = [];
  Future<void> addWaterDetails(WishlistModel value) async {
    waterDbList.clear();
    final box = await Hive.openBox<WishlistModel>(dbName);
    await box.put(value.hashCode, value);
    waterDbList.toSet();
    notifyListeners();
  }

  Future<void> getAllWaterDbDetails() async {
    waterDbList.clear();
    final obj = await Hive.openBox<WishlistModel>(dbName);
    waterDbList.clear();
    waterDbList.addAll(obj.values.toSet().toList().reversed);
    log(waterDbList.toString());
    // log(waterDbList[0].id.toString());
    notifyListeners();
  }

  Future<void> deleteWaterDetails(int index) async {
    final box = await Hive.openBox<WishlistModel>(dbName);
    box.deleteAt(index);
    wishListAdded(waterDbList[index].whistListAdded = false);

    getAllWaterDbDetails();
  }

  final TextEditingController searchController = TextEditingController();
  List<StockSymbol> searchResults = [];
  bool isLoading = false;

  Future<void> searchStocks(String query) async {
    isLoading = true;
    notifyListeners();

    final apiUrl =
        'https://dev.portal.tradebrains.in/api/search?keyword=$query';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      log(data.toString());

      final List<StockSymbol> symbols = [];

      for (var item in data) {
        symbols.add(StockSymbol.fromJson(item));
      }

      searchResults = symbols;
      notifyListeners();
    } else {
      // Handle error response
      print('Error: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }
}
