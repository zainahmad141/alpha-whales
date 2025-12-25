import '../../../generated/assets.dart';

final List<String> tabs = [
  "All Whales",
  "Billionaires",
  "Activists",
  "Tech Investors",
];

final List<Map<String, dynamic>> avatarList = [
  {
    "id": "1",
    "name": "Warren Buffet",
    "imageUrl": Assets.pngAssetsWarrenBuffet,
    "role": "Chairman & CEO",
  },
  {
    "id": "2",
    "name": "Jeff Bezos",
    "imageUrl": Assets.pngAssetsWarrenBuffet,
    "role": "Director Board",
  },
  {
    "id": "3",
    "name": "Elon Musk",
    "imageUrl": Assets.pngAssetsWarrenBuffet,
    "role": "CEO SpaceX",
  },
  {
    "id": "4",
    "name": "Cathie Wood",
    "imageUrl": Assets.pngAssetsWarrenBuffet,
    "role": "CFO",
  },
  {
    "id": "5",
    "name": "Bill Gates",
    "imageUrl": Assets.pngAssetsWarrenBuffet,
    "role": "Co-founder",
  },
];

final List<Map<String, dynamic>> whales = [
  {
    "name": "Warren Buffet",
    "role": "Chairman & CEO",
    "imageUrl":
    Assets.pngAssetsWarrenBuffet,
    "tag": "Billionaires",
    "convictionScore": 68,
    "holdings": [
      {"logo1": Assets.svgAssetsTeslaLogo, "ticker1": "AAPL", "percent1": 24, "logo2": Assets.svgAssetsMicrosoftLogo, "ticker2": "SNG", "percent2": 86, },
    ]
  },
  {
    "name": "Jeff Bezos",
    "role": "Director Board",
    "imageUrl":
    Assets.pngAssetsWarrenBuffet,
    "tag": "Activists",
    "convictionScore": 97,
    "holdings": [
      {"logo1": Assets.svgAssetsTeslaLogo, "ticker1": "AAPL", "percent1": 24, "logo2": Assets.svgAssetsMicrosoftLogo, "ticker2": "SNG", "percent2": 86, },
    ]
  },
  {
    "name": "Elon Musk",
    "role": "CEO SpaceX",
    "imageUrl":
    Assets.pngAssetsWarrenBuffet,
    "tag": "Tech Investors",
    "convictionScore": 32,
    "holdings": [
      {"logo1": Assets.svgAssetsTeslaLogo, "ticker1": "AAPL", "percent1": 24, "logo2": Assets.svgAssetsMicrosoftLogo, "ticker2": "SNG", "percent2": 86, },
    ]
  },
];

