import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/feature/home_view/view_model/home_view.dart';

class StockSearchPage extends StatefulWidget {
  const StockSearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StockSearchPageState createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 5, 94, 0),
        title: const Text('Stock Search'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: value.searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                      onPressed: () {
                        String query = value.searchController.text.trim();
                        if (query.isNotEmpty) {
                          value.searchStocks(query);
                        }
                      },
                      icon: const Icon(IconlyBold.search)),
                ),
              ),
            ),
            value.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.searchResults.length,
                      itemBuilder: (context, index) {
                        var symbol = value.searchResults[index];
                        return ListTile(
                          title: Text(symbol.name),
                          subtitle: Text(symbol.symbol),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class StockSymbol {
  final String symbol;
  final String name;

  StockSymbol({required this.symbol, required this.name});

  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      symbol: json['1. symbol'] ?? '',
      name: json['2. name'] ?? '',
    );
  }
}
