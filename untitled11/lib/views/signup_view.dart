import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled11/views/register_view.dart';

import '../template/values/values.dart';
import '../template/widgets/custom_button.dart';
import '../template/widgets/spaces.dart';
import 'LoginView.dart';

class SignUp4 extends StatefulWidget {
  @override
  _SignUp4State createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4 > {
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Spacer(flex: 1),
              Image.asset(
                'assets/images/doctors.png',  // Chemin de l'image dans les ressources
                width: 230,
                height: 230,
                //color: AppColors.blue,  // Couleur appliquée à l'image (facultatif)
              ),

              Spacer(flex: 1),
              Text(
                StringConst.SIGN_UP_2,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: Sizes.TEXT_SIZE_40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SpaceH8(),
              Text(
                StringConst.EASY_SIGN_UP,
                style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.greyShade8, fontWeight: FontWeight.bold),
              ),
              Spacer(flex: 1),
              Container(
                decoration: Decorations.customBoxDecoration(blurRadius: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomButton(
                  title: StringConst.CONTINUE_WITH_FACEBOOK,
                  elevation: Sizes.ELEVATION_12,
                  hasIcon: true,
                  icon: Icon(
                    FontAwesomeIcons.person,
                    color: AppColors.white,
                  ),
                  color: AppColors.blue,
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.TEXT_SIZE_14),
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage2()));

                  },
                ),
              ),
              SpaceH24(),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  title: StringConst.USE_EMAIL,
                  elevation: Sizes.ELEVATION_2,
                  color: AppColors.white,
                  borderSide: Borders.customBorder(width: 1.5),
                  textStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.blackShade10,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.TEXT_SIZE_14),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterView()));


                  },
                      //AutoRouter.of(context).push(SignUpScreen4Route()),
                ),
              ),
              Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // FloatingActionButton(
                  //   backgroundColor: AppColors.twitterBlue,
                  //   onPressed: () {},
                  //   mini: true,
                  //   child: Icon(
                  //     FeatherIcons.twitter,
                  //     color: AppColors.white,
                  //     size: Sizes.ICON_SIZE_18,
                  //   ),
                  //   heroTag: "twitter",
                  // ),
                  SpaceW16(),
                  FloatingActionButton(
                    backgroundColor: AppColors.googleRed,
                    onPressed: () {},
                    mini: true,
                    child: Icon(
                      FontAwesomeIcons.hospitalUser,
                      color: AppColors.white,
                      size: Sizes.ICON_SIZE_22,
                    ),
                    heroTag: "google",
                  ),
                  SpaceW16(),
                  // FloatingActionButton(
                  //   backgroundColor: AppColors.linkedInBlue,
                  //   onPressed: () {},
                  //   mini: true,
                  //   child: Icon(
                  //     FeatherIcons.linkedin,
                  //     color: AppColors.white,
                  //     size: Sizes.ICON_SIZE_18,
                  //   ),
                  //   heroTag: "linkedIn",
                  // ),
                ],
              ),
              Spacer(flex: 1),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginView()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: StringConst.ALREADY_HAVE_AN_ACCOUNT,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.greyShade8,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: StringConst.LOG_IN_2,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.purple,
                              fontSize: Sizes.TEXT_SIZE_14,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
