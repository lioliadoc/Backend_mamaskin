from flask import Blueprint, abort, make_response, Response, request
import requests
from app.models.user import User
# from .route_utilities import validate_model, create_model
from ..db import db
import os

bp = Blueprint("user_bp", __name__, url_prefix="/users")



