from flask import Blueprint, redirect, url_for, session, flash
from flask_dance.contrib.google import google
from oauthlib.oauth2.rfc6749.errors import TokenExpiredError

bp = Blueprint("google_auth_bp", __name__, url_prefix="/login")


@bp.route("/google/authorized", endpoint="google_login_callback")
def google_login_callback():
    print("Google authorized!", google.authorized)
    if not google.authorized:
        return redirect(url_for("google.login"))

    token = google.token
    if not token:
        print("OAuth token is missing!")
        return "OAuth token is missing!", 400

    resp = google.get("/oauth2/v2/userinfo")
    if resp.status_code == 401:
        print("Token expired, refreshing...")
        del google.token  # Remove the invalid token
        return redirect(url_for("google.login"))  # Re-authenticate
    if not resp.ok:
        print("Failed to fetch user info from Google.", f"Error: {resp.status_code}, Response: {resp.text}" )

        return redirect("https://mamaskin-frontend-afbb848647f2.herokuapp.com/stories")

    user_info = resp.json()
    google_id = user_info.get("id")
    name = user_info.get("name", "")
    email = user_info.get("email", "")

    session["logged_in"] = True
    session["google_id"] = google_id
    session["name"] = name
    session["email"] = email

    print("You have successfully logged in via Google!", "success")
    return redirect("https://mamaskin-frontend-afbb848647f2.herokuapp.com/stories")




