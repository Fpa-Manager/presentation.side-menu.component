import 'package:flutter/material.dart';
import 'package:mytheme/colors.dart';
import 'package:mytheme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:side_menu/side_menu.dart';

class SideMenuItem extends StatelessWidget implements MouseEvent {
  final ISideMenuItem item;

  @override
  final HoverEffect? hover;
  @override
  final TapEffect? tap;

  final Color? selectedColor;

  const SideMenuItem(this.item, {super.key, this.hover, this.tap, this.selectedColor});

  Icon? getIcon() {
    Icon? icon;
    if (item.icon != null) {
      if (item.isSelected) {
        icon = icon = Icon(PhosphorIconData(item.icon!), size: 40, color: const Color(0xFF2B2D40));
      } else {
        icon = icon = Icon(PhosphorIconData(item.icon!), size: 40, color: const Color(0xFF8F99AC));
      }
    }
    return icon;
  }

  HoverEffect? _hover() {
    if (item.isSelected || item.isEnable == false) return const HoverEffect(decoration: BoxDecoration());
    return hover;
  }

  TapEffect? _tap() {
    if (item.isSelected || item.isEnable == false) return const TapEffect(decoration: BoxDecoration());
    return tap;
  }

  BoxDecoration? _selectedDecoration(BuildContext context) {
    if (item.isSelected == false) return BoxDecoration();
    return BoxDecoration(color: selectedColor ?? Theme.of(context).colorScheme.surface);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 90,
      height: 90,
      child: RoundedContainer(
        border: const RoundedBorder(radius: 5),
        child: HoveredContainer(
          hover: _hover(),
          tap: _tap(),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: _selectedDecoration(context),
            child: Stack(children: [
              Visibility(
                  visible: item.isEnable == false,
                  child: const Padding(
                      padding: EdgeInsets.all(7),
                      child: Icon(
                        PhosphorIcons.prohibitThin,
                        color: Color(0xFFE7B0B0),
                      ))),
              Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Center(
                        child: item.icon == null
                            ? null
                            : Icon(
                                PhosphorIconData(item.icon!),
                                size: 40,
                                color: item.isSelected
                                    ? AppColors.activeGray
                                    : AppColors.inActiveGray
                        ),
                    ),
                  ),
                  if(item.title != null)
                  Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(item.title ?? "undefined",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.0,
                                color: item.isSelected
                                    ? AppColors.activeGray
                                    : AppColors.inActiveGray
                            ),
                      ))),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
