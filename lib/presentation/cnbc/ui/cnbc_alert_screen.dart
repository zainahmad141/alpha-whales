import '../data/cnbc_data.dart';
import '../data/cnbc_model.dart';
import '../widgets/custom_cnbc_alert_container.dart';
import '/app_exports.dart';

class CNBCScreen extends StatefulWidget {
  const CNBCScreen({super.key});

  @override
  State<CNBCScreen> createState() => _CNBCScreenState();
}

class _CNBCScreenState extends State<CNBCScreen> {
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
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CNBC Alerts", style: AppStyles.w700f20poppins),
            SizedBox(height: getProportionateScreenHeight(16)),

            /// --- Tabs ---
            ValueListenableBuilder<int>(
              valueListenable: selectedTab,
              builder: (context, currentIndex, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(cnbcTabs.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(8),
                        ),
                        child: CustomTabButton(
                          text: cnbcTabs[index],
                          isSelected: currentIndex == index,
                          onTap: () => selectedTab.value = index,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),

            SizedBox(height: getProportionateScreenHeight(16)),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  List<Recommendation> filteredRecommendations;

                  if (currentIndex == 0) {
                    filteredRecommendations = recommendations;
                  } else if (currentIndex == 1) {
                    filteredRecommendations = recommendations.where((r) => (r.action.toString().toLowerCase()).contains("buy",),
                        )
                        .toList();
                  } else if (currentIndex == 2) {
                    filteredRecommendations = recommendations.where((r) => (r.action.toString().toLowerCase()).contains("sell",),
                        )
                        .toList();
                  } else {
                    filteredRecommendations = recommendations.where((r) => (r.action.toString().toLowerCase()).contains("downgrade"),).toList();
                  }
                  return ListView.builder(
                    itemCount: filteredRecommendations.length,
                    itemBuilder: (context, index) {
                      final item = filteredRecommendations[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(8),
                        ),
                        child: RecommendationCard(recommendation: item),
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