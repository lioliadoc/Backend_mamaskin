from flask import Flask, redirect
from .models.condition import Condition
from .models.symptom import Symptom
from .models.story import Story
from .routes.google_auth_route import google_login_callback
from .routes.google_auth_route import bp as google_auth_bp
from .routes.user_routes import bp as user_bp
from .routes.condition_routes import bp as condition_bp
from .routes.story_routes import bp as story_bp
from flask_dance.contrib.google import make_google_blueprint
from .routes.auth_status_route import bp as auth_status_bp
from flask_cors import CORS
from .db import db, migrate
from dotenv import load_dotenv
import os
from flask import Flask, render_template

load_dotenv()

def create_app(config=None):
    app = Flask(__name__, static_folder='static')
    # CORS(app)
    CORS(app, supports_credentials=True, origins=["http://localhost:5173"])

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI')

    app.secret_key = "your_generated_random_string"
    if config:
        app.config.update(config)

    db.init_app(app)
    migrate.init_app(app,db)

    google_bp = make_google_blueprint(
    client_id=os.environ["GOOGLE_OAUTH_CLIENT_ID"],
    client_secret=os.environ["GOOGLE_OAUTH_CLIENT_SECRET"],
    scope=["profile", "email"],  
    redirect_to="google_auth_bp.google_login_callback")

    app.register_blueprint(user_bp)
    app.register_blueprint(condition_bp)
    app.register_blueprint(story_bp)
    app.register_blueprint(google_auth_bp)
    app.register_blueprint(google_bp, url_prefix="/login")
    app.register_blueprint(auth_status_bp)
    
    @app.route("/", endpoint="home")
    def redirect_frontend():
        return redirect("http://localhost:5173/")
    
    print(app.static_folder)
    
    return app