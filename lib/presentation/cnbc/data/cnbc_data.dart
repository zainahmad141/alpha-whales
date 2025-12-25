import '../../../generated/assets.dart';
import 'cnbc_model.dart';

final List<Recommendation> recommendations = [

  Recommendation(
    ticker: 'AAPL',
    companyName: 'Apple Inc.',
    logoPath: Assets.svgAssetsTeslaLogo,
    action: 'Sell',
    analystName: 'Dan Nathan',
    quote: 'iPhone sales beat expectations.',
    currentPrice: '\$354',
    targetPrice: '\$297',
    trendLabel: 'Downside',
    trendValue: '-8.7%',
    timeAgo: '10 minutes ago',
    isStockUp: true,
  ),
  Recommendation(
    ticker: 'META',
    companyName: 'Meta Platforms Inc.',
    logoPath: Assets.svgAssetsAppleLogo,
    action: 'Buy',
    analystName: 'Dan Nathan',
    quote: 'Digital ad spend is rebounding fast.',
    currentPrice: '\$354',
    targetPrice: '\$447',
    trendLabel: 'Upside',
    trendValue: '+8.7%',
    timeAgo: 'Yesterday',
    isStockUp: true,
  ),
  Recommendation(
    ticker: 'NVDA',
    companyName: 'Nvidia Corp.',
    logoPath: Assets.svgAssetsMicrosoftLogo,
    action: 'Sell',
    analystName: 'Tim Seymour',
    quote: 'NVIDIA is riding the AI wave with explosive demand.',
    currentPrice: '\$354',
    targetPrice: "",
    trendLabel: 'Bearish',
    trendValue: "",
    timeAgo: '10 minutes ago',
    isStockUp: false,

  ),
];

final List<String> cnbcTabs = [
  'Final Trades',
  'Fast Money',
  'Mad Money',
];