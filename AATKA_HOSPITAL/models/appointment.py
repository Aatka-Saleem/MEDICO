from AATKA_HOSPITAL import db
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Integer, String, Enum, DateTime, ForeignKey, Date, Text
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin


class Appointment(db.Model):
    __tablename__ = 'appointments'
    appointment_id = Column(Integer, primary_key=True)
    patient_id = Column(Integer, ForeignKey('patients.patient_id', ondelete='CASCADE'), nullable=False)
    doctor_id = Column(Integer, ForeignKey('doctors.doctor_id', ondelete='CASCADE'), nullable=False)
    appointment_datetime = Column(DateTime, nullable=False)
    reason = Column(Text)
    status = Column(Enum('pending', 'scheduled', 'completed', 'cancelled'), default='pending')
    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, server_default=func.now(), onupdate=func.now())

    patient = relationship('Patient', back_populates='appointments', foreign_keys=[patient_id])
    doctor = relationship('Doctor', back_populates='appointments', foreign_keys=[doctor_id])

    def __repr__(self):
        return (f"<Appointment(id={self.appointment_id}, "
                f"patient_id={self.patient_id}, "
                f"doctor_id={self.doctor_id}, "
                f"datetime={self.appointment_datetime}, "
                f"status='{self.status}')>")
