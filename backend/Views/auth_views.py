from flask import Blueprint, jsonify, request
from flask import jsonify
from flask_login import login_user, logout_user, current_user
from Modeles.compte_model import Compte, db

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['POST'])
def login():
    # Récupérer les données du formulaire de connexion
    data = request.get_json()

    if not data or 'email' not in data or 'motDePasse' not in data:
        return jsonify({'message': 'Invalid request. Provide email and password.'}), 400

    email = data['email']
    mot_de_passe = data['motDePasse']

    # Rechercher l'utilisateur dans la base de données
    utilisateur = Compte.query.filter_by(email=email, motDePasse=mot_de_passe).first()

    if utilisateur:
        # L'utilisateur existe, authentification réussie
        return jsonify({'message': 'Login successful'}), 200
    else:
        # L'utilisateur n'existe pas ou les informations d'identification sont incorrectes
        return jsonify({'message': 'Invalid email or password'}), 401        


@auth_bp.route('/logout', methods=['GET'])
def logout():
    # Gérer la déconnexion ici en utilisant Flask-Login
    if current_user.is_authenticated:
        logout_user()
        return jsonify({'message': 'Logout successful'}), 200
    else:
        return jsonify({'message': 'User not logged in'}), 401
