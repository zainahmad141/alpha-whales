import 'package:alpha_whales/app_exports.dart';

import '../data/cnbc_model.dart';

class RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  bool get _isBuy => recommendation.action.toLowerCase() == 'buy';
  bool get _isSell => recommendation.action.toLowerCase() == 'sell';
  bool get _trendIsUp {
    final l = recommendation.trendLabel.toLowerCase();
    return l.contains('up') || l.contains('bull');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(16),
        horizontal: getProportionateScreenWidth(20),
      ),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(recommendation.logoPath),
              SizedBox(width: getProportionateScreenWidth(13)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (recommendation.ticker.trim().isNotEmpty)
                      Text(
                        recommendation.ticker,
                        style: AppStyles.w400f12poppins.copyWith(
                          color: kLightGrayColor,
                        ),
                      ),
                    if (recommendation.companyName.trim().isNotEmpty)
                      Text(
                        recommendation.companyName,
                        style: AppStyles.w400f12poppins.copyWith(
                          color: kHintTextColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (_isBuy || _isSell) _buySellPill(),
            ],
          ),

          if (recommendation.analystName.isNotEmpty ||
              recommendation.quote.isNotEmpty) ...[
            SizedBox(height: getProportionateScreenHeight(12)),
            if (recommendation.analystName.trim().isNotEmpty)
              Text(
                recommendation.analystName,
                style: AppStyles.w500f10poppins.copyWith(
                  color: kMutedGrayColor,
                  fontSize: 12,
                ),
              ),
            if (recommendation.quote.trim().isNotEmpty) ...[
              SizedBox(height: getProportionateScreenHeight(4)),
              Text(
                '“${recommendation.quote}”',
                style: AppStyles.w400f12poppins.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],

          if (recommendation.currentPrice.isNotEmpty ||
              recommendation.targetPrice.isNotEmpty ||
              recommendation.trendLabel.isNotEmpty ||
              recommendation.trendValue.isNotEmpty) ...[
            SizedBox(height: getProportionateScreenHeight(12)),
            Wrap(
              spacing: getProportionateScreenWidth(50),
              runSpacing: getProportionateScreenHeight(12),
              children: [
                if (recommendation.currentPrice.trim().isNotEmpty)
                  _priceChip(
                    label: 'Current Price',
                    value: recommendation.currentPrice,
                    valueColor: kSecondaryColor,
                  ),
                if (recommendation.targetPrice.trim().isNotEmpty)
                  _priceChip(
                    label: 'Target Price',
                    value: recommendation.targetPrice,
                    valueColor: Color(0xffFFD66B),
                  ),
                if (recommendation.trendLabel.isNotEmpty ||
                    recommendation.trendValue.isNotEmpty)
                  _trendChip(),
              ],
            ),
          ],

          if (recommendation.timeAgo.trim().isNotEmpty) ...[
            SizedBox(height: getProportionateScreenHeight(12)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                recommendation.timeAgo,
                style: AppStyles.w400f10poppins.copyWith(color: kHintTextColor),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLogo(String path, {double size = 30}) {
    if (path.toLowerCase().endsWith('.svg')) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(path, fit: BoxFit.contain),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D29),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.contain),
      ),
    );
  }

  Widget _buySellPill() {
    final color = _isBuy ? kGreenStatusColor : kRedStatusColor;
    final text = _isBuy ? 'Buy' : 'Sell';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(14),
        vertical: getProportionateScreenHeight(4),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppStyles.w400f12poppins.copyWith(color: kWhiteColor),
      ),
    );
  }

  Widget _priceChip({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12),
        vertical: getProportionateScreenHeight(6),
      ),
      decoration: BoxDecoration(
        color: Color(0XFF0B0F1A),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label  ',
            style: AppStyles.w400f10poppins.copyWith(color: kWhiteColor),
          ),
          Text(
            value,
            style: AppStyles.w400f10poppins.copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }

  Widget _trendChip() {
    final up = _trendIsUp;
    final color = up ? kSecondaryColor : kRedStatusColor;

    final labelText = recommendation.trendLabel.isEmpty
        ? (up ? 'Upside' : 'Downside')
        : recommendation.trendLabel;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12),
        vertical: getProportionateScreenHeight(6),
      ),
      decoration: BoxDecoration(
        color: up
            ? kGreenStatusColor.withValues(alpha: 0.1)
            : kRedStatusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labelText,
            style: AppStyles.w500f10poppins.copyWith(color: color),
          ),
          SizedBox(width: getProportionateScreenWidth(4)),
          Icon(
            up ? Icons.trending_up : Icons.trending_down,
            size: 14,
            color: color,
          ),
          if (recommendation.trendValue.trim().isNotEmpty) ...[
            SizedBox(width: getProportionateScreenWidth(8)),
            Text(
              recommendation.trendValue,
              style: AppStyles.w500f10poppins.copyWith(color: color),
            ),
          ],
        ],
      ),
    );
  }
}
