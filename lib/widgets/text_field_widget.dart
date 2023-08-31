import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/main_color_widget.dart';
import 'package:lottie/lottie.dart';

final MainColor mainColor = MainColor();
final _formKey = GlobalKey<FormState>();
String groupValue = '여성';

Future<dynamic> showUserInfoDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required TextEditingController nameController,
  required TextEditingController installLocationController,
  required TextEditingController installIdController,
  required VoidCallback editTitleOnPressed,
  required VoidCallback editContentOnPressed,
  required String cancelText,
  required String saveText,
  VoidCallback? saveOnPressed,
}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Form(
          key: _formKey,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: StatefulBuilder(builder: (context, StateSetter setDialog) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(bottom: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != '')
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Lottie.asset(
                                      'assets/lottie/user_info.json',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fill,
                                      repeat: false,
                                      animate: true),
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(fontSize: 17),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('여성',
                                        style: TextStyle(fontSize: 15)),
                                    Radio(
                                        value: '여성',
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          setDialog(() {
                                            groupValue = value.toString();
                                          });
                                        }),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    const Text('남성',
                                        style: TextStyle(fontSize: 15)),
                                    Radio(
                                        value: '남성',
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          setDialog(() {
                                            groupValue = value.toString();
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textBox('Full Test', nameController, '이름', '이름을 입력해주세요.'),
                      const SizedBox(
                        height: 5,
                      ),
                      textBox('Install Location', installLocationController,
                          '설치 위치', '설치 위치를 입력해주세요.'),
                      const SizedBox(
                        height: 5,
                      ),
                      textBox('Install ID', installIdController, '설치 아이디',
                          '설치 아이디를 입력해주세요.'),
                    ],
                  ),
                  actions: [
                    Divider(
                      color: mainColor.mainColor(),
                      thickness: 0.8, //thickness of divier line
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              cancelText,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                //db에 저장하는 과정 필요
                                debugPrint(nameController.text);
                                debugPrint(installLocationController.text);
                                debugPrint(installIdController.text);
                                debugPrint(groupValue);

                                //한번만 호출되도록 하는 캐시 저장코드
                                // saveStoredValue('infoinit', 'yes');
                                Navigator.pop(context);
                              }
                            },
                            child: Text(saveText,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)))
                      ],
                    )
                  ],
                );
              })),
        );
      });
}

Widget textBox(String formTitle, TextEditingController textEditingController,
    String hintText, String? validatorText) {
  return ListTile(
    title: Text(formTitle),
    subtitle: TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: textEditingController,
      onSaved: (saveValue) => textEditingController.text = saveValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        hintText: hintText,
      ),
    ),
  );
}
