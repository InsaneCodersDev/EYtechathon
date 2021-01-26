import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vaccinemgmt/constants.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:vaccinemgmt/login_new.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:vaccinemgmt/services/imagecapture.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_list_item.dart';

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
  @override
  Widget build(BuildContext context) {
    // String imgurl = global.imgurl;

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
                  'https://instagram.fbom22-1.fna.fbcdn.net/v/t51.2885-19/s320x320/73457367_681556628996410_6035727685781553152_n.jpg?_nc_ht=instagram.fbom22-1.fna.fbcdn.net&_nc_ohc=JcjeP5OkT10AX8xPu27&tp=1&oh=06146332faa715222f3833e5121b7976&oe=6017E913',
                  // global.userdata == null ? "" : imgurl,
                  // radius:50,
                  animateFromOldImageOnUrlChange: true,
                  onTap: () async {
                    // // global.calledfrom = "user";
                    // await Navigator.of(context, rootNavigator: true)
                    //     .pushReplacement(MaterialPageRoute(
                    //         builder: (context) => ImageCapture()));
                    // setState(() {
                    //   // imgurl = global.imgurl;
                    // });
                  },
                  // radius: kSpacingUnit.w * 7,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: Colors.black,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text("Girish Salunke",
              style: TextStyle(fontFamily: "Varela", fontSize: 25)),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            "Aadhaar: 987654321",
            style: TextStyle(fontFamily: "Varela", fontSize: 15),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                color: Colors.teal[400]),
            child: Center(
              child: Text(
                "COVID Soldier",
                // global.balance != null
                // ? "BALANCE :  " + global.balance.toString()
                // : "NO BALANCE",
                style: TextStyle(
                    fontFamily: "Varela",
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
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
                          text: 'Contact US',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.envelope,
                          text: 'Add 500 ',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: ProfileListItem(
                          icon: FontAwesomeIcons.certificate,
                          text: 'View Certificate',
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

                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => Login()));
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
