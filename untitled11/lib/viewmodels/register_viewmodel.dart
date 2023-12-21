import 'package:get/get.dart';
import 'package:untitled11/models/compte_model.dart';
import 'package:untitled11/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterViewModel extends GetxController {
  final ApiService _apiService = ApiService('http://192.168.150.219:50000', FlutterSecureStorage());
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Remplacez par votre URL backend

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxMap userProfile = {}.obs;
  var isConfirmed = false.obs;

  var isObscure = false.obs;

  void toggleObscure() {
    isObscure.toggle();
  }

  void setConfirmed(bool value) {
    isConfirmed.value = value;
  }


  Future<void> register(Compte compte) async {
    try {
      isLoading.value = true;
      await _apiService.register(compte);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmRegister(String email, String confirmationCode, String numTel, String motDePasse, String categorie) async {
    try {
      isLoading.value = true;
      await _apiService.confirmRegister(email, confirmationCode, numTel, motDePasse, categorie);
      setConfirmed(true);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final String? accessToken = await _apiService.login(email, password);

      if (accessToken != null) {
        isLoggedIn.value = true;
        // Enregistrez le token dans flutter_secure_storage
        print('Access Token: $accessToken');
        await _secureStorage.write(key: 'access_token', value: accessToken);

        // Récupérez les informations du profil après la connexion réussie
        await getUserProfile();

      } else {
        // Gérer les erreurs de connexion
        print('Failed to log in');
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> profile = await _apiService.getUserProfile();

      if (profile.isNotEmpty) {
        userProfile.assignAll(profile);
        Get.toNamed('/ProfileView');
      } else {
        // Gérer le cas où le profil est vide
        print('Empty user profile');
      }
    } catch (e) {
      // Gérer les erreurs de récupération du profil
      print('Failed to get user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> logout() async {
    isLoggedIn.value = false;
    userProfile.clear();
  }

}
