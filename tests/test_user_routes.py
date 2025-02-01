from app.models.user import User
from app.models.story import Story
from app import db, create_app
import pytest



def test_get_user_by_id(get_user_by_id_response):
    response = get_user_by_id_response
    assert response.status_code == 200
    user_data = response.get_json()
    assert user_data["google_id"] == "123456789"
    assert user_data["email"] == "testuser@gmail.com"
    assert user_data["name"] == "Test User"


def test_create_user(create_user_response):
    response = create_user_response
    assert response.status_code == 201  
    user_data = response.get_json()
    assert user_data["google_id"] == "111222333"
    # etc.

