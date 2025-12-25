import 'package:intl/intl.dart';
import '../../../app_exports.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final ValueNotifier<TextEditingController> genderController = ValueNotifier(
    TextEditingController(),
  );
  final ValueNotifier<TextEditingController> dobController = ValueNotifier(
    TextEditingController(),
  );
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          selectedDate.value ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'SELECT DATE OF BIRTH',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryColor;
                }
                return null;
              }),
              headerForegroundColor: Colors.white,
              headerBackgroundColor: kPrimaryColor,
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dobController.value.text = DateFormat('MMM dd, yyyy').format(picked);
    }
  }

  void _onGenderSelected(String selectedGender) {
    genderController.value.text = selectedGender;
  }

  @override
  void dispose() {
    genderController.value.dispose();
    genderController.dispose();

    dobController.value.dispose();
    dobController.dispose();

    selectedDate.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(16)),
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
                  Text("Account Details", style: AppStyles.w700f20poppins),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              Center(child: ProfileAvatar()),
              ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileFields.length,
                itemBuilder: (context, index) {
                  final field = profileFields[index];
                  return CustomProfileField(
                    readOnly: field["read"],
                    title: field['title'],
                    hintText: field['hintText'],
                    controller: TextEditingController(),
                    prefixIcon: field['prefixIcon'],
                    suffixIcon: field['suffixIcon'],
                  );
                },
              ),
              ValueListenableBuilder<TextEditingController>(
                valueListenable: dobController,
                builder: (context, controller, child) {
                  return CustomProfileField(
                    onTap: () => _selectDate(context),
                    readOnly: true,
                    hintText: 'Select Date of Birth',
                    controller: controller,
                    prefixIcon: SvgPicture.asset(
                      Assets.svgAssetsAppCalendar,
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'D O B',
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              ValueListenableBuilder<TextEditingController>(
                valueListenable: genderController,
                builder: (context, controller, _) {
                  return CustomDropdown(
                    behavior: DropdownBehavior.fullFieldClick,
                    customBorderRadius: BorderRadius.circular(12),
                    prefixIcon: SvgPicture.asset(Assets.svgAssetsGenderIcon,colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),),
                    showFieldTitle: true,
                    fieldTitle: "Gender",
                    hintText: 'Select Gender',
                    isSingleSelect: true,
                    items: genderList,
                    onItemTap: (selectedGender) {
                      _onGenderSelected(selectedGender as String);
                    },
                    controller: controller,
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomActionButton(
                onTap: () => context.pop(),
                buttonText: "Save Changes",
                backgroundColor: kAppGradient,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
