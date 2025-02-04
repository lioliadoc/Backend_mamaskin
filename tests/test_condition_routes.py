from app.models.condition import Condition
from app.models.symptom import Symptom
from app import db, create_app
import pytest


def test_get_condition_by_id(get_condition_by_id_response):
    response = get_condition_by_id_response
    assert response.status_code == 200
    data = response.get_json()
    assert "name" in data
    assert data["name"] == "Test Condition"
    assert data["description"]=="A test description"
    assert data["references"]=="Some references"
 
def test_get_all_conditions(client, app):
    with app.app_context():
         condition1 = Condition(name="Condition One", description="Desc one", references="Ref one")
         condition2 = Condition(name="Condition Two", description="Desc two", references="Ref two")
         db.session.add_all([condition1, condition2])
         db.session.commit()
         id1 = condition1.id
         id2 = condition2.id
    
    response = client.get("/conditions")
    assert response.status_code == 200
    data = response.get_json()
    condition_ids = [condition["id"] for condition in data]
    assert id1 in condition_ids
    assert id2 in condition_ids

def test_get_condition_by_symptom(client, app):
    with app.app_context():
        condition1 = Condition(name="Condition One", description="Desc one", references="Ref one")
        condition2 = Condition(name="Condition Two", description="Desc two", references="Ref two")
        db.session.add_all([condition1, condition2])
        db.session.commit()
        id1 = condition1.id
        id2 = condition2.id
        symptom = Symptom(name="Symptom One", condition_id=id1)
        db.session.add(symptom)
        db.session.commit()
    
    response = client.get("/conditions/search?symptom=Symptom One")
    assert response.status_code == 200
    data = response.get_json()
    assert "conditions" in data
    conditions = data["conditions"]
    assert len(conditions) == 1
    assert conditions[0]["condition_name"] == "Condition One"

def test_search_condition_no_match(client):
    response = client.get("/conditions/search?symptom=nonexistent")
    assert response.status_code == 200

    data = response.get_json()
    assert "message" in data
    assert data["message"] == "No matching conditions found."


def test_search_condition_without_symptom(client):
    response = client.get("/conditions/search")
    assert response.status_code == 400

    data = response.get_json()
    assert "error" in data
    assert data["error"] == "Please provide a symptom to search for."
