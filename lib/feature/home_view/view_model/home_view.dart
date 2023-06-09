import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
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
}
