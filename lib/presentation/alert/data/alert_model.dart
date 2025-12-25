class StockAlert {
  final String ticker;
  final String alertType;
  final String headline;
  final String description;
  final String timeAgo;
  final bool isNew;
  final bool isStockUp;

  StockAlert({
    required this.ticker,
    required this.alertType,
    required this.headline,
    required this.description,
    required this.timeAgo,
    this.isNew = false,
    this.isStockUp = true,
  });

  factory StockAlert.fromJson(Map<String, dynamic> json) {
    return StockAlert(
      ticker: json['ticker'] ?? '',
      alertType: json['alertType'] ?? '',
      headline: json['headline'] ?? '',
      description: json['description'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      isNew: json['isNew'] ?? false,
      isStockUp: json['isStockUp'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'alertType': alertType,
      'headline': headline,
      'description': description,
      'timeAgo': timeAgo,
      'isNew': isNew,
      'isStockUp': isStockUp,
    };
  }
}
