from ..db import db
from sqlalchemy.orm import Mapped, mapped_column, relationship

class Condition(db.Model):
    __tablename__ = 'condition'
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]
    description: Mapped[str]
    references: Mapped[str]
    requires_healthcare_provider: Mapped[bool] = mapped_column(db.Boolean, default=False, nullable=False)
    symptoms: Mapped[list["Symptom"]] = relationship(back_populates="condition")

    def __repr__(self):
        return f"<Condition {self.name}>"
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "references": self.references,
            "requires_healthcare_provider": "Yes" if self.requires_healthcare_provider else "No"
    }
    
    @classmethod
    def from_dict(cls, data):
        rhp = data.get("requires_healthcare_provider", False)
        if isinstance(rhp, str):
            rhp = True if rhp.strip().lower() == "yes" else False
        return cls(
            name=data["name"],
            description=data["description"],
            references=data["references"],
            requires_healthcare_provider=rhp
        )