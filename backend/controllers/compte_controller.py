from flask import Blueprint, request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from Modeles.compte_model import Compte, db
from utils.generate_token import generate_random_token, generate_token
from utils.send_email import  send_confirmation_email
import hashlib 

compte_bp = Blueprint('compte', __name__)

# Dictionnaire pour stocker les codes de confirmation temporaires
confirmation_tokens = {}

@compte_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    email = data.get('email')
    num_tel = data.get('numTel')
    mot_de_passe = data.get('motDePasse')
    categorie = data.get('categorie')

    # Hachez le mot de passe avec SHA-256
    hashed_password = hashlib.sha256(mot_de_passe.encode()).hexdigest()

    # Générez un code de confirmation aléatoire
    confirmation_token = generate_random_token()

    # Stockez temporairement le code de confirmation dans le dictionnaire
    confirmation_tokens[email] = confirmation_token

    # Envoyez un e-mail de confirmation
    send_confirmation_email(email, confirmation_token)

    # Utilisez le mot de passe haché lors de la création du compte
    #nouvel_utilisateur = Compte(email=email, numTel=num_tel, motDePasse=hashed_password, categorie=categorie, confirmation_token=confirmation_token)

    # Enregistrez le nouvel utilisateur dans la base de données
    #db.session.add(nouvel_utilisateur)
    db.session.commit()

    return jsonify({'message': 'Confirmation code sent. Check your email to complete registration.'}), 200

@compte_bp.route('/confirm_register', methods=['POST'])
def confirm_register():
    data = request.get_json()

    email = data.get('email')
    confirmation_token = data.get('confirmation_token')
    num_tel = data.get('numTel')
    mot_de_passe = data.get('motDePasse')  # Ajoutez cette ligne pour extraire le mot de passe
    categorie = data.get('categorie')  # Ajoutez cette ligne pour extraire la catégorie

    # Récupérez le code de confirmation temporaire pour l'e-mail donné
    temp_confirmation_token = confirmation_tokens.get(email)

    if temp_confirmation_token and temp_confirmation_token == confirmation_token:
        # Supprimez le code de confirmation temporaire
        del confirmation_tokens[email]

        # Hachez le mot de passe avec SHA-256
        hashed_password = hashlib.sha256(mot_de_passe.encode()).hexdigest()

        # Créez un nouvel utilisateur avec les détails complets
        nouvel_utilisateur = Compte(email=email, numTel=num_tel, motDePasse=hashed_password, categorie=categorie, confirmation_token=confirmation_token)
        
        # Enregistrez le nouvel utilisateur dans la base de données
        db.session.add(nouvel_utilisateur)
        db.session.commit()

        return jsonify({'message': 'Account confirmed and registered successfully.'}), 200
    else:
        return jsonify({'message': 'Invalid confirmation token or email.'}), 400
    


@compte_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    mot_de_passe = data.get('motDePasse')

    utilisateur = Compte.query.filter_by(email=email).first()

    if utilisateur and hashlib.sha256(mot_de_passe.encode()).hexdigest() == utilisateur.motDePasse:
        # Générez un token JWT avec le payload
        access_token = generate_token(utilisateur)

        return jsonify({'message': 'Login successful.', 'access_token': access_token}), 200
    else:
        return jsonify({'message': 'Invalid email or password.'}), 401

@compte_bp.route('/protected', methods=['GET'])
@jwt_required()  # Assurez-vous que la route est protégée par JWT
def protected():
    # Accédez à l'identité de l'utilisateur via get_jwt_identity
    current_user = get_jwt_identity()
    return jsonify(logged_in_as=current_user), 200