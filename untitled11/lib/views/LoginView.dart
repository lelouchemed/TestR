// /frontend/lib/views/register_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/models/compte_model.dart';
import 'package:untitled11/viewmodels/register_viewmodel.dart';
import '../template/values/values.dart';
import '../template/widgets/custom_button.dart';
import '../template/widgets/spaces.dart';
import 'confirmation_view.dart';
import 'home_view.dart';

class LoginView extends StatelessWidget {
  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  final RegisterViewModel _registerViewModel2 = Get.put(RegisterViewModel());
  bool _isObscured = true;

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
                  width: 300,
                  height: 300,
                ),
                SizedBox(height:40),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildForm(context) {
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

                ),
                labelStyle: Styles.customTextStyle(),
                //hintTextStyle: Styles.customTextStyle(),
                hintMaxLines: 1,
              ),
              style: Styles.customTextStyle(),
            ),
            SpaceH20(),
            TextField(
              controller: _motDePasseController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: StringConst.PASSWORD,
                  hintText: StringConst.PASSWORD,
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
                  border: Borders.customOutlineInputBorder(),
                  enabledBorder: Borders.customOutlineInputBorder(),
                  focusedBorder: Borders.customOutlineInputBorder(
                    color: AppColors.violetShade200,
                  ),
                  labelStyle: Styles.customTextStyle(),
                  hintStyle: Styles.customTextStyle(),
                ),
                obscureText: _isObscured,
            ),
    SpaceH48(),
    Row(
    children: [
    Expanded(
    child: Container(
    width: Sizes.WIDTH_180,
    decoration: Decorations.customBoxDecoration(blurRadius: 10),

    child: CustomButton(
    title: StringConst.LOG_IN,
    elevation: Sizes.ELEVATION_8,
    textStyle: theme.textTheme.titleMedium?.copyWith(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
    ),
    color: AppColors.blue,
    height: Sizes.HEIGHT_40,
    onPressed: () async {
      await _registerViewModel.login(
        _emailController.text,
        _motDePasseController.text,
      );
      if (_registerViewModel.isLoggedIn.value) {
        Get.offAll(() => HomeView()); // Utilisez Get.offAll pour supprimer la pile de navigation
      }
    })))],),
            // ElevatedButton(
            //   onPressed: () async {
            //     await _registerViewModel.login(
            //       _emailController.text,
            //       _motDePasseController.text,
            //     );
            //     if (_registerViewModel.isLoggedIn.value) {
            //       Get.offAll(() => HomeView()); // Utilisez Get.offAll pour supprimer la pile de navigation
            //     }
            //   },
            //   child: Text('Login'),
            // ),
          ],
    );
  }
}
