from flask import Blueprint, abort, make_response, Response, request
from app.models.user import User
from app.models.story import Story
from .route_utilities import validate_model, create_model
from ..db import db
import os


bp = Blueprint("story_bp", __name__, url_prefix="/stories")

@bp.post("")
def create_story():
    return create_model(Story, request.json)