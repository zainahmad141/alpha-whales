import '/app_exports.dart';

class InvestorStockCard extends StatelessWidget {
  final String investorName;
  final String timeAgo;
  final String investorImage;
  final String companyName;
  final String companyTicker;
  final String companyLogo;
  final String action;
  final String amount;
  final double convictionScore;
  final String news;

  const InvestorStockCard({
    super.key,
    required this.investorName,
    required this.timeAgo,
    required this.investorImage,
    required this.companyName,
    required this.companyTicker,
    required this.companyLogo,
    required this.action,
    required this.amount,
    required this.convictionScore,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232730),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  investorImage,
                  width: double.infinity,
                  height: getProportionateScreenHeight(219),
                  fit: BoxFit.cover,
                ),
                Container(
                  height: getProportionateScreenHeight(60),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0x14131A26),
                        kBgColor,
                      ],
                      stops: [0.5548, 1.0],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8),vertical: getProportionateScreenHeight(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(investorName,
                          style: AppStyles.w600f16poppins
                              .copyWith(color: Colors.white)),
                      Text(timeAgo,
                          style: AppStyles.w400f12poppins
                              .copyWith(color: kHintTextColor,fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
            child: Row(
              children: [
                SvgPicture.asset(
                  companyLogo,
                  height: getProportionateScreenHeight(24),
                  width: getProportionateScreenHeight(30),
                ),
                SizedBox(width: getProportionateScreenWidth(13)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(companyTicker,
                          style: AppStyles.w500f14poppins
                              .copyWith(color: Colors.white)),
                      Text(companyName,
                          style: AppStyles.w400f12poppins
                              .copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(21)),
                Text(amount,
                    style: AppStyles.w500f14poppins
                        .copyWith(color: kWhiteColor)),
                SizedBox(width: getProportionateScreenWidth(8)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(11),
                      vertical: getProportionateScreenHeight(4)),
                  decoration: BoxDecoration(
                    color: action.toLowerCase() == "buy"
                        ? kGreenStatusColor
                        : kRedStatusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(action,
                      style: AppStyles.w500f14poppins
                          .copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(19)),
            child: Divider(
              color: kHintTextColor,
            ),
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Conviction score:",
                    style: AppStyles.w400f12poppins
                        .copyWith(color: kWhiteColor)),
                Text(
                  "${(convictionScore * 100).toStringAsFixed(0)}%",
                  style: AppStyles.w400f12poppins
                      .copyWith(color: Color(0XFF29C2B1)),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(12),
              right: getProportionateScreenWidth(12),
              bottom: getProportionateScreenHeight(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Icon(Icons.circle, size: 8, color: Colors.red),
                ),
                SizedBox(width: getProportionateScreenWidth(8)),
                Expanded(
                  child: Text(
                    news,
                    style: AppStyles.w500f14poppins.copyWith(color: Colors.white),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
