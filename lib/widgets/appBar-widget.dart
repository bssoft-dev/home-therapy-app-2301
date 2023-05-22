import 'package:flutter/material.dart';

import 'package:home_therapy_app/widgets/CustomButton-widget.dart';

basicAppBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        leading: simpleIconButton(
          Icons.menu,
          30,
          () => scaffoldKey.currentState?.openDrawer(),
        ),
        // actions: [
        //   simpleIconButton(
        //     Icons.settings,
        //     30,
        //     () => scaffoldKey.currentState?.openEndDrawer(),
        //   ),
        // ],
        elevation: 0,
      ));
}
