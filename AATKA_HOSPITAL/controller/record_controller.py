from flask import Blueprint, request, jsonify
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.medical_record import MedicalRecord

bp = Blueprint('records', __name__, url_prefix='/records')

@bp.route('/patient/<int:patient_id>', methods=['GET'])
def get_patient_records(patient_id):
    records = MedicalRecord.query.filter_by(patient_id=patient_id).all()
    record_list = [{'record_id': rec.record_id, 'doctor_id': rec.doctor_id, 'datetime': str(rec.record_datetime), 'diagnosis': rec.diagnosis, 'treatment': rec.treatment, 'medications': rec.medications, 'notes': rec.notes} for rec in records]
    return jsonify(record_list), 200

@bp.route('/add', methods=['POST'])
def add_medical_record():
    data = request.get_json()
    patient_id = data.get('patient_id')
    doctor_id = data.get('doctor_id')
    diagnosis = data.get('diagnosis')
    treatment = data.get('treatment')
    medications = data.get('medications')
    notes = data.get('notes')

    if not all([patient_id, doctor_id]):
        return jsonify({'message': 'Patient ID and Doctor ID are required'}), 40