from ..db import db
from sqlalchemy.orm import Mapped, mapped_column, relationship

class Condition(db.Model):
    __tablename__ = 'condition'
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]
    description: Mapped[str]
    references: Mapped[str]
    symptoms: Mapped[list["Symptom"]] = relationship(back_populates="condition")

    def __repr__(self):
        return f"<Condition {self.name}>"
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "references": self.references
        }
    @classmethod
    def from_dict(cls, data):
        return cls(
            name=data["name"],
            description=data["description"],
            references=data["references"]
        )