import 'package:flutter/material.dart';

basicAppBar(
    String title, BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
}
