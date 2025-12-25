import 'dart:ui';
import '../../../generated/assets.dart';

final List<String> tabs = ["Recent Buys", "Recent Sells"];

final List<CustomStockCardModel> allHoldings = [
  CustomStockCardModel(
    ticker: "MSFT",
    companyName: "Microsoft Corporation",
    logoPath: Assets.svgAssetsMicrosoftLogo,
    price: "\$2,150",
    shares: "2,000 Shares",
    timeAgo: "20 minutes ago",
    buttonText: "Buy",
    showBuyButton: true,
  ),
  CustomStockCardModel(
    ticker: "MSFT",
    companyName: "Microsoft Corporation",
    logoPath: Assets.svgAssetsMicrosoftLogo,
    price: "\$2,150",
    shares: "2,000 Shares",
    timeAgo: "20 minutes ago",
    buttonText: "Buy",
    showBuyButton: true,
  ),
  CustomStockCardModel(
    ticker: "MSFT",
    companyName: "Microsoft Corporation",
    logoPath: Assets.svgAssetsMicrosoftLogo,
    price: "\$2,150",
    shares: "2,000 Shares",
    timeAgo: "20 minutes ago",
    buttonText: "Buy",
    showBuyButton: true,
  ),
  CustomStockCardModel(
    ticker: "MSFT",
    companyName: "Microsoft Corporation",
    logoPath: Assets.svgAssetsMicrosoftLogo,
    price: "\$2,150",
    shares: "2,000 Shares",
    timeAgo: "20 hours ago",
    buttonText: "Sell",
    showBuyButton: true,
  ),
];

final List<CustomStockCardModel> stockList = [
  CustomStockCardModel(
    ticker: 'HSBC',
    companyName: 'HSBS Holding plc',
    logoPath: Assets.svgAssetsMicrosoftLogo,
    percentage: '11%',
  ),
  CustomStockCardModel(
    ticker: 'AAPL',
    companyName: 'Apple\nInc.',
    logoPath: Assets.svgAssetsAppleLogo,
    price: '\$1,308',
    shares: '1,000 Shares',
    timeAgo: '10 minutes ago',
    showBuyButton: true,
    onBuyPressed: () {},
    buttonText: "Sell",
  ),
  CustomStockCardModel(
    ticker: 'TSLA',
    companyName: 'Tesla\nInc.',
    logoPath: Assets.svgAssetsTeslaLogo,
    price: '\$850',
    shares: '500 Shares',
    timeAgo: '5 minutes ago',
    onBuyPressed: () {},
    showBuyButton: true,
    buttonText: "Buy,",
  ),
];

class CustomStockCardModel {
  final String? ticker;
  final String? companyName;
  final String? logoPath;

  final String? price;
  final String? shares;
  final String? timeAgo;
  final bool? showBuyButton;
  final VoidCallback? onBuyPressed;
  final String? percentage;
  final String? buttonText;

  const CustomStockCardModel({
    this.ticker,
    this.companyName,
    this.logoPath,
    this.price,
    this.shares,
    this.timeAgo,
    this.showBuyButton,
    this.onBuyPressed,
    this.percentage,
    this.buttonText = "Buy",
  });
}
