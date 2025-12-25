import '../../../app_exports.dart';
import '../data/alert_data.dart';
import '../data/alert_model.dart';
import '../widgets/stock_alert_card.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
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
            Text("Alerts", style: AppStyles.w700f20poppins),
            SizedBox(height: getProportionateScreenHeight(16)),
            ValueListenableBuilder<int>(
              valueListenable: selectedTab,
              builder: (context, currentIndex, _) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                  ),
                );
              },
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedTab,
                builder: (context, currentIndex, _) {
                  List<StockAlert> filteredAlerts;
                  if (currentIndex == 0) {
                    filteredAlerts = alerts;
                  } else if (currentIndex == 1) {
                    filteredAlerts = alerts
                        .where((a) => a.alertType == "Whale Alert")
                        .toList();
                  } else if (currentIndex == 2) {
                    filteredAlerts = alerts
                        .where((a) => a.alertType == "Insider Alert")
                        .toList();
                  } else {
                    filteredAlerts = alerts
                        .where((a) => a.alertType == "CNBC Alert")
                        .toList();
                  }
                  return ListView.builder(
                    itemCount: filteredAlerts.length,
                    itemBuilder: (context, index) {
                      final alert = filteredAlerts[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(8),
                        ),
                        child: StockAlertCard(
                          alert: alert,
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
