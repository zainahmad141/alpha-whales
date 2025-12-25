class Recommendation {
  final String ticker;
  final String companyName;
  final String logoPath;
  final String action;
  final bool isStockUp;
  final String analystName;
  final String quote;
  final String currentPrice;
  final String targetPrice;
  final String trendLabel;
  final String trendValue;
  final String timeAgo;

  Recommendation({
    required this.ticker,
    required this.companyName,
    required this.logoPath,
    required this.action,
    required this.isStockUp,
    required this.analystName,
    required this.quote,
    required this.currentPrice,
    required this.targetPrice,
    required this.trendLabel,
    required this.trendValue,
    required this.timeAgo,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      ticker: json['ticker'] ?? '',
      companyName: json['companyName'] ?? '',
      logoPath: json['logoPath'] ?? '',
      action: json['action'] ?? '',
      isStockUp: json['isStockUp'] ?? true,
      analystName: json['analystName'] ?? '',
      quote: json['quote'] ?? '',
      currentPrice: json['currentPrice'] ?? '',
      targetPrice: json['targetPrice'] ?? '',
      trendLabel: json['trendLabel'] ?? '',
      trendValue: json['trendValue'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'companyName': companyName,
      'logoPath': logoPath,
      'action': action,
      'isStockUp': isStockUp,
      'analystName': analystName,
      'quote': quote,
      'currentPrice': currentPrice,
      'targetPrice': targetPrice,
      'trendLabel': trendLabel,
      'trendValue': trendValue,
      'timeAgo': timeAgo,
    };
  }
}
