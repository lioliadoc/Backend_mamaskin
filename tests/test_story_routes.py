import pytest
from app.models.story import Story
from app.db import db

def test_create_story_success(create_story_response):
    """
    Tests the POST /stories endpoint to ensure a story is created successfully.
    """
    response = create_story_response
    assert response.status_code == 201  # or 200, depending on your create_model logic
    data = response.get_json()
    # Ensure the returned data matches what we sent
    assert "id" in data
    assert data["name"] == "Created Story"
    assert data["text"] == "Created text content"
    assert data["like_count"] == 0


def test_get_all_stories(client, multiple_stories_fixture):
    """
    Tests GET /stories to ensure we can retrieve multiple stories.
    """
    # We already created multiple stories in the fixture
    response = client.get("/stories")
    assert response.status_code == 200
    data = response.get_json()
    assert "stories" in data
    stories = data["stories"]
    # We expect at least the 2 stories created by multiple_stories_fixture
    assert len(stories) >= 2
    # Optionally check names of created stories
    created_names = [s.name for s in multiple_stories_fixture]
    returned_names = [s["name"] for s in stories]
    for name in created_names:
        assert name in returned_names


def test_get_story_by_id(client, story_fixture):
    """
    Tests GET /stories/<story_id> to retrieve a single story by ID.
    """
    response = client.get(f"/stories/{story_fixture.id}")
    assert response.status_code == 200
    data = response.get_json()
    # Confirm the story we get matches the fixture
    assert data["id"] == story_fixture.id
    assert data["name"] == story_fixture.name
    assert data["text"] == story_fixture.text
    assert data["like_count"] == story_fixture.like_count


def test_like_story(client, story_fixture):
    """
    Tests PUT /stories/<story_id>/like to increment the story's like_count.
    """
    old_like_count = story_fixture.like_count
    response = client.put(f"/stories/{story_fixture.id}/like")
    assert response.status_code == 200
    updated_data = response.get_json()
    # like_count should be old_like_count + 1
    assert updated_data["like_count"] == old_like_count + 1

    