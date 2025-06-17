from AATKA_HOSPITAL import db
from sqlalchemy import ForeignKey, Column, Integer, DateTime, Text, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

class Patient(db.Model):
    __tablename__ = 'patients'
    patient_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    date_of_birth = db.Column(db.Date)
    gender = db.Column(db.Enum('male', 'female', 'other'))
    contact_number = db.Column(db.String(20))
    address = db.Column(db.Text)
    email = db.Column(db.String(100), unique=True)
    created_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    updated_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())
    

    appointments = relationship('Appointment', back_populates='patient', foreign_keys='Appointment.patient_id')
    user = db.relationship('User', backref=db.backref('patient_profile', uselist=False)) # Removed this



    def __repr__(self):
        return f'<Patient {self.first_name} {self.last_name} {self.patient_id}>'
        