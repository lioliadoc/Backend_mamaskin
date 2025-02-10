from flask import Blueprint, redirect, url_for, session, flash
from flask_dance.contrib.google import google
from oauthlib.oauth2.rfc6749.errors import TokenExpiredError

bp = Blueprint("google_auth_bp", __name__, url_prefix="/login")

@bp.route("/force-login")
def force_login():
    session.clear()
    @after_this_request
    def after_redirect(response):
        google_login_callback()
        return response
    
    return redirect(url_for("google.login"))

@bp.route("/google/authorized", endpoint="google_login_callback")
def google_login_callback():
    resp = google.get("/oauth2/v2/userinfo")
    if not resp.ok:
        flash("Failed to fetch user info from Google.", "error")
        return redirect("https://mamaskin-frontend-afbb848647f2.herokuapp.com/stories")

    user_info = resp.json()
    google_id = user_info.get("id")
    name = user_info.get("name", "")
    email = user_info.get("email", "")

    session["logged_in"] = True
    session["google_id"] = google_id
    session["name"] = name
    session["email"] = email

    flash("You have successfully logged in via Google!", "success")
    return redirect("https://mamaskin-frontend-afbb848647f2.herokuapp.com/stories")

@bp.route("/protected")
def protected():
    if not google.authorized:
        flash("Please log in with Google first. No valid token found.")
        return redirect(url_for("google.login"))

    try:
        resp = google.get("/oauth2/v2/userinfo")
        if not resp.ok:
            flash("Could not fetch user info. Please re-authenticate.")
            return redirect(url_for("google.login"))

        user_info = resp.json()
        return f"This is a protected route. Hello, {user_info['name']}!"
    except TokenExpiredError:
        flash("Your token has expired. Please log in again.")
        return redirect(url_for("google.login"))



