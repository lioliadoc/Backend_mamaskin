import pytest
from app import create_app
from app.db import db
from flask.signals import request_finished
from dotenv import load_dotenv
import os
from app.models.condition import Condition
from app.models.story import Story
from app.models.user import User
from app.models.symptom import Symptom

load_dotenv()

@pytest.fixture
def app():
    test_config = {
        "TESTING": True,
        "SQLALCHEMY_DATABASE_URI": os.environ.get('SQLALCHEMY_TEST_DATABASE_URI')
    }
     
    app = create_app(test_config)

    @request_finished.connect_via(app)
    def expire_session(sender, response, **extra):
        db.session.remove()

    with app.app_context():
        db.create_all()
        yield app
    
    with app.app_context():
        db.drop_all()

@pytest.fixture
def client(app):
    return app.test_client()
    
@pytest.fixture
def condition_fixture(app):
    """
    Creates a test Condition in the database.
    """
    with app.app_context():
        condition = Condition(
        name="Test Condition",
        description="A test description",
        references="Some references"
    )
        db.session.add(condition)
        db.session.commit()
        yield condition
        # Clean up after test:
        db.session.delete(condition)
        db.session.commit()

@pytest.fixture
def get_condition_by_id_response(client, condition_fixture):
    """
    Uses the test client to request GET /conditions/<condition_id>
    for the condition created in condition_fixture.
    """
    # Build the URL using the condition id
    response = client.get(f"/conditions/{condition_fixture.id}")
    return response

@pytest.fixture
def condition_search_fixture(app):
    """
    Creates a test Condition and associates it with a Symptom.
    """
    with app.app_context():
        condition = Condition(name="Rash Condition")
        # Create a Symptom instance (assumes Symptom model has a 'name' field)
        symptom = Symptom(name="rash")
        # Link the symptom to the condition. (Assumes Condition.symptoms is appendable.)
        condition.symptoms.append(symptom)
        db.session.add_all([condition, symptom])
        db.session.commit()
        yield condition
        # Cleanup: Remove the condition and symptom from the DB.
        db.session.delete(condition)
        db.session.delete(symptom)
        db.session.commit()

@pytest.fixture
def get_condition_search_response(client, condition_search_fixture):
    """
    Uses the test client to call GET /conditions/search?symptom=cough.
    """
    response = client.get("/conditions/search?symptom=rash")
    return response

@pytest.fixture
def user_fixture(app):
    with app.app_context():
        user = User(
            google_id="123456789",
            name="Test User",
            email="testuser@gmail.com"
        )
        db.session.add(user)
        db.session.commit()
        yield user
        
        db.session.delete(user)
        db.session.commit()


@pytest.fixture
def get_user_by_id_response(client, user_fixture):
    response = client.get(f"/users/{user_fixture.id}")
    return response


@pytest.fixture
def user_with_stories_fixture(app):
    with app.app_context():
        user = User(google_id="111", name="User With Story", email="story@example.com")
        db.session.add(user)
        db.session.commit()

        story = Story(name="A story", text="content", user_id=user.id)
        db.session.add(story)
        db.session.commit()

        yield user

        # First delete the story, then delete the user:
        db.session.delete(story)
        db.session.delete(user)
        db.session.commit()


@pytest.fixture
def get_user_stories_response(client, user_with_stories_fixture):
    response = client.get(f"/users/{user_with_stories_fixture.id}/stories")
    return response


@pytest.fixture
def create_user_response(client):
    """
    Makes a POST request to /users to create a new user.
    Adjust the JSON payload as needed.
    """
    user = {
        "google_id": "111222333",
        "name": "New User",
        "email": "newuser@example.com"
    }
    response = client.post("/users" , json=user)
    return response


@pytest.fixture
def story_fixture(app, user_fixture):
    """
    Creates a single Story in the database, associated with user_fixture.
    """
    with app.app_context():
        story = Story(
            name="My First Story",
            text="This is the text of the story.",
            user_id=user_fixture.id
        )
        db.session.add(story)
        db.session.commit()
        yield story

        # Cleanup
        db.session.delete(story)
        db.session.commit()

@pytest.fixture
def multiple_stories_fixture(app, user_fixture):
    """
    Creates multiple Stories (2) for testing the GET /stories list endpoint.
    """
    with app.app_context():
        story1 = Story(
            name="Story One",
            text="Lorem ipsum dolor sit amet.",
            user_id=user_fixture.id
        )
        story2 = Story(
            name="Story Two",
            text="Another fascinating tale.",
            user_id=user_fixture.id
        )
        db.session.add_all([story1, story2])
        db.session.commit()
        yield [story1, story2]

        # Cleanup
        db.session.delete(story1)
        db.session.delete(story2)
        db.session.commit()

@pytest.fixture
def create_story_response(client, user_fixture):
    """
    POST /stories to create a new Story. Returns the response.
    """
    story = {
        "name": "Created Story",
        "text": "Created text content",
        "user_id": user_fixture.id,
        "like_count": 0
    }
    response = client.post("/stories", json=story)
    return response
