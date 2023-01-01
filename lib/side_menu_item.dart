import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytheme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:side_menu/side_menu.dart';

class SideMenuItem extends StatelessWidget implements MouseEvent {
  final ISideMenuItem item;

  @override
  final HoverEffect? hover;
  @override
  final TapEffect? tap;

  const SideMenuItem(this.item, {super.key, this.hover, this.tap});

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

  HoverEffect? _hoverEffect(BuildContext context) {
    HoverEffect? result;
    if (hover == null || hover?.decoration == null) {
      result = HoverEffect(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withAlpha(50)));
    }
    return result;
  }

  TapEffect? _tapEffect(BuildContext context) {
    TapEffect? result;
    if (tap == null || tap?.decoration == null) {
      result = TapEffect(decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: RoundedContainer(
        border: const RoundedBorder(radius: 5),
        child: HoveredContainer(
          hover: item.isSelected || item.isEnable == false ? null : _hoverEffect(context),
          tap: item.isSelected || item.isEnable == false ? null : _tapEffect(context),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: item.isSelected ? tap?.decoration : null,
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
                    child: Center(child: getIcon()),
                  ),
                  Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(item.title,
                            textAlign: TextAlign.center,
                            style: item.isSelected
                                ? const TextStyle(fontSize: 12.0, color: Color(0xFF2B2D40))
                                : const TextStyle(fontSize: 12.0, color: Color(0xFF8F99AC))),
                      )),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
