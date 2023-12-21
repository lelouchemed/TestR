import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:untitled11/models/compte_model.dart';
import 'package:untitled11/viewmodels/register_viewmodel.dart';


import '../template/values/values.dart';
import '../template/widgets/custom_button.dart';
import '../template/widgets/spaces.dart';
import 'LoginView.dart';
import 'confirmation_view.dart';
import 'home_view.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numTelController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();
  final TextEditingController _confirmationCodeController = TextEditingController();
  final RegisterViewModel _registerViewModel2 = Get.put(RegisterViewModel());
  bool _isObscure = true;



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(Sizes.PADDING_20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/doctors.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height:40),
                buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: StringConst.EMAIL_ADDRESS,
                border: Borders.customOutlineInputBorder(),
                enabledBorder: Borders.customOutlineInputBorder(),
                focusedBorder: Borders.customOutlineInputBorder(
                  //borderSide: BorderSide(color: AppColors.violetShade200),
                ),
                labelStyle: Styles.customTextStyle(),
                hintText: StringConst.EMAIL_ADDRESS,

                hintStyle: Styles.customTextStyle(),
              ),
            ),
            SizedBox(height: 25,),
            TextField(
              controller: _numTelController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: StringConst.FIRST_NAME,
                border: Borders.customOutlineInputBorder(),
                enabledBorder: Borders.customOutlineInputBorder(),
                focusedBorder: Borders.customOutlineInputBorder(

                ),
                labelStyle: Styles.customTextStyle(),

              ),
              style: Styles.customTextStyle(),
            ),
            SizedBox(height: 25,),
            TextField(
              controller: _motDePasseController,
              keyboardType: TextInputType.text,
              obscureText: _registerViewModel2.isObscure.value,
              decoration: InputDecoration(
                labelText: StringConst.PASSWORD,
                hintText: StringConst.PASSWORD,
                hintStyle: Styles.customTextStyle(),
                labelStyle: Styles.customTextStyle(),
                enabledBorder: Borders.customOutlineInputBorder(),
                focusedBorder: Borders.customOutlineInputBorder(
                  color: AppColors.violetShade200,
                ),
                suffixIcon: IconButton(
                  icon: Obx(() => Icon(
                    _registerViewModel2.isObscure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  )),
                  onPressed: () {
                    _registerViewModel2.toggleObscure();
                  },
                ),
                // suffix: Visibility(
                //   visible: !_registerViewModel2.isObscure.value,
                //   child: Container(
                //     margin: EdgeInsets.only(top: 12),
                //     child: Text(
                //       _motDePasseController.text,
                //       style: Styles.customTextStyle(),
                //     ),
                //   ),
                // ),
              ),
              style: Styles.customTextStyle(),
            ),
            // TextField(
            //   controller: _categorieController,
            //   decoration: InputDecoration(labelText: 'Category (admin/patient/docteur/clinique/laboratoire)'),
            // ),
    SpaceH36(),

    Container(
    width: Sizes.WIDTH_180,
    decoration: Decorations.customBoxDecoration(blurRadius: 10),
    child:CustomButton(
    title: StringConst.REGISTER,
    elevation: Sizes.ELEVATION_12,
    textStyle: theme.textTheme.titleSmall?.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    ),
    color: AppColors.blue,
    height: Sizes.HEIGHT_40,
    onPressed: () async {
      await _registerViewModel.register(
        Compte(
          email: _emailController.text,
          numTel: _numTelController.text,
          motDePasse: _motDePasseController.text,
          categorie: "patient",
          //categorie: 'patient',
        ),
      );
      Get.to(ConfirmationCodeView(
        emailController: _emailController,
        numTelController: _numTelController,
        motDePasseController: _motDePasseController,
       // categorie: "patient",

        //categorie :
        //categorieController: "patient",
        //categorieController: _categorieController,
      ));

    }
    )
    ),




    // ElevatedButton(
    //           onPressed: () async {
    //             await _registerViewModel.register(
    //               Compte(
    //                 email: _emailController.text,
    //                 numTel: _numTelController.text,
    //                 motDePasse: _motDePasseController.text,
    //                 categorie: _categorieController.text,
    //               ),
    //             );
    //             Get.to(ConfirmationCodeView(
    //               emailController: _emailController,
    //               numTelController: _numTelController,
    //               motDePasseController: _motDePasseController,
    //               categorieController: _categorieController,
    //             ));
    //           },
    //           child: Text('Register'),
    //         ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: () {
    //             Get.to(LoginView()); // Utilisez Get.to pour la navigation vers la vue de connexion
    //           },
    //           child: Text('Login'),
    //         ),

          ],
    );
  }
}
