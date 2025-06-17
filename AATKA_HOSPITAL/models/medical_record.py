from AATKA_HOSPITAL import db
from sqlalchemy.orm import relationship

class MedicalRecord(db.Model):
    __tablename__ = 'MedicalRecords'
    record_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id'), nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id'), nullable=False)
    record_datetime = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    diagnosis = db.Column(db.Text)
    treatment = db.Column(db.Text)
    medications = db.Column(db.Text)
    notes = db.Column(db.Text)
    created_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    updated_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())

    # Relationships
    patient = relationship('Patient', foreign_keys=[patient_id], primaryjoin='MedicalRecord.patient_id == Patient.patient_id', backref=db.backref('medical_records'))
    doctor = relationship('Doctor', foreign_keys=[doctor_id], primaryjoin='MedicalRecord.doctor_id == Doctor.doctor_id', backref=db.backref('medical_records'))

    def __repr__(self):
        return f"<MedicalRecord {self.record_id} - Patient: {self.patient_id}, Doctor: {self.doctor_id}>"