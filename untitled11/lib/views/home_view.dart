// /frontend/lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_view.dart'; // Assurez-vous que ProfileView est correctement importé

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Get.to(() => ProfileView());
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Implémentez la logique de déconnexion ici
                Get.back(); // Retournez à l'écran de connexion après la déconnexion
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Contenu de la page d\'accueil'),
      ),
    );
  }
}
