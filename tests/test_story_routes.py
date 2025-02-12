import pytest
from app.models.story import Story
from app.db import db

def test_create_story_success(create_story_response):

    response = create_story_response
    assert response.status_code == 201  
    data = response.get_json()
   
    assert "id" in data
    assert data["name"] == "Created Story"
    assert data["text"] == "Created text content"
    assert data["like_count"] == 0


def test_get_all_stories(client, multiple_stories_fixture):
    response = client.get("/stories")
    assert response.status_code == 200
    data = response.get_json()
    assert "stories" in data
    stories = data["stories"]
    assert len(stories) >= 2
    created_names = [s.name for s in multiple_stories_fixture]
    returned_names = [s["name"] for s in stories]
    for name in created_names:
        assert name in returned_names


def test_get_story_by_id(client, story_fixture):
    response = client.get(f"/stories/{story_fixture.id}")
    assert response.status_code == 200
    data = response.get_json()
   
    assert data["id"] == story_fixture.id
    assert data["name"] == story_fixture.name
    assert data["text"] == story_fixture.text
    assert data["like_count"] == story_fixture.like_count


def test_like_story(client, story_fixture):
    old_like_count = story_fixture.like_count
    response = client.put(f"/stories/{story_fixture.id}/like")
    assert response.status_code == 200
    updated_data = response.get_json()
    assert updated_data["like_count"] == old_like_count + 1

    