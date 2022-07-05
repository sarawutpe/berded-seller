import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/studio/studio_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/phone_number_model.dart';
import 'package:berded_seller/src/utils/ImageUtil.dart';
import 'package:berded_seller/src/utils/Util.dart';
import 'package:berded_seller/src/utils/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../app.dart';

class StudioPage extends StatefulWidget {
  const StudioPage({Key? key}) : super(key: key);

  @override
  _StudioPageState createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  final controller = ScreenshotController();
  bool isInitialed = false;
  int _selectedBackgroundImageIndex = 0;
  final _numberController = TextEditingController();
  final _priceController = TextEditingController();
  final _sharedContentController = TextEditingController();
  String _selectedOperator = 'AIS';
  String _sumNumber = "";

  double userFontScale = 0;

  final _backgroundImageList = [
    'studio_bg_01.jpg',
    'studio_bg_02.jpg',
    'studio_bg_03.jpg',
    'studio_bg_04.jpg',
    'studio_bg_05.jpg',
    'studio_bg_06.jpg',
    'studio_bg_07.jpg',
    'studio_bg_08.jpg',
    'studio_bg_09.jpg',
    'studio_bg_10.jpg',
    'studio_bg_11.jpg',
    // 'studio_bg_12.jpg',
  ];

  String _selectedFontStyle = 'Roboto : 1';
  final _fontStyleList = [
    'Roboto : 1',
    'Mali : 2',
    'Sriracha : 3',
    'Bebas Neue : 4',
    'Lobster : 5',
    'Dancing Script : 6',
    'Short Stack : 7',
    'Pacifico : 8',
    'Satisfy : 9',
    'Gorditas : 10',
    'Merienda : 11',
    'Creepster : 12',
    'Metal Mania : 13',
    'Nosifer : 14',
    'Risque : 15',
    'Butcherman : 16',
    'Jolly Lodger : 17',
    'Piedra : 18',
    'Vampiro One : 19',
    'Black Ops One : 20',
    'Berkshire Swash : 21',
    'Russo One : 22',
    'Audiowide : 23',
    'Baumans : 24',
    'Aladin : 25',
    'Viga : 26',
    'Electrolize : 27',
    'ZCOOL QingKe HuangYou : 28',
    'Ma Shan Zheng : 29',
    'Liu Jian Mao Cao : 30',
    'Zhi Mang Xing : 31',
    'Long Cang : 32',
  ];

  String _selectedFontSize = '1x : 4';
  final _fontSizeList = [
    '0.5x : 1',
    '0.7x : 2',
    '0.8x : 3',
    '1x : 4',
    '2x : 5',
    '3x : 6',
  ];

  // set background image to SharedPreferences
  Future<void> _setBackgroundImage(int value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(Constants.DEFAULT_STUDIO_IMAGE, value);
    setState(() {
      _selectedBackgroundImageIndex = value;
    });
  }

  // set number color to SharedPreferences
  Future<void> _setNumberColor(int value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(Constants.DEFAULT_STUDIO_NUMBER_COLOR, value);
  }

