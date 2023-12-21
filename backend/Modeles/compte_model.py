# /backend/models/compte_model.py
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Compte(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255), unique=True, nullable=False)
    numTel = db.Column(db.String(255), unique=True, nullable=False)
    motDePasse = db.Column(db.String(255), nullable=False)
    categorie = db.Column(db.Enum('admin', 'patient', 'docteur', 'clinique', 'laboratoire'), nullable=False)
    confirmation_token = db.Column(db.String(55), nullable=False)
   

    
