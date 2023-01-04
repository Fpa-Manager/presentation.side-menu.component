import 'package:flutter/material.dart';
import 'package:mytheme/component/mouse_event.dart';
import 'package:mytheme/component/page_container.dart';
import 'item_widget.dart';
import 'model_interface.dart';

class SideMenu extends StatefulWidget {
  final ISideMenuModel model;
  const SideMenu(this.model, {super.key, this.hoverColor, this.tapColor, this.selectedColor});

  final Color? hoverColor;
  final Color? tapColor;
  final Color? selectedColor;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
    widget.model.addListener(() { setState(() {}); });
  }

  Widget getItem(ISideMenuItem element) =>
      SideMenuItem(
          element,
          hover: HoverEffect(
              decoration:  widget.hoverColor == null
                           ? null
                           : BoxDecoration(color: widget.hoverColor)
          ),
          tap: TapEffect(
                decoration: widget.tapColor == null
                            ? null
                            : BoxDecoration(color: widget.tapColor),
                onPressed: element.command.executeAsync),
          selectedColor: widget.selectedColor,
      );

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      width: 120,
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
// Top menu
            Column(
              children:widget.model.top.map((e) => getItem(e)).toList(),
            ),

            const Divider(color: Colors.black12),
//Middle menu
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.model.middle.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: getItem(widget.model.middle[index]));
                  }),
            ),

            const Divider(color: Colors.black12),

//Bottom menu
            Column(
              children: const [
                // Item
                Text("+7 (499) 110-68-67",
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF8F99AC))),
                Text("info@fitness-pro.ru",
                    style: TextStyle(fontSize: 10.0, color: Color(0xFF8F99AC))),
              ],
            ),
          ]),
    );
  }
}
