from flask import Blueprint, session

bp = Blueprint("auth__status_bp", __name__,  url_prefix="/api")
@bp.get("/auth-status")
def auth_status():
    user_id = session.get("user_id")
    if user_id:
        return {"logged_in": True, "user_id": user_id}, 200
    else:
        return {"logged_in": False}, 200