import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color_widget.dart';
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
  TextEditingController installLocationController = TextEditingController();
  TextEditingController installIdController = TextEditingController();

  @override
  void initState() {
    // removeStoredValue('Install_ID');
    super.initState();
    checkDeviceConnected().then((value) => setState(() {
          if (value == true) {
            Navigator.of(context).pop();
            Get.toNamed(RouteName.therapyDevice);
          }
        }));
    getStoredValue('Install_ID').then((infoinitCheck) {
      if (infoinitCheck == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showUserInfoDialog(
              context: context,
              title: '개인정보 입력',
              subtitle: '',
              nameController: nameController,
              installLocationController: installLocationController,
              installIdController: installIdController,
              editContentOnPressed: () {},
              editTitleOnPressed: () {},
              cancelText: '취소',
              saveText: '저장');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        extendBodyBehindAppBar: true,
        body: backgroundContainer(
          context,
          Center(
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
}
