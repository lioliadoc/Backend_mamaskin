from flask import Blueprint, abort, make_response, Response, request, url_for
from sqlalchemy import or_
import requests
from app.models.symptom import Symptom
from app.models.condition import Condition
from .route_utilities import validate_model, create_model
from ..db import db
import os

bp = Blueprint("condition_bp", __name__, url_prefix="/conditions")

@bp.get("")
def get_all_conditions():
    conditions = db.session.query(Condition).all()
    conditions_list = [condition.to_dict() for condition in conditions]
    return conditions_list, 200

@bp.get("/<condition_id>")
def get_condition_by_id(condition_id):
    condition = validate_model(Condition, condition_id) 
    return condition.to_dict(), 200


@bp.get("/search")
def get_condition_by_symptom():
    
    symptom_query = request.args.get("symptom", "").strip()
    if not symptom_query:
        return {"error": "Please provide a symptom to search for."}, 400
    
    words = symptom_query.split()

    conditions = (
        db.session.query(Condition)
        .join(Condition.symptoms)
        .filter(
            or_(
                *[Symptom.name.ilike(f"%{word}%") for word in words])
            )
        )
    matching_conditions = conditions.all()
    
    results = []
    for condition in matching_conditions:
        results.append({
            "id": condition.id,
            "condition_name": condition.name,
            "description": condition.description,
            "references": condition.references,
            "requires_healthcare_provider": "Yes" if condition.requires_healthcare_provider else "No"
        })

    if not results:
        return {"message": "No matching conditions found."}, 200

    return {"conditions": results}, 200

@bp.get("/<condition_id>/images")
def get_condition_images(condition_id):
    image_urls = [
        url_for('static', filename=f'images/conditions/{condition_id}_1.jpg', _external=True),
        url_for('static', filename=f'images/conditions/{condition_id}_2.jpg', _external=True)
    ]
    return {"images": image_urls}, 200