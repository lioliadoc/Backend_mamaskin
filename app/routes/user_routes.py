from flask import Blueprint, abort, make_response, Response, request
import requests
from app.models.user import User
from .route_utilities import validate_model, create_model
from ..db import db
import os

bp = Blueprint("user_bp", __name__, url_prefix="/users")

@bp.get("/<user_id>")
def get_user_by_id(user_id):
    user = validate_model(User, user_id)
    return user.to_dict(), 200

@bp.get("/<user_id>/stories")
def get_user_stories(user_id):
    user = validate_model(User, user_id)
    return {"stories": [story.to_dict() for story in user.stories]}, 200

@bp.post("")
def create_user():
    return create_model(User, request.json)

@bp.put("/<user_id>")
def update_user(user_id):
    user = validate_model(User, user_id)
    user.update(request.json)
    db.session.commit()
    return user.to_dict(), 200
