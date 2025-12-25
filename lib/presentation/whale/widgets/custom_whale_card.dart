import '../../../app_exports.dart';

class WhaleCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final String tag;
  final int convictionScore;
  final List<Map<String, dynamic>> holdings;

  const WhaleCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.tag,
    required this.convictionScore,
    required this.holdings,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RouteName.whaleDetail);
      },
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(16)),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D29),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30, backgroundImage: AssetImage(imageUrl)),
                SizedBox(width: getProportionateScreenWidth(15)),
                Expanded(
                  child: Column(
                    spacing: getProportionateScreenHeight(2),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppStyles.w600f16poppins),
                      Text(
                        role,
                        style: AppStyles.w600f10poppins.copyWith(
                          color: kHintTextColor,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(4),),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(6),
                          vertical: getProportionateScreenHeight(2),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xffFFD66B),width: getProportionateScreenWidth(0.5)),
                        ),
                        child: Text(
                          tag,
                          style: AppStyles.w400f12poppins.copyWith(
                            color: Color(0xffFFD66B),
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: getProportionateScreenHeight(5),
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(52),
                      height: getProportionateScreenWidth(52),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            constraints: const BoxConstraints(
                              minHeight: 120,
                              minWidth: 120,
                            ),
                            value: convictionScore / 100,
                            strokeWidth: 2,
                            backgroundColor: Colors.grey.shade800,
                            color: convictionScore < 40
                                ? kRedStatusColor
                                : (convictionScore < 80
                                      ? Color(0xffFFD66B)
                                      : kSecondaryColor),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$convictionScore",
                                style: AppStyles.w400f14poppins.copyWith(
                                  color: convictionScore < 40
                                      ? kRedStatusColor
                                      : (convictionScore < 80
                                            ? Color(0xffFFD66B)
                                            : kSecondaryColor),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Conviction Score",
                      textAlign: TextAlign.center,
                      style: AppStyles.w400f10poppins.copyWith(
                        color: kLightGrayColor,
                        fontSize: 9
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: holdings.map((h) {
                return Expanded(
                  child: Row(
                    children: [
                      Text(
                        "Top Holdings",
                        style: AppStyles.w400f12poppins.copyWith(
                          color: kMutedGrayColor,
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(45)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            h["logo1"],
                            width: getProportionateScreenWidth(12),
                            height: getProportionateScreenHeight(15),
                          ),
                          SizedBox(width: getProportionateScreenWidth(4)),
                          Text(
                            h["ticker1"],
                            style: AppStyles.w400f12poppins.copyWith(
                              color: kLightGrayColor,
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(12)),
                          Text(
                            "${h["percent1"]}%",
                            style: AppStyles.w400f12poppins.copyWith(
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: getProportionateScreenWidth(15)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            h["logo2"],
                            width: getProportionateScreenWidth(12),
                            height: getProportionateScreenHeight(15),
                          ),
                          SizedBox(width: getProportionateScreenWidth(4)),
                          Text(
                            h["ticker2"],
                            style: AppStyles.w400f12poppins.copyWith(
                              color: kLightGrayColor,
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(12)),
                          Text(
                            "${h["percent2"]}%",
                            style: AppStyles.w400f12poppins.copyWith(
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
