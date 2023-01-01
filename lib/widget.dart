import 'package:flutter/material.dart';
import 'package:mytheme/component/mouse_event.dart';
import 'package:mytheme/component/page_container.dart';
import 'package:side_menu/side_menu_item.dart';
import 'blznc_command.dart';
import 'model_interface.dart';

class SideMenu extends StatefulWidget {
  final ISideMenuModel model;
  const SideMenu(this.model, {super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
    widget.model.addListener(() {
      setState(() {});
    });
  }

  Widget getItem(ISideMenuItem element) {
    var item =
    SideMenuItem(element,
        // hover: const HoverEffect(
        //   //decoration: BoxDecoration(color: Color(0xFFE5ECF9)),
        // ),
        tap: TapEffect(
          decoration: BoxDecoration(color: Color(0xFFDCE0E8)),
          onPressed: element.command.executeAsync
        ));
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      width: 130,
      padding: const EdgeInsets.all(15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

        // Top menu
        Column(
          children: widget.model.top.map((e) => getItem(e)).toList(),),

        const Divider(color: Colors.black12),
            //Middle menu
        Expanded(
          child: ListView.builder(
            itemCount: widget.model.middle.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(padding: EdgeInsets.only(bottom: 7), child: getItem(widget.model.middle[index]));
            }),
        ),

        const Divider(color: Colors.black12),

        //Bottom menu
        Column(
          children: [
            ElevatedButton(
                onPressed: () =>
                    widget.model.changeItem(999, 555, "Калашников", 0xede8, BlancConsoleCommand()),
                child: const Text("Change")),
            // Item
            const Text("+7 (499) 110-68-67",
                style: TextStyle(fontSize: 10.0, color: Color(0xFF8F99AC))),
            const Text("info@fitness-pro.ru",
                style: TextStyle(fontSize: 10.0, color: Color(0xFF8F99AC))),
          ],
        ),
      ]),
    );
  }
}
