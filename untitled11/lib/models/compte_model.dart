// /frontend/lib/models/compte_model.dart
class Compte {
  String email;
  String numTel;
  String motDePasse;
  String categorie;

  Compte({
    required this.email,
    required this.numTel,
    required this.motDePasse,
    required this.categorie,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'numTel': numTel,
      'motDePasse': motDePasse,
      'categorie': "patient",
    };
  }
}
