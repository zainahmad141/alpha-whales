import '/app_exports.dart';

enum DropdownBehavior { iconClick, fullFieldClick }

class CustomDropdown extends StatefulWidget {
  final List<dynamic> items;
  final Function(List<dynamic>) onItemTap;
  final String? hintText;
  final bool enabled;
  final bool isSingleSelect;
  final TextEditingController controller;
  final String? errorMessage;
  final Function(String)? onChanged;
  final DropdownBehavior behavior;
  final bool showFieldTitle;
  final String? fieldTitle;
  final TextStyle? fieldTitleStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? customBorderRadius;
  final bool? readOnly;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.controller,
    this.hintText,
    this.enabled = true,
    this.isSingleSelect = false,
    this.errorMessage,
    this.onChanged,
    this.behavior = DropdownBehavior.iconClick,
    this.showFieldTitle = false,
    this.fieldTitle,
    this.fieldTitleStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.customBorderRadius,
    this.readOnly = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier(false);
  final ValueNotifier<List<dynamic>> _selectedItemsNotifier = ValueNotifier([]);
  final FocusNode _focusNode = FocusNode();

  List<dynamic> get _filteredItems {
    final query = widget.controller.text.toLowerCase();

    final bool isFromSelection =
        _selectedItemsNotifier.value.isNotEmpty &&
        _selectedItemsNotifier.value.every((item) {
          final name = item is Map && item.containsKey('name')
              ? item['name'].toString()
              : item.toString();
          return name.toLowerCase() == query;
        });

    if (query.isEmpty || isFromSelection) {
      return widget.items;
    }

    return widget.items.where((item) {
      final name = item is Map && item.containsKey('name')
          ? item['name'].toString()
          : item.toString();
      return name.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    if (widget.isSingleSelect && widget.controller.text.isNotEmpty) {
      final initialItem = widget.items.firstWhere((item) {
        final name = item is Map && item.containsKey('name')
            ? item['name'].toString()
            : item.toString();
        return name == widget.controller.text;
      }, orElse: () => null);
      if (initialItem != null) {
        _selectedItemsNotifier.value = [initialItem];
      }
    }
  }

  @override
  void dispose() {
    _isExpandedNotifier.dispose();
    _selectedItemsNotifier.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.behavior == DropdownBehavior.fullFieldClick) {
      if (_focusNode.hasFocus) {
        _isExpandedNotifier.value = true;
      } else {
        _isExpandedNotifier.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius usedBorderRadius =
        widget.customBorderRadius ?? BorderRadius.circular(8);

    Widget textField = TextField(
      style: AppStyles.w400f14poppins.copyWith(color: kWhite2Color),
      focusNode: _focusNode,
      controller: widget.controller,
      readOnly:
          widget.readOnly! ||
          !widget.enabled ||
          widget.behavior == DropdownBehavior.fullFieldClick,
      onChanged: (text) {
        widget.onChanged?.call(text);
        if (widget.behavior != DropdownBehavior.fullFieldClick) {
          _isExpandedNotifier.value = true;
        }
      },
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? SizedBox(
                width: getProportionateScreenWidth(16),
                height: getProportionateScreenHeight(16),
                child: Center(child: widget.prefixIcon!),
              )
            : null,
        hintText: widget.hintText ?? 'Select or enter text',
        hintStyle: AppStyles.w400f14poppins.copyWith(color: kWhite2Color),
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(10),
        ),
        border: OutlineInputBorder(
          borderRadius: usedBorderRadius,
          borderSide: BorderSide(
            color:
                widget.errorMessage != null && widget.errorMessage!.isNotEmpty
                ? Colors.red
                : kHintTextColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: usedBorderRadius,
          borderSide: BorderSide(color: kHintTextColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: usedBorderRadius,
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        errorText: widget.errorMessage,
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(12),
                ),
                child: SizedBox(child: Center(child: widget.suffixIcon!)),
              )
            : InkWell(
                onTap:
                    widget.enabled &&
                        widget.behavior == DropdownBehavior.iconClick
                    ? () {
                        _isExpandedNotifier.value = !_isExpandedNotifier.value;
                        if (!_isExpandedNotifier.value) {
                          _focusNode.unfocus();
                        } else {
                          _focusNode.requestFocus();
                        }
                      }
                    : widget.enabled &&
                          widget.behavior == DropdownBehavior.fullFieldClick
                    ? () {
                        _isExpandedNotifier.value = !_isExpandedNotifier.value;
                        if (!_isExpandedNotifier.value) {
                          _focusNode.unfocus();
                        } else {
                          _focusNode.requestFocus();
                        }
                      }
                    : null,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isExpandedNotifier,
                  builder: (context, isExpanded, _) {
                    return Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: kWhiteColor,
                    );
                  },
                ),
              ),
      ),
    );

    if (widget.enabled && widget.behavior == DropdownBehavior.fullFieldClick) {
      textField = InkWell(
        onTap: () {
          _isExpandedNotifier.value = !_isExpandedNotifier.value;
          if (_isExpandedNotifier.value) {
            _focusNode.requestFocus();
          } else {
            _focusNode.unfocus();
          }
        },
        child: IgnorePointer(ignoring: !widget.enabled, child: textField),
      );
    } else if (widget.enabled &&
        widget.behavior == DropdownBehavior.iconClick) {
      textField = GestureDetector(
        onTap: () {
          if (widget.enabled) {
            _focusNode.requestFocus();
            _isExpandedNotifier.value = false;
          }
        },
        child: textField,
      );
    }

    Widget dropdownContent = Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: widget.showFieldTitle && widget.fieldTitle != null
                ? getProportionateScreenHeight(8)
                : 0,
          ),
          child: textField,
        ),
        if (widget.showFieldTitle && widget.fieldTitle != null)
          Positioned(
            left: getProportionateScreenWidth(16),
            top: getProportionateScreenHeight(7),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(6),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                widget.fieldTitle!,
                style: AppStyles.w500f16poppins.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dropdownContent,
        ValueListenableBuilder<bool>(
          valueListenable: _isExpandedNotifier,
          builder: (context, isExpanded, _) {
            if (!isExpanded || !widget.enabled) return const SizedBox.shrink();

            return Container(
              margin: EdgeInsets.only(top: getProportionateScreenHeight(4)),
              decoration: BoxDecoration(
                border: Border.all(color: kHintTextColor),
                borderRadius: usedBorderRadius,
                color: kBgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ValueListenableBuilder<List<dynamic>>(
                valueListenable: _selectedItemsNotifier,
                builder: (context, selectedItems, _) {
                  if (_filteredItems.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(16)),
                      child: Text(
                        'No matching items found',
                        style: AppStyles.w400f14poppins.copyWith(
                          color: kWhite2Color,
                        ),
                      ),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final dynamic item = entry.value;
                      final bool isSelected = selectedItems.contains(item);
                      final String itemName = item is Map
                          ? item['name'].toString()
                          : item.toString();

                      return Column(
                        children: [
                          InkWell(
                            onTap: widget.enabled
                                ? () {
                                    List<dynamic> updatedSelection = [];

                                    if (widget.isSingleSelect) {
                                      if (isSelected) {
                                        updatedSelection = [];
                                        widget.controller.text = '';
                                      } else {
                                        updatedSelection = [item];
                                        widget.controller.text = itemName;
                                      }
                                      _isExpandedNotifier.value = false;
                                      _focusNode.unfocus();
                                    } else {
                                      updatedSelection = List.from(
                                        _selectedItemsNotifier.value,
                                      );
                                      if (isSelected) {
                                        updatedSelection.remove(item);
                                      } else {
                                        updatedSelection.add(item);
                                      }
                                      widget.controller.text = updatedSelection
                                          .map(
                                            (e) => e is Map
                                                ? e['name'].toString()
                                                : e.toString(),
                                          )
                                          .join(', ');
                                    }

                                    _selectedItemsNotifier.value =
                                        updatedSelection;
                                    widget.onItemTap(updatedSelection);
                                  }
                                : null,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(12),
                                horizontal: getProportionateScreenWidth(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(
                                        10,
                                      ),
                                      vertical: getProportionateScreenHeight(5),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? kSecondaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      itemName,
                                      style: AppStyles.w400f14poppins.copyWith(
                                        color: isSelected
                                            ? kWhiteColor
                                            : kHintTextColor,
                                      ),
                                    ),
                                  ),
                                  if (!widget.isSingleSelect && isSelected)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(8),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (index < _filteredItems.length - 1)
                            Divider(height: 1, color: kHintTextColor),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
