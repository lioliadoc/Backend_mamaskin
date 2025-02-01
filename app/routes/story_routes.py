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

@bp.get("")
def get_all_stories():
    stories = db.session.query(Story).all()
    return {"stories": [story.to_dict() for story in stories]}

@bp.get("/<story_id>")
def get_story_by_id(story_id):
    story = validate_model(Story, story_id)
    return story.to_dict(), 200 

@bp.put("/<story_id>/like")
def like_story(story_id):
    story = validate_model(Story, story_id)
    story.like_count += 1
    db.session.commit()
    return story.to_dict(), 200