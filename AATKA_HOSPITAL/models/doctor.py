from AATKA_HOSPITAL import db
from sqlalchemy import ForeignKey, Column, Integer, String, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

class Doctor(db.Model):
    __tablename__ = 'doctors'
    doctor_id = Column(Integer, primary_key=True, autoincrement=True)
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    specialization = Column(String(100))
    department_id = Column(Integer, ForeignKey('departments.department_id'), nullable=True)  # Changed to department_id
    email = Column(String(100), unique=True)
    contact_number = Column(String(20))
    created_at = Column(TIMESTAMP, default=func.current_timestamp())
    updated_at = Column(TIMESTAMP, default=func.current_timestamp(), onupdate=func.current_timestamp())

    # Relationship to the User table (one-to-one)
    user = relationship('User', backref=db.backref('doctor_profile', uselist=False))
    appointments = relationship('Appointment', back_populates='doctor', foreign_keys='Appointment.doctor_id')
    department = relationship('Department', back_populates='doctors') #relationship with Department


    def __repr__(self):
        return f'<Doctor {self.first_name} {self.last_name} {self.doctor_id}>'
