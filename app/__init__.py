from flask import Flask 
from .models.condition import Condition
from .models.symptom import Symptom
from .models.story import Story
from .routes.user_routes import bp as user_bp
from .routes.condition_routes import bp as condition_bp
from .routes.story_routes import bp as story_bp
# from .routes.symptom_routes import bp as symptom_bp
# from .models.condition_images import ConditionImages
from flask_cors import CORS
from .db import db, migrate
from dotenv import load_dotenv
import os

load_dotenv()

def create_app(config=None):
    app = Flask(__name__)
    CORS(app)

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI')

    if config:
        app.config.update(config)

    db.init_app(app)
    migrate.init_app(app,db)

    app.register_blueprint(user_bp)
    app.register_blueprint(condition_bp)
    app.register_blueprint(story_bp)

    
    return app