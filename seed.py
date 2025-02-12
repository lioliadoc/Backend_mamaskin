import os
from app import create_app, db
from app.models.condition import Condition
from app.models.symptom import Symptom
from seed_data import conditions_data, symptoms_data

def seed_data():
    condition_map = {} 
    for cond_info in conditions_data:
        name = cond_info["name"]
        
        existing = Condition.query.filter_by(name=name).first()
        if existing:
            existing.description = cond_info["description"]
            existing.references = cond_info["references"]
            existing.requires_healthcare_provider = cond_info["requires_healthcare_provider"]
            condition_map[name] = existing
        else:
            new_condition = Condition(
                name=name,
                description=cond_info["description"],
                references=cond_info["references"],
                requires_healthcare_provider=cond_info["requires_healthcare_provider"]
            )
            db.session.add(new_condition)
            condition_map[name] = new_condition

    for sym_info in symptoms_data:
        name = sym_info["name"]
        condition_name = sym_info["condition_name"]

        cond_obj = condition_map.get(condition_name)
        if not cond_obj:
            print(f"No condition found with name '{condition_name}'. Skipping symptom '{name}'.")
            continue

        existing_symptom = Symptom.query.filter_by(name=name, condition_id=cond_obj.id).first()
        if existing_symptom:
            pass
        else:
            new_symptom = Symptom(
                name=name,
                condition_id=cond_obj.id
            )
            db.session.add(new_symptom)
   
    db.session.commit()
    print("Database seeded successfully!")

if __name__ == "__main__":
    app = create_app()  
    with app.app_context():
        seed_data()