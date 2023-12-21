from Modeles.compte_model import Compte, db


def confirmer_compte(confirmation_token):
    # Rechercher l'utilisateur par le token de confirmation
    utilisateur = Compte.query.filter_by(confirmation_token=confirmation_token).first()

    if utilisateur:
        # Marquer le compte comme confirmé
        utilisateur.confirmed_account = True
        # Effacer le token de confirmation, car il n'est plus nécessaire
        utilisateur.confirmation_token = None
        # Enregistrer les modifications dans la base de données
        db.session.commit()
        return True
    else:
        return False


