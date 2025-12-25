import 'package:alpha_whales/app_exports.dart';

class InsiderScreen extends StatefulWidget {
  const InsiderScreen({super.key});

  @override
  State<InsiderScreen> createState() => _InsiderScreenState();
}

class _InsiderScreenState extends State<InsiderScreen> {
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(12),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Insider Trades", style: AppStyles.w700f20poppins),
            SizedBox(height: getProportionateScreenHeight(16)),
            ValueListenableBuilder<int>(
              valueListenable: selectedTab,
              builder: (context, currentIndex, _) {
                return Row(
                  children: [
                    CustomTabButton(
                      text: "Recent",
                      isSelected: currentIndex == 0,
                      onTap: () => selectedTab.value = 0,
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                    CustomTabButton(
                      text: "Largest Buys",
                      isSelected: currentIndex == 1,
                      onTap: () => selectedTab.value = 1,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(16)),

            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  final trades = currentIndex == 0
                      ? insiderStockData
                      : insiderStockData.where((t) => t.action == "Buy").toList();

                  return ListView.builder(
                    itemCount: trades.length,
                    itemBuilder: (context, index) {
                      final trade = trades[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(8),
                        ),
                        child: InsiderStockCard(
                          stockModel: trade,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
