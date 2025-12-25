import '/app_exports.dart';

class InsiderStockCard extends StatelessWidget {

  final InsiderStock stockModel;

  const InsiderStockCard({
    super.key,
    required this.stockModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(16)),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    stockModel.companyLogo,
                    width: getProportionateScreenWidth(28),
                    height: getProportionateScreenWidth(28),
                  ),
                  SizedBox(width: getProportionateScreenWidth(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockModel.companyTicker,
                        style: AppStyles.w400f12poppins.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      Text(
                        stockModel.companyName,
                        style: AppStyles.w400f12poppins.copyWith(
                          color: kHintTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(12),
                      vertical: getProportionateScreenHeight(4),
                    ),
                    decoration: BoxDecoration(
                      color: stockModel.action == "Buy"
                          ? kGreenStatusColor
                          : kRedStatusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      stockModel.action,
                      style: AppStyles.w600f10poppins.copyWith(
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(6)),
                  Text(
                    stockModel.amount,
                    style: AppStyles.w400f12poppins.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          Row(
            children: [
              Text(
                stockModel.insiderName,
                style: AppStyles.w500f14poppins.copyWith(color: kWhiteColor),
              ),
              SizedBox(width: getProportionateScreenWidth(16)),
              Text(
                "• ${stockModel.insiderRole}",
                style: AppStyles.w400f12poppins.copyWith(color: kWhiteColor),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stockModel.shares,
                style: AppStyles.w400f12poppins.copyWith(
                  color: kMutedGrayColor,
                ),
              ),
              Text(
                stockModel.timeAgo,
                style: AppStyles.w400f12poppins.copyWith(
                  color: kHintTextColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
