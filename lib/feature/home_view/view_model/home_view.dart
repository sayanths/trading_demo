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

class HomeProvider extends ChangeNotifier {
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
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$query&apikey=3WCCUFJAOII9K4MU';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['bestMatches'] != null) {
        final List<StockSymbol> symbols = [];
        for (var item in data['bestMatches']) {
          symbols.add(StockSymbol.fromJson(item));
        }

        searchResults = symbols;
        notifyListeners();
      }
    } else {
      // Handle error response
      print('Error: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }
}
