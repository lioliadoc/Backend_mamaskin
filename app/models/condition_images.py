from ..db import db
from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

class ConditionImages(db.Model):
    __tablename__ = 'condition_image_path'
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    path: Mapped[str]
    condition_id: Mapped[int] = mapped_column(ForeignKey('condition.id'))
    