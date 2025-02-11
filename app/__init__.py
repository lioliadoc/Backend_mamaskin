from flask import Flask, redirect, session
from datetime import timedelta
from flask import Flask, render_template
from .models.condition import Condition
from .models.symptom import Symptom
from .models.story import Story
from .routes.google_auth_route import google_login_callback
from .routes.google_auth_route import bp as google_auth_bp
from .routes.user_routes import bp as user_bp
from .routes.condition_routes import bp as condition_bp
from .routes.story_routes import bp as story_bp
# from flask_dance.contrib.google import make_google_blueprint
from .routes.auth_status_route import bp as auth_status_bp
from authlib.integrations.flask_client import OAuth
from flask_cors import CORS
from .db import db, migrate
from dotenv import load_dotenv
import os


load_dotenv()

def create_app(config=None):
    app = Flask(__name__, static_folder='static')
    CORS(app, supports_credentials=True, origins=["https://mamaskin-frontend-afbb848647f2.herokuapp.com"])

    app.secret_key = "mamaskin_secret_key"
    
    app.config['SESSION_COOKIE_SAMESITE'] = 'None'  
    app.config['SESSION_COOKIE_SECURE'] = True
    # app.config['SESSION_COOKIE_DOMAIN'] = ".herokuapp.com"
    app.config["SESSION_TYPE"] = "filesystem" 
    app.config["PERMANENT_SESSION_LIFETIME"] = timedelta(days=7) 
    app.config["SESSION_PERMANENT"] = True

    # app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('SQLALCHEMY_DATABASE_URI')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    database_url = os.environ.get('DATABASE_URL')
    if database_url.startswith('postgres://'):
        database_url = database_url.replace('postgres://', 'postgresql://', 1)

    app.config['SQLALCHEMY_DATABASE_URI'] = database_url


    db.init_app(app)
    migrate.init_app(app,db)


    print ("GOOGLE_OAUTH_CLIENT_ID", os.environ["GOOGLE_OAUTH_CLIENT_ID"])
    # google_bp = make_google_blueprint(
    # client_id=os.environ["GOOGLE_OAUTH_CLIENT_ID"],
    # client_secret=os.environ["GOOGLE_OAUTH_CLIENT_SECRET"],
    # scope=[
    #     "https://www.googleapis.com/auth/userinfo.email",
    #     "https://www.googleapis.com/auth/userinfo.profile",
    #     "openid"
    # ],  
    # redirect_to="google_auth_bp.google_login_callback")

    app.register_blueprint(user_bp)
    app.register_blueprint(condition_bp)
    app.register_blueprint(story_bp)
    app.register_blueprint(google_auth_bp)
    # app.register_blueprint(google_bp, url_prefix="/login")
    app.register_blueprint(auth_status_bp)
    
    oauth = OAuth(app) 
    google = oauth.register( name="google", 
                            client_id=os.environ["GOOGLE_OAUTH_CLIENT_ID"], 
                            client_secret=os.environ["GOOGLE_OAUTH_CLIENT_SECRET"], 
                            access_token_url="https://oauth2.googleapis.com/token", 
                            access_token_params=None, authorize_url="https://accounts.google.com/o/oauth2/auth", 
                            authorize_params=None, api_base_url="https://www.googleapis.com/oauth2/v2/", 
                            userinfo_endpoint="https://www.googleapis.com/oauth2/v3/userinfo", 
                            client_kwargs={"scope": "openid https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile"})
    app.extensions["authlib"] = oauth
    return app