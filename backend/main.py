# /backend/main.py
from flask import Flask
from flask_jwt_extended import JWTManager
from flask_login import LoginManager
from config.config import Config
from Modeles.compte_model import db, Compte
from controllers.compte_controller import compte_bp
from Views.auth_views import auth_bp

app = Flask(__name__)
jwt = JWTManager(app)

app.config.from_object(Config)

db.init_app(app)

# Initialiser Flask-Login
login_manager = LoginManager(app)
login_manager.login_view = 'auth.login'

@login_manager.user_loader
def load_user(user_id):
    return Compte.query.get(int(user_id))

app.register_blueprint(compte_bp, url_prefix='/compte')
app.register_blueprint(auth_bp, url_prefix='/auth')

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", port=50000, debug=True)
