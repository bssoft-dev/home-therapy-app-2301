import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';

basicAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    backgroundColor: Colors.transparent,
    // centerTitle: true,
    // leading: simpleIconButton(
    //   Icons.menu,
    //   30,
    //   () => scaffoldKey.currentState?.openDrawer(),
    // ),

    actions: [
      simpleIconButton(
        Icons.settings,
        50,
        mainColor.mainColor(),
        () => scaffoldKey.currentState?.openEndDrawer(),
      ),
    ],
    elevation: 0,
  );
}
