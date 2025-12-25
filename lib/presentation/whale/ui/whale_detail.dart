import 'package:alpha_whales/presentation/whale/data/whale_data.dart';
import '../../../app_exports.dart';

class WhaleDetail extends StatefulWidget {
  const WhaleDetail({super.key});

  @override
  State<WhaleDetail> createState() => _WhaleDetailState();
}

class _WhaleDetailState extends State<WhaleDetail> {
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(16),
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: getProportionateScreenWidth(8),
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: kSecondaryColor),
                  ),
                  Text("Whale Profile", style: AppStyles.w700f20poppins),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(12),),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(6),
                    vertical: getProportionateScreenHeight(2),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1D29),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffFFD66B)),
                  ),
                  child: Text(
                    "Billionaires",
                    style: AppStyles.w400f12poppins.copyWith(
                      color: const Color(0xffFFD66B),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kMutedGrayColor)
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            Assets.pngAssetsWarrenBuffet,
                          ),
                        ),
                      ),
                      Text("Warren\n Buffet", style: AppStyles.w600f16poppins),
                      Text(
                        "Chairman & CEO",
                        style: AppStyles.w600f10poppins.copyWith(
                          color: kHintTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(85),
                    height: getProportionateScreenWidth(85),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          constraints: const BoxConstraints(
                            minHeight: 120,
                            minWidth: 120,
                          ),
                          value: 92 / 100,
                          strokeWidth: 4,
                          backgroundColor: Colors.grey.shade800,
                          color: kSecondaryColor,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "92",
                              style: AppStyles.w400f14poppins.copyWith(
                                color: kSecondaryColor,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              "Conviction\nScore",
                              textAlign: TextAlign.center,
                              style: AppStyles.w400f10poppins.copyWith(
                                color: kLightGrayColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(32)),
              Text("Top Holdings", style: AppStyles.w700f20poppins),
              SizedBox(height: getProportionateScreenHeight(12)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  return CustomStockCard(card: stockList[index]);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  return Row(
                    children: List.generate(tabs.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(8),
                        ),
                        child: CustomTabButton(
                          text: tabs[index],
                          isSelected: currentIndex == index,
                          onTap: () => selectedTab.value = index,
                        ),
                      );
                    }),
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  final filteredHoldings = allHoldings
                      .where((h) => tabs[currentIndex].contains(h.buttonText as Pattern ))
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredHoldings.length,
                    itemBuilder: (context, index) {
                      final data = filteredHoldings[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(4),
                        ),
                        child: CustomStockCard(card: data),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
