# /backend/utils/send_email.py
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def send_confirmation_email(email, confirmation_token):
    smtp_server = 'smtp.gmail.com'  # Mettez le serveur SMTP réel
    smtp_port = 587  # Mettez le port SMTP réel
    smtp_username = 'amibarka54@gmail.com'
    smtp_password = 'bytn ocpa wxqa zdcc'
    sender_email = 'tt49468724@gmail.com'

    subject = 'Confirmation de votre inscription'
    message = f'Votre code de confirmation est : {confirmation_token}'

    # Construire le message MIME
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = email
    msg['Subject'] = subject

    # Ajouter le corps du message
    msg.attach(MIMEText(message, 'plain'))

    try:
        # Établir une connexion SMTP
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(smtp_username, smtp_password)

        # Envoyer l'e-mail
        server.sendmail(sender_email, email, msg.as_string())

        # Fermer la connexion SMTP
        server.quit()

        print(f"L'e-mail de confirmation a été envoyé à {email}")
    except Exception as e:
        print(f"Erreur lors de l'envoi de l'e-mail de confirmation à {email}: {str(e)}")
