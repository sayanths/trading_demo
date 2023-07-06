// class StockSymbol {
//   final String symbol;
//   final String name;
//   final String type;
//   final String region;
//   final String marketOpen;
//   final String marketClose;
//   final String timezone;
//   final String currency;
//   final double matchScore;

//   StockSymbol({
//     required this.symbol,
//     required this.name,
//     required this.type,
//     required this.region,
//     required this.marketOpen,
//     required this.marketClose,
//     required this.timezone,
//     required this.currency,
//     required this.matchScore,
//   });

//   factory StockSymbol.fromJson(Map<String, dynamic> json) {
//     return StockSymbol(
//       symbol: json['1. symbol'],
//       name: json['2. name'],
//       type: json['3. type'],
//       region: json['4. region'],
//       marketOpen: json['5. marketOpen'],
//       marketClose: json['6. marketClose'],
//       timezone: json['7. timezone'],
//       currency: json['8. currency'],
//       matchScore: double.parse(json['9. matchScore']),
//     );
//   }
// }

class StockSymbol {
  String? name;
  String? symbol;
  String? type;

  StockSymbol({this.name, this.symbol, this.type});

  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      name: json['name'],
      symbol: json['symbol'],
      type: json['type'],
    );
  }
}
