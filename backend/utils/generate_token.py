# /backend/utils/generate_token.py
import string
import random
from flask_jwt_extended import create_access_token
from datetime import datetime, timedelta


def generate_random_token():
    token_length = 6
    characters = string.ascii_letters + string.digits
    return ''.join(random.choice(characters) for _ in range(token_length))


def generate_token(user):
    # Générez un token JWT avec le payload
    access_token = create_access_token(
        identity={
            'id': user.id,
            'email': user.email,
            'categorie': user.categorie,
            'exp': datetime.utcnow() + timedelta(hours=24)
        }
    )
    return access_token


