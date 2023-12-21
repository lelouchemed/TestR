import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/views/profile_view.dart';
import 'package:untitled11/views/register_view.dart';
import 'package:untitled11/viewmodels/register_viewmodel.dart';
import 'package:untitled11/views/signup_view.dart';
 // Assurez-vous d'importer le bon fichier

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterViewModel()); // Assurez-vous d'ajouter ceci
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
        initialRoute: '/SignUp4', // Définissez la route initiale
        getPages: [
          GetPage(name: '/SignUp4', page: () => SignUp4()),
          GetPage(name: '/RegisterView', page: () => RegisterView()), // Page d'inscription
          GetPage(name: '/ProfileView', page: () => ProfileView()), // Page de profil
        ],
    );
  }
}