  // set font style to SharedPreferences
  Future<void> _setFontStyle(String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.DEFAULT_STUDIO_FONT_STYLE, value);
  }

  // set fontSize to SharedPreferences
  Future<void> _setFontSize(String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(Constants.DEFAULT_STUDIO_FONT_SIZE, value);
  }

  refreshData() {
    context.read<StudioBloc>().add(
          StudioEventCustomNumber(
            PhoneNumberModel(
              phone: _numberController.text,
              price: _priceController.text,
            ),
          ),
        );
    _sharedContentController.text =
        'เบอร์ : ${_numberController.text}, เครือข่าย : ${_selectedOperator}, ราคา : ${_priceController.text.isNotEmpty ? (FormatterConvert().currency(int.parse(_priceController.text)) + '.-') : '0.0.-'}, ร้าน${context.read<LoginBloc>().state.result?.branch_name ?? ''}, LINE : ${context.read<LoginBloc>().state.result?.branch_line_id ?? ''}, https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}';
  }

  // Create number color values
  int pickerNumberColor = 0xFFCD3234;

  // ValueChanged<Color> callback
  void changeColor(int color) {
    _setNumberColor(pickerNumberColor);
    setState(() => pickerNumberColor = color);
  }

  Widget build(BuildContext context) {
    userFontScale = MediaQuery.of(context).textScaleFactor;
    if (!isInitialed) {
      isInitialed = true;
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null) {
        final phoneNumber = (arguments as Map<String, Object?>)['phoneNumberModel'] as PhoneNumberModel;
        _numberController.text = phoneNumber.phone ?? "";
        _priceController.text = phoneNumber.price ?? "";
        _selectedOperator = phoneNumber.operator ?? "";
        _sumNumber = phoneNumber.sum ?? "";
        _sharedContentController.text =
            'เบอร์ : ${_numberController.text}, เครือข่าย : ${_selectedOperator}, ราคา : ${_priceController.text.isNotEmpty ? (FormatterConvert().currency(int.parse(_priceController.text)) + '.-') : '0.0.-'}, ร้าน${context.read<LoginBloc>().state.result?.branch_name ?? ''}, LINE : ${context.read<LoginBloc>().state.result?.branch_line_id ?? ''}, https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}';
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.lightPrimary,
        title: Text("Berded Studio"),
        actions: [
          IconButton(
              onPressed: () async {
                await controller.capture(delay: Duration(milliseconds: 100)).then((capturedImage) async {
                  await saveImageIntoGallery(capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                await controller.capture(delay: Duration(milliseconds: 100)).then((capturedImage) async {
                  await shareImage(capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
              icon: Icon(Icons.share)),
          if (false)
            SizedBox(
              width: 45.0,
              child: PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: 30,
                ),
                padding: EdgeInsets.all(0.0),
                offset: Offset(0, 45),
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3, right: 10),
                            child: Icon(
                              Icons.share_outlined,
                              color: ThemeColors.lightIcon,
                            ),
                          ),
                          Text('แชร์'),
                        ],
                      ),
                      onTap: () {}),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.white,
              );
            }
            // get default number color
            pickerNumberColor = snapshot.data!.getInt(Constants.DEFAULT_STUDIO_NUMBER_COLOR) ?? pickerNumberColor;
            // get default background image
            _selectedBackgroundImageIndex = snapshot.data!.getInt(Constants.DEFAULT_STUDIO_IMAGE) ?? 1;
            // get default font style
            _selectedFontStyle = snapshot.data!.getString(Constants.DEFAULT_STUDIO_FONT_STYLE) ?? _selectedFontStyle;
            _selectedFontStyle = getDefaultDropdownValue(snapshot.data!, _fontStyleList, _selectedFontStyle, Constants.DEFAULT_STUDIO_FONT_STYLE);
            // get default font size
            _selectedFontSize = snapshot.data!.getString(Constants.DEFAULT_STUDIO_FONT_SIZE) ?? _selectedFontSize;
            _selectedFontSize = getDefaultDropdownValue(snapshot.data!, _fontSizeList, _selectedFontSize, Constants.DEFAULT_STUDIO_FONT_SIZE);

            return Container(
              padding: EdgeInsets.all(16.0),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  _buildCustomStudio(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      _buildBackground(),
                      _buildCustomBackground(),
                      _buildCountTheme(),
                    ],
                  ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // custom studio
  _buildCustomStudio() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                margin: EdgeInsets.only(right: 4),
                child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                      _sumNumber = getNumberSum(_numberController.text);
                      refreshData();
                    },
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(14),
                      FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                    ],
                    validator: (value) {
                      final countNumber = value.toString().replaceAll(" ", "-");
                      final pattern = r'(^(\d)-*(\d)-*(\d)-*(\d)-*(\d)-*(\d)-*(\d)-*(\d)-*(\d)-*(\d$))';
                      final regExp = RegExp(pattern);
                      if (countNumber.length >= 10 && !regExp.hasMatch(value.toString())) {
                        return 'ไม่ถูกต้อง';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _numberController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: -10),
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              _numberController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.mobile_friendly,
                              size: 15,
                              color: ThemeColors.lightPrimary,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "เบอร์")),
              ),
            ),
            Card(
              margin: EdgeInsets.only(right: 4),
              child: SizedBox(
                width: 100,
                child: TextFormField(
                    onChanged: (value) => setState(() {
                          refreshData();
                        }),
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[ ]')), FilteringTextInputFormatter.allow(RegExp(r'[\d]'))],
                    controller: _priceController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: -10),
                        icon: Padding(
                          padding: EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              _priceController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.money_off,
                              size: 20,
                              color: ThemeColors.lightPrimary,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "ราคา")),
              ),
            ),
            Card(
              margin: EdgeInsets.all(0),
              child: SizedBox(
                width: 70,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: SizedBox(),
                    value: _selectedOperator,
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? newOperatorValue) {
                      setState(() {
                        _selectedOperator = newOperatorValue!;
                      });
                      refreshData();
                    },
                    items: <String>['AIS', 'DTAC', 'TRUE', 'FINN MOBILE', 'GOMO', 'NT MOBILE', 'PENGWIN'].map<DropdownMenuItem<String>>((String _operator) {
                      return DropdownMenuItem<String>(
                        value: _operator,
                        child: Row(
                          children: [
                            getOperatorImagePath(_operator, 50, 50),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        // shared and copy to clipboard
        Container(
          margin: EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: TextFormField(
                    onChanged: null,
                    autofocus: false,
                    autocorrect: false,
                    controller: _sharedContentController,
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                    decoration: InputDecoration(
                      hintText: 'คัดลอกและแชร์',
                      isCollapsed: false,
                      suffix: GestureDetector(
                        onTap: () => _formatContentIntoClipboard(_sharedContentController.text),
                        child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.content_copy,
                              size: 15,
                            )),
                      ),
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Custom font style
              Card(
                margin: EdgeInsets.only(right: 2),
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: SizedBox(),
                      value: _selectedFontStyle,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        _setFontStyle(newValue!);
                        setState(() {
                          _selectedFontStyle = newValue;
                        });
                      },
                      items: _fontStyleList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value.isNotEmpty ? value : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value.split(" : ")[0], style: _customFontStyle(TextStyle(fontSize: 16), forcedFontStyle: value)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Custom font size
              Card(
                margin: EdgeInsets.only(right: 2),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: SizedBox(),
                      value: _selectedFontSize,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        _setFontSize(newValue!);
                        setState(() {
                          _selectedFontSize = newValue;
                        });
                      },
                      items: _fontSizeList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value.isNotEmpty ? value : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value.split(" : ")[0]),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // palette icon
              Card(
                margin: EdgeInsets.only(right: 2),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: _showColorPickerDialog,
                    icon: Icon(
                      Icons.palette_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // preview background
  Widget _buildBackground() {
    return SizedBox(
      height: (SizerUtil.deviceType == DeviceType.mobile) ? MediaQuery.of(context).size.width - 20 : 600,
      width: (SizerUtil.deviceType == DeviceType.mobile) ? MediaQuery.of(context).size.width - 20 : 600,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Screenshot(
          controller: controller,
          child: Container(
            margin: EdgeInsets.all((SizerUtil.deviceType == DeviceType.mobile) ? 0 : 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.width - 20,
              child: Stack(
                children: [
                  // background image
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Material(
                      color: Colors.white,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black26,
                        child: Image.asset(
                          "assets/images/${_backgroundImageList[_selectedBackgroundImageIndex]}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // certified badge
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      height: 25,
                      child: navigatorState.currentContext!.read<LoginBloc>().state.result?.certified == true ? Image.asset('assets/icon/ic_certified.png') : SizedBox(),
                    ),
                  ),

                  // logo
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: (SizerUtil.deviceType == DeviceType.mobile) ? 60 : 100,
                            child: navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_avatar != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_avatar ?? ""))
                                : Image.asset('assets/icon/ic_launcher_android.png'),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // branch name, line id, phone number
                          Column(
                            children: [
                              Text(
                                "ร้าน ${navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_name ?? ''}",
                                style: _customFontStyle(TextStyle(
                                  color: Colors.white,
                                  fontSize: geConfigFontSize((SizerUtil.deviceType == DeviceType.mobile) ? 18 : 27),
                                  shadows: <Shadow>[
                                    Shadow(blurRadius: 12.0, color: Color.fromARGB(255, 0, 0, 0)),
                                    Shadow(blurRadius: 9.0, color: Color.fromARGB(255, 0, 0, 255)),
                                  ],
                                )),
                              ),
                              Text(
                                "${navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_line_id ?? ''} (${navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_phone ?? ''})",
                                style: _customFontStyle(TextStyle(
                                    color: Colors.white.withOpacity(0.95),
                                    fontSize: geConfigFontSize(SizerUtil.deviceType == DeviceType.mobile ? 15 : 20),
                                    shadows: <Shadow>[
                                      Shadow(blurRadius: 8.0, color: Color.fromARGB(255, 0, 0, 0)),
                                      Shadow(blurRadius: 9.0, color: Color.fromARGB(255, 0, 0, 255)),
                                    ])),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // phone number
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            _numberController.text.isNotEmpty ? _numberController.text : 'XXX-XXX-XXX',
                            style: _customFontStyle(TextStyle(
                              fontSize: geConfigFontSize(SizerUtil.deviceType == DeviceType.mobile ? 35 : 40),
                              fontWeight: FontWeight.bold,
                              color: Color(pickerNumberColor),
                            )),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // price
                  Positioned(
                    bottom: (SizerUtil.deviceType == DeviceType.mobile) ? 60 : 120,
                    right: (SizerUtil.deviceType == DeviceType.mobile) ? 20 : 30,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      padding: EdgeInsets.only(top: 4.0, right: 10.0, bottom: 4.0, left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: SizedBox(
                                        child: getOperatorImagePath(_selectedOperator, 50, 20),
                                      ),
                                    ),
                                    if (_sumNumber.isNotEmpty)
                                      Container(
                                        height: 20,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              'ผลรวม : ',
                                              textAlign: TextAlign.center,
                                              style: _customFontStyle(TextStyle(
                                                color: Colors.white.withOpacity(0.8),
                                                fontSize: geConfigFontSize(14),
                                                fontWeight: FontWeight.bold,
                                              )),
                                            ),
                                            Text(
                                              _sumNumber,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: geConfigFontSize(14),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (_isNumeric(_priceController.text))
                                SizedBox(
                                  width: 110,
                                  child: AutoSizeText(
                                    _priceController.text.isNotEmpty ? (FormatterConvert().currency(int.parse(_priceController.text)) + '.-') : '0.0.-',
                                    style: TextStyle(
                                      fontSize: geConfigFontSize(SizerUtil.deviceType == DeviceType.mobile ? 25 : 30),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // url
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}',
                            style: _customFontStyle(TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            )),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomBackground() {
    return Center(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8.0),
          itemCount: _backgroundImageList.length,
          itemBuilder: (context, index) {
            final imageName = _backgroundImageList[index];
            return GestureDetector(
              onTap: () => _setBackgroundImage(index),
              child: Container(
                padding: EdgeInsets.all(5), // Border width
                decoration: _selectedBackgroundImageIndex == index ? BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)) : null,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/${imageName}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  // Alert control
  alertControl(String text) {
    final snackBar = SnackBar(content: Text(text), action: SnackBarAction(label: 'ซ่อน', onPressed: () {}));
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Saving images to Specific Location
  Future<dynamic> saveImageIntoGallery(Uint8List image) async {
    if (_numberController.text.isEmpty || _priceController.text.isEmpty) {
      alertControl('กรุณาป้อนข้อมูล');
    } else {
      // hide palette icon
      await Permission.storage.request();
      await ImageGallerySaver.saveImage(Uint8List.fromList(image), quality: 80, name: "BERDED_${_numberController.text}");
      alertControl('บันทึกรูปภาพแล้ว');
    }
  }

  // Saving images to Specific Location
  Future<dynamic> shareImage(Uint8List image) async {
    // Copy content to clipboard
    _formatContentIntoClipboard(_sharedContentController.text);

    // verify phone number and price
    if (_numberController.text.isEmpty || _priceController.text.isEmpty) {
      alertControl('กรุณาป้อนข้อมูล');
    } else {
      // request permission
      await Permission.storage.request();
      // create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String fullPath = '$dir/BERDED_${_numberController.text}.png';
      File capturedFile = File(fullPath);
      await capturedFile.writeAsBytes(image);
      // shared to external
      await ShareExtend.share(
        capturedFile.path,
        "image",
        sharePanelTitle: "ร้าน ${navigatorState.currentContext!.read<LoginBloc>().state.result?.branch_name ?? ''}",
        subject: _numberController.text,
      );
    }
  }

  // Copy content to clipboard
  _formatContentIntoClipboard(String orgContent) {
    if (orgContent.isNotEmpty) {
      final formatSharedContent = orgContent.replaceAll(", ", "\n");
      Clipboard.setData(ClipboardData(text: formatSharedContent));
      alertControl('คัดลอกไปยังคลิปบอร์ดแล้ว');
    }
  }

  // Show color picker dialog
  Future<void> _showColorPickerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('เลือกสี'),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.clear,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Color(pickerNumberColor),
              onColorChanged: (color) async {
                changeColor(color.value);
                await _setNumberColor(pickerNumberColor);
              },
            ),
          ),
        );
      },
    );
  }

  double geConfigFontSize(double orgFont) {
    final rightFont = orgFont / userFontScale;
    if (_selectedFontSize == _fontSizeList[0]) {
      return rightFont * 0.5;
    } else if (_selectedFontSize == _fontSizeList[1]) {
      return rightFont * 0.7;
    } else if (_selectedFontSize == _fontSizeList[2]) {
      return rightFont * 0.8;
    } else if (_selectedFontSize == _fontSizeList[3]) {
      return rightFont * 1;
    } else if (_selectedFontSize == _fontSizeList[4]) {
      return rightFont * 1.1;
    } else if (_selectedFontSize == _fontSizeList[5]) {
      return rightFont * 1.2;
    } else {
      return rightFont;
    }
  }

  // custom font styles
  _customFontStyle(TextStyle? currentStyle, {String? forcedFontStyle}) {
    final checkFont = forcedFontStyle ?? _selectedFontStyle;
    if (checkFont == _fontStyleList[0]) {
      return GoogleFonts.roboto(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[1]) {
      return GoogleFonts.mali(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[2]) {
      return GoogleFonts.sriracha(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[3]) {
      return GoogleFonts.bebasNeue(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[4]) {
      return GoogleFonts.lobster(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[5]) {
      return GoogleFonts.dancingScript(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[6]) {
      return GoogleFonts.shortStack(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[7]) {
      return GoogleFonts.pacifico(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[8]) {
      return GoogleFonts.satisfy(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[9]) {
      return GoogleFonts.gorditas(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[10]) {
      return GoogleFonts.merienda(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[11]) {
      return GoogleFonts.creepster(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[12]) {
      return GoogleFonts.metalMania(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[13]) {
      return GoogleFonts.nosifer(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[14]) {
      return GoogleFonts.risque(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[15]) {
      return GoogleFonts.butcherman(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[16]) {
      return GoogleFonts.jollyLodger(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[17]) {
      return GoogleFonts.piedra(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[18]) {
      return GoogleFonts.vampiroOne(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[19]) {
      return GoogleFonts.blackOpsOne(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[20]) {
      return GoogleFonts.berkshireSwash(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[21]) {
      return GoogleFonts.russoOne(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[22]) {
      return GoogleFonts.audiowide(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[23]) {
      return GoogleFonts.baumans(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[24]) {
      return GoogleFonts.aladin(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[25]) {
      return GoogleFonts.viga(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[26]) {
      return GoogleFonts.electrolize(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[27]) {
      return GoogleFonts.zcoolQingKeHuangYou(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[28]) {
      return GoogleFonts.maShanZheng(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[29]) {
      return GoogleFonts.liuJianMaoCao(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[30]) {
      return GoogleFonts.zhiMangXing(textStyle: currentStyle);
    } else if (checkFont == _fontStyleList[31]) {
      return GoogleFonts.longCang(textStyle: currentStyle);
    } else {
      return GoogleFonts.roboto(textStyle: currentStyle);
    }
  }

  // check default drop down list
  String getDefaultDropdownValue(SharedPreferences pref, List list, String selected, String prefKey) {
    if (list.contains(selected) == false) {
      selected = list[0];
      pref.setString(prefKey, selected);
    }
    return selected;
  }

  _buildCountTheme() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('ธีมทั้งหมด ${_backgroundImageList.length}'),
    );
  }
}
