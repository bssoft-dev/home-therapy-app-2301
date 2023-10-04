import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/apartment_noise_survey_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pss_tipi_survey_dialog.dart';
import 'package:home_therapy_app/widgets/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController snController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkDeviceConnected().then((value) => setState(() {
          if (value == true) {
            Navigator.of(context).pop();
            Get.toNamed(RouteName.therapyDevice);
          }
        }));
    checkAndSurveyDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        extendBodyBehindAppBar: true,
        body: backgroundContainer(
          context: context,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Column(
                  children: [
                    Icon(
                      Icons.phonelink_erase_outlined,
                      size: 304,
                      color: mainColor.mainColor(),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '등록된 기기가 없습니다.',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ])),
        ));
  }

  void checkAndSurveyDialog(BuildContext context) async {
    final snCheck = await getStoredValue('sn');
    final surveyA1 = await getStoredValue('surveyA1');
    final surveyA2 = await getStoredValue('surveyA2');
    final surveyA3 = await getStoredValue('surveyA3');
    final surveyA4 = await getStoredValue('surveyA4');
    final surveyA5 = await getStoredValue('surveyA5');
    final surveyP = await getStoredValue('surveyP');
    final surveyT = await getStoredValue('surveyT');
    if (snCheck == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUserInfoDialog(
            context: context,
            title: '개인정보 입력',
            subtitle: '',
            usernameController: nameController,
            ageController: ageController,
            jobController: jobController,
            snController: snController,
            editContentOnPressed: () {},
            editTitleOnPressed: () {},
            cancelText: '취소',
            saveText: '저장');
      });
    } else if (surveyA1 == null) {
      apartmentNoiseServeyDialogQ1(context: context);
    } else if (surveyA2 == null) {
      apartmentNoiseServeyDialogQ2(context: context);
    } else if (surveyA3 == null) {
      apartmentNoiseServeyDialogQ3(context: context);
    } else if (surveyA4 == null) {
      apartmentNoiseServeyDialogQ4(context: context);
    } else if (surveyA5 == null) {
      apartmentNoiseServeyDialogQ5(context: context);
    } else if (surveyP == null) {
      pssServeyDialogQ(context: context);
    } else if (surveyT == null) {
      tipiServeyDialogQ(context: context);
    }
  }
}
