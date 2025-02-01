from flask import Blueprint, redirect, url_for, session, flash
from flask_dance.contrib.google import google
from oauthlib.oauth2.rfc6749.errors import TokenExpiredError
from app.db import db
from app.models.user import User
from flask import session

bp = Blueprint("google_auth_bp", __name__,  url_prefix="/login")

@bp.route("/force-login")
def force_login():
    session.clear()  # Clear all session data
    return redirect(url_for("google.login"))

@bp.route("/google/authorized", endpoint="google_login_callback")
def google_login_callback():
    # 1. Check if user is successfully authorized
    resp = google.get("/oauth2/v2/userinfo")
    if not resp.ok:
        flash("Failed to fetch user info from Google.", "error")
        return redirect(url_for("home"))  

    # 2. Parse the user info
    user_info = resp.json()
    google_id = user_info["id"]
    name = user_info.get("name", "")
    email = user_info.get("email", "")

    # 3. Look for existing user by google_id
    user = User.query.filter_by(google_id=google_id).first()

    if not user:
        # Create new user if they don't exist
        user = User(google_id=google_id, name=name, email=email)
        db.session.add(user)
        db.session.commit()

    # 4. "Log in" the user
    # Typically you'd store user.id in session:
    session["user_id"] = user.id

    flash("You have successfully logged in via Google!", "success")
    return redirect(url_for("home"))  # redirect to your main or dashboard page

@bp.route("/protected")
def protected():
    """
    Route that requires a valid token. If the token is missing or expired,
    this forces the user to re-authenticate by redirecting to Google.
    """
    # 1. Check if google.authorized is True
    if not google.authorized:
        flash("Please log in with Google first. No valid token found.")
        return redirect(url_for("google.login"))
        # "google.login" is the Flask-Dance route that starts the OAuth flow

    try:
        # 2. Attempt to call a Google API endpoint using the existing token
        resp = google.get("/oauth2/v2/userinfo")
        if not resp.ok:
            flash("Could not fetch user info. Please re-authenticate.")
            return redirect(url_for("google.login"))

        user_info = resp.json()
        # Optional: You can do more logic here, such as returning data or rendering a template
        return f"This is a protected route. Hello, {user_info['name']}!"
    except TokenExpiredError:
        # 3. If the token is explicitly expired, we catch the exception
        flash("Your token has expired. Please log in again.")
        return redirect(url_for("google.login"))


