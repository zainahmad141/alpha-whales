import '../../../generated/assets.dart';

class InsiderStock {
  final String companyTicker;
  final String companyName;
  final String companyLogo;
  final String action;
  final String amount;
  final String insiderName;
  final String insiderRole;
  final String shares;
  final String timeAgo;

  InsiderStock({
    required this.companyTicker,
    required this.companyName,
    required this.companyLogo,
    required this.action,
    required this.amount,
    required this.insiderName,
    required this.insiderRole,
    required this.shares,
    required this.timeAgo,
  });

  factory InsiderStock.fromMap(Map<String, dynamic> map) {
    return InsiderStock(
      companyTicker: map['companyTicker'],
      companyName: map['companyName'],
      companyLogo: map['companyLogo'],
      action: map['action'],
      amount: map['amount'],
      insiderName: map['insiderName'],
      insiderRole: map['insiderRole'],
      shares: map['shares'],
      timeAgo: map['timeAgo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyTicker': companyTicker,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'action': action,
      'amount': amount,
      'insiderName': insiderName,
      'insiderRole': insiderRole,
      'shares': shares,
      'timeAgo': timeAgo,
    };
  }
}

final List<InsiderStock> insiderStockData = [
  InsiderStock(
    companyTicker: "AAPL",
    companyName: "Apple Inc.",
    companyLogo: Assets.svgAssetsAppleLogo,
    action: "Sell",
    amount: "\$1,308",
    insiderName: "Timothy Cook",
    insiderRole: "CEO",
    shares: "1,000 Shares",
    timeAgo: "2 days ago",
  ),
  InsiderStock(
    companyTicker: "TSLA",
    companyName: "Tesla Inc.",
    companyLogo: Assets.svgAssetsTeslaLogo,
    action: "Buy",
    amount: "\$2,500",
    insiderName: "Elon Musk",
    insiderRole: "CEO",
    shares: "5,000 Shares",
    timeAgo: "1 day ago",
  ),
  InsiderStock(
    companyTicker: "MSFT",
    companyName: "Microsoft Corp.",
    companyLogo: Assets.svgAssetsMicrosoftLogo,
    action: "Buy",
    amount: "\$3,200",
    insiderName: "Satya Nadella",
    insiderRole: "CEO",
    shares: "2,500 Shares",
    timeAgo: "3 days ago",
  ),
];
