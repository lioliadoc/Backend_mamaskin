from flask import Blueprint, session

bp = Blueprint("auth__status_bp", __name__, url_prefix="/api")

@bp.get("/auth-status")
def auth_status():
    if session.get("logged_in"):
        return {
            "logged_in": True,
            "google_id": session.get("google_id"),
            "name": session.get("name"),
            "email": session.get("email")
        }, 200
    else:
        return {"logged_in": False}, 200
