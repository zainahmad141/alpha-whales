import 'package:alpha_whales/app_exports.dart';

import '../data/alert_model.dart';

class StockAlertCard extends StatelessWidget {
  final StockAlert alert;

  const StockAlertCard({
    super.key, required this.alert,

  });

  Color _getAlertColor() {
    switch (alert.alertType.toLowerCase()) {
      case "whale alert":
        return kSecondaryColor;
      case "insider alert":
        return Color(0XFFFFD66B);
      case "cnbc alert":
        return Color(0XFFCB30E0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenHeight(12)),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kPrimaryColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenHeight(12)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: alert.isStockUp
                      ? const Color(0xff00C896).withValues(alpha: 0.10)
                      : const Color(0xffFF5B5B).withValues(alpha: 0.10),
                ),
                child: SvgPicture.asset(
                  alert.isStockUp
                      ? Assets.svgAssetsStockUp
                      : Assets.svgAssetsStockDown,
                  colorFilter: ColorFilter.mode(
                    alert.isStockUp ? Color(0xff00C896) : Color(0xffFF5B5B),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(8)),
              Column(
                children: [
                  Text(
                    alert.ticker,
                    style: AppStyles.w600f16poppins.copyWith(
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: getProportionateScreenWidth(8)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(12),
                  vertical: getProportionateScreenHeight(6),
                ),
                decoration: BoxDecoration(
                  color: _getAlertColor().withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  alert.alertType,
                  style: AppStyles.w400f10poppins.copyWith(
                    color: _getAlertColor(),
                  ),
                ),
              ),
              Spacer(),
              if (alert.isNew)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                    vertical: getProportionateScreenHeight(3),
                  ),
                  decoration: BoxDecoration(
                    color: kRedStatusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "New",
                    style: AppStyles.w500f10poppins.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.headline,
                  style: AppStyles.w500f10poppins.copyWith(
                    fontSize: 12,
                    color: kWhiteColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(4)),
                Text(
                  alert.description,
                  style: AppStyles.w400f12poppins.copyWith(
                    fontWeight: FontWeight.w300,
                    color: kMutedGrayColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(12)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                alert.timeAgo,
                style: AppStyles.w400f10poppins.copyWith(color: kHintTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
