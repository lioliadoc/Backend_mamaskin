from flask import Blueprint, redirect, url_for, session, current_app

bp = Blueprint("google_auth_bp", __name__, url_prefix="/login")

@bp.route("/login") 
def login(): 
    google = current_app.extensions["authlib"].google
    return google.authorize_redirect(url_for("google_auth_bp.google_login_callback", _external=True))

@bp.route("/google/authorized", endpoint="google_login_callback")
def google_login_callback():
    google = current_app.extensions["authlib"].google
    user_info = google.authorize_access_token()
    
    google_id = user_info.get("id_token")
    name = user_info.get("name", "")
    email = user_info.get("email", "")

    session["logged_in"] = True
    session["google_id"] = google_id
    session["name"] = name
    session["email"] = email

    return redirect("https://mamaskin-frontend-afbb848647f2.herokuapp.com/stories")




