import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vaccinemgmt/authenticate.dart';
import 'package:vaccinemgmt/constants.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:vaccinemgmt/main.dart';
import 'package:vaccinemgmt/profile_list_item.dart';
import 'package:vaccinemgmt/models/user.dart' as firebaseuser;
// import 'package:vaccinemgmt/services/database.dart';
import 'package:provider/provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:vaccinemgmt/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccinemgmt/services/imagecapture.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences localStorage;

class User extends StatelessWidget {
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final fuser = Provider.of<firebaseuser.User>(context);
    String imgurl = global.imgurl;
    Future.delayed(Duration(seconds: 3), () async {
      global.balance = await global.getBalance(global.myaddress);
      setState(() {});
    });
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircularProfileAvatar(
                  global.userdata == null ? "" : imgurl,
                  // radius:50,
                  animateFromOldImageOnUrlChange: true,
                  onTap: () async {
                    global.calledfrom = "user";
                    await Navigator.of(context, rootNavigator: true)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => ImageCapture()));
                    setState(() {
                      imgurl = global.imgurl;
                    });
                  },
                  // radius: kSpacingUnit.w * 7,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            fuser == null ? "" : fuser.name,
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            fuser == null ? "" : fuser.email,
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                global.balance != null
                    ? "BALANCE :  " + global.balance.toString()
                    : "NO BALANCE",
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            customHeader: Icon(LineAwesomeIcons.phone,
                                size: 40, color: Colors.purple),
                            animType: AnimType.BOTTOMSLIDE,
                            tittle: 'sldkblkn',
                            desc: 'ldfnbkldfbn',
                            body: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Message",
                                  style: TextStyle(
                                      fontFamily: "Varela",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 10),
                                  child: TextField(
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.black),
                                    cursorColor: Colors.purple,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.edit),
                                      hintText: "Your Number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            btnCancelOnPress: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            btnOkOnPress: () {},
                          )..show();
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.phone,
                          text: 'Add/Change you Number',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var res = await global.sendCoin(500);
                          global.balance =
                              await global.getBalance(global.myaddress);
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.envelope,
                          text: 'Add 500 ',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("Hello");
                          var res = await global.withdrawCoin(100);
                          global.balance =
                              await global.getBalance(global.myaddress);
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Remove 100',
                        ),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                      ),
                      GestureDetector(
                        onTap: () async {
                          await User.init();
                          localStorage.setString('authenticated', "false");

                          print(localStorage.getString('authenticated'));

                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => Authenticate()));
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          hasNavigation: false,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
