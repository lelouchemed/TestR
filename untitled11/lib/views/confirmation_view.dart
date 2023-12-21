import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/viewmodels/register_viewmodel.dart';

import '../template/values/values.dart';
import 'LoginView.dart';

class ConfirmationCodeView extends StatelessWidget {
  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final TextEditingController _confirmationCodeController = TextEditingController();

  // Ajoutez ces contrôleurs pour recevoir les valeurs de RegisterView
  final TextEditingController emailController;
  final TextEditingController numTelController;
  final TextEditingController motDePasseController;
  //final TextEditingController categorieController;

  ConfirmationCodeView({
    required this.emailController,
    required this.numTelController,
    required this.motDePasseController,
    //required this.categorieController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation d\'e-mail'),
        toolbarHeight: 150,
        backgroundColor: Color(MyColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Veuillez entrer le code de confirmation reçu par e-mail.'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 7, // Ajoute une ombre à la carte
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Définit la forme de la carte
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _confirmationCodeController,
                    decoration: InputDecoration(labelText: 'Code de confirmation',
                      labelStyle: TextStyle(
                        color: Colors.indigo, // Couleur du texte du label
                      ),
                    ),

                  ),
                ),
              ),

            ),
            ElevatedButton(
             // onPressed: _confirmEmail,
              onPressed: () async {
              await _registerViewModel.confirmRegister(
                emailController.text,
                _confirmationCodeController.text,
                numTelController.text,
                motDePasseController.text,
                "patient"
                //categorieController.text,
              );
              if (!_registerViewModel.isConfirmed.value) {
                // Registration failed, handle accordingly
              } else {
                // Registration succeeded, show congratulations dialog
                _showCongratulationsDialog();
              }
            },
              child: Text('Confirmer'),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo, // Couleur de fond du bouton
                textStyle: TextStyle(
                  color: Colors.white, // Couleur du texte du bouton
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // BorderRadius circulaire
                ),

              ),
            ),
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextField(
      //         controller: _confirmationCodeController,
      //         decoration: InputDecoration(labelText: 'Confirmation Code'),
      //       ),
      //       ElevatedButton(
      //         onPressed: () async {
      //           await _registerViewModel.confirmRegister(
      //             emailController.text,
      //             _confirmationCodeController.text,
      //             numTelController.text,
      //             motDePasseController.text,
      //             "patient"
      //             //categorieController.text,
      //           );
      //           if (_registerViewModel.isLoading.value) {
      //             Get.offAll(() => LoginView()); // Utilisez Get.offAll pour supprimer la pile de navigation
      //           }
      //         },
      //         child: Text('Submit Code'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  void _showCongratulationsDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Félicitations'),
        content: Text('Votre compte a été créé avec succès.'),
        actions: [
          ElevatedButton(
      style: ElevatedButton.styleFrom(
      primary: Colors.indigo, // Couleur de fond du bouton
        textStyle: TextStyle(
          color: Colors.white, // Couleur du texte du bouton
        ),
      ),
            onPressed: () {
              Get.offAll(() => LoginView());
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
