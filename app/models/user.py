from ..db import db
from sqlalchemy.orm import Mapped, mapped_column, relationship

class User(db.Model):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    google_id: Mapped[str] = mapped_column(unique=True, nullable=False)
    name: Mapped[str] 
    email: Mapped[str] = mapped_column(unique=True, nullable=False)
    

    def __repr__(self):
        return f"<User {self.name}>"
    
    def to_dict(self):
        return {
            "id": self.id,
            "google_id": self.google_id,
            "email": self.email,
            "name": self.name
        }
    @classmethod
    def from_dict(cls, data):
        return cls(
            google_id=data["google_id"],
            email=data["email"],
            name=data["name"]
        )

