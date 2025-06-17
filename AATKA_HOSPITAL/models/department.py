from AATKA_HOSPITAL import db
from sqlalchemy import Column, Integer, String, TIMESTAMP, Text
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

class Department(db.Model):
    __tablename__ = 'departments'
    department_id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), unique=True, nullable=False)
    description = Column(Text)
    created_at = Column(TIMESTAMP, default=func.current_timestamp())
    updated_at = Column(TIMESTAMP, default=func.current_timestamp(), onupdate=func.current_timestamp())

    doctors = relationship('Doctor', back_populates='department') # Relationship with Doctor

    def __repr__(self):
        return f'<Department {self.name}>'
