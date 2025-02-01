from ..db import db
from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column, relationship
import datetime

class Story(db.Model):
    __tablename__ = 'story'
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]
    text: Mapped[str]
    created_at: Mapped[datetime.datetime] = mapped_column(server_default=func.now())
    like_count: Mapped[int] = mapped_column(server_default="0")
    user_id: Mapped[int] = mapped_column(ForeignKey('users.id', ondelete="CASCADE"),name="fk_story_user_id")
    
    def __repr__(self):
        return f"<Story {self.name}>"
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "text": self.text,
            "created_at": self.created_at,
            "like_count": self.like_count
        }
    @classmethod
    def from_dict(cls, data):
        return cls(
            name=data["name"],
            text=data["text"],
            user_id=data["user_id"],
            like_count=data["like_count"]
        )

