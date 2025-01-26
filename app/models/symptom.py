from ..db import db
from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

class Symptom(db.Model):
    __tablename__ = 'symptom'
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]
    condition_id:Mapped[int] = mapped_column(ForeignKey('condition.id'))
    condition: Mapped["Condition"] = relationship(back_populates="symptoms")

    # return a string representation of a Symptom object
    def __repr__(self):
        return f"<Symptom {self.name}>"
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "condition_id": self.condition_id
        }
    
    @classmethod
    def from_dict(cls, data):
        return cls(
            name=data["name"],
            condition_id=data["condition_id"]
        )   