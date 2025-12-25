import 'alert_model.dart';

final List<StockAlert> alerts = [

  StockAlert(
    ticker: "MSFT",
    alertType: "Whale Alert",
    headline: "Microsoft CEO bought shares",
    description: "Satya Nadella purchased \$9.4M worth of MSFT shares.",
    timeAgo: "1 hour ago",
    isNew: true,
    isStockUp: true,
  ),
  StockAlert(
    ticker: "MSFT",
    alertType: "Insider Alert",
    headline: "Microsoft CEO bought shares",
    description: "Satya Nadella purchased \$9.4M worth of MSFT shares.",
    timeAgo: "10 minutes ago",
    isNew: true,
    isStockUp: true,
  ),
  StockAlert(
    ticker: "NVDA",
    alertType: "CNBC Alert",
    headline: "Final Trades: Buy NVDA",
    description: "Analyst recommends NVIDIA as AI decreases the momentum.",
    timeAgo: "1 day ago",
    isNew: false,
    isStockUp: false,
  ),
  StockAlert(
    ticker: "NVDA",
    alertType: "CNBC Alert",
    headline: "AI sentiment cooling down",
    description: "Analyst sees slowdown in AI hype, lowering expectations.",
    timeAgo: "2 days ago",
    isNew: false,
    isStockUp: false,
  ),
];

final List<String> tabs = [
  "All",
  "Whale Alerts",
  "Insider Alerts",
  "CNBC Alerts",
];
