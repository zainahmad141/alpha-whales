import 'package:alpha_whales/app_exports.dart';
import 'package:alpha_whales/presentation/whale/data/whale_data.dart';

class CustomStockCard extends StatelessWidget {
  final CustomStockCardModel card;

  const CustomStockCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(16),
      ),
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: _buildAdaptiveView(),
    );
  }

  Widget _buildAdaptiveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLogo(),
            SizedBox(width: getProportionateScreenWidth(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.ticker ?? '',
                    style: AppStyles.w400f12poppins.copyWith(
                      color: kLightGrayColor,
                    ),
                  ),
                  Text(
                    card.companyName ?? "",
                    style: AppStyles.w400f12poppins.copyWith(
                      color: kHintTextColor,
                    ),
                  ),
                ],
              ),
            ),
            if (card.showBuyButton == true) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: card.onBuyPressed,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(14),
                        vertical: getProportionateScreenHeight(4),
                      ),
                      decoration: BoxDecoration(
                        color: ((card.buttonText?? '').toLowerCase() == "sell")
                            ? kRedStatusColor
                            : kGreenStatusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        card.buttonText ?? "",
                        style: AppStyles.w400f10poppins.copyWith(color: kWhiteColor),
                      ),
                    ),
                  ),
                  if (card.price != null) ...[
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Text(
                      card.price!,
                      style: AppStyles.w400f12poppins.copyWith(color: kWhiteColor),
                    ),
                  ],
                ],
              ),
            ],
            if (card.percentage != null) ...[
              SizedBox(width: getProportionateScreenWidth(8)),
              Text(
                card.percentage!,
                style: AppStyles.w600f10poppins.copyWith(
                  fontSize: 14,
                  color: kLightGrayColor,
                ),
              ),
            ],
          ],
        ),
        if (card.shares != null || card.timeAgo != null) ...[
          SizedBox(height: getProportionateScreenHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (card.shares != null)
                Text(
                    card.shares!,
                  style: AppStyles.w400f12poppins.copyWith(fontWeight: FontWeight.w300,color: kMutedGrayColor)
                ),
              if (card.timeAgo != null)
                Text(
                    card.timeAgo!,
                    style: AppStyles.w400f10poppins.copyWith(color: kHintTextColor)

                ),
            ],
          ),
        ],
      ],
    );
  }
  Widget _buildLogo() {
    final double size = getProportionateScreenWidth(30);

    if ((card.logoPath ?? '').toLowerCase().endsWith('.svg') ) {
      return SvgPicture.asset(
        card.logoPath ?? "",
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        card.logoPath ?? "",
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    }
  }
}
