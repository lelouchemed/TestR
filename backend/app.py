# /backend/app.py
from flask import Flask
from controllers.compte_controller import compte_bp

app = Flask(__name__)

# Enregistrement du blueprint
app.register_blueprint(compte_bp, url_prefix='/compte')
#app.register_blueprint(auth_bp, url_prefix='/auth')

if __name__ == '__main__':
    app.run(debug=True)
