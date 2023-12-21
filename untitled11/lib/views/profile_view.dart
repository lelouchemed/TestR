import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/viewmodels/register_viewmodel.dart';

class ProfileView extends StatelessWidget {
  final RegisterViewModel registerViewModel = Get.find<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Obx(
            () => registerViewModel.isLoading.value
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name: ${registerViewModel.userProfile['name']}'),
            Text('Email: ${registerViewModel.userProfile['email']}'),
            // Ajoutez d'autres informations du profil ici
          ],
        ),
      ),
    );
  }
}