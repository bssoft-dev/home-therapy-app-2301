import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

commonSurveyDialog({
  required BuildContext context,
  required String dialogName,
  required String surveyTitle,
  required String surveyContent,
  required VoidCallback surveyOnPressed,
  required ValueChanged<int> onSurveyContentValueChange, // 이 부분을 추가

  String? surveyContentTitle,
  int? surveyContentValue,
  List<String>? surveyImageList,
  List<int>? surveyContentValueList,
}) {
  return Get.dialog(barrierDismissible: false, name: dialogName,
      StatefulBuilder(builder: (context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      title: Text(
        surveyTitle,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(surveyContentTitle!, style: const TextStyle(fontSize: 15)),
          Text(surveyContent, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SvgPicture.asset(
                          surveyImageList[index],
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Radio(
                          value: surveyContentValueList![index],
                          groupValue: surveyContentValue,
                          onChanged: (value) {
                            setDialog(() {
                              onSurveyContentValueChange(value as int);
                              surveyContentValue = value;
                              surveyContentValueList[index] =
                                  surveyContentValue!;
                            });
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    );
                  },
                  itemCount: surveyImageList!.length)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            setDialog(() {
              surveyOnPressed();
            });
          },
          child: const Text('확인', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }));
}
