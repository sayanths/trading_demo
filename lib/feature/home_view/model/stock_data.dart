class StockData {
  final int id;
  final DateTime? dateTime;
  final double? open;
  final double? high;
  final double? low;
  final double? close;
  final dynamic volume;

  StockData({
    required this.id,
    this.dateTime,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });
}
