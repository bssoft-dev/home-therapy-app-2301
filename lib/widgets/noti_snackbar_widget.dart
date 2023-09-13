import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/main_color.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';

failSnackBar(String notiTitle, String notiContent) {
  return Get.snackbar(
    notiTitle,
    notiContent,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.error, size: 30, color: Colors.white),
    backgroundColor: mainColor.mainColor(),
    titleText: Text(notiTitle,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    messageText: Text(notiContent,
        style: const TextStyle(fontSize: 15, color: Colors.white)),
  );
}

successSnackBar(BuildContext context, String notiTitle, String notiContent) {
  final MainColor mainColor = MainColor();
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  return scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mainColor.mainColor(),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 30,
                  color: mainColor.mainColor(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    notiTitle,
                    style: TextStyle(
                      fontSize: 15, // 예시에서 글자 크기를 키움
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    notiContent,
                    style: TextStyle(
                      fontSize: 12, // 예시에서 글자 크기를 키움
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  scaffoldMessenger.hideCurrentSnackBar(); // 현재 표시 중인 스낵바 숨기기
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 500,
      duration: Duration(seconds: 3),
    ),
  );
}

failureSnackBar(BuildContext context, String notiTitle, String notiContent) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  Color failureColor = Color(0xffFC2222);
  return scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: failureColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.cancel,
                  color: failureColor,
                  size: 30,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    notiTitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    notiContent,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  scaffoldMessenger.hideCurrentSnackBar();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 500,
      duration: Duration(seconds: 3),
    ),
  );
}

warningSnackBar(BuildContext context, String notiTitle, String notiContent) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  Color waringColor = Color.fromARGB(255, 255, 159, 5);

  return scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: waringColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.report,
                  color: waringColor,
                  size: 30,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    notiTitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    notiContent,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  scaffoldMessenger.hideCurrentSnackBar(); // 현재 표시 중인 스낵바 숨기기
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 500,
      duration: Duration(seconds: 3),
    ),
  );
}

yammySnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Received message: $message'),
      backgroundColor: Colors.teal,
      duration: Duration(milliseconds: 1000),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(
      //   label: 'Undo',
      //   textColor: Colors.white,
      //   onPressed: () => print('Pressed'),
      // ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20),
      //   side: BorderSide(
      //     color: Colors.red,
      //     width: 2,
      //   ),
      // ),
    ),
  );
}
