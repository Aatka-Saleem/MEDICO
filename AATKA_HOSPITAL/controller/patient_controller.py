
from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_required, current_user
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.patient import Patient
from AATKA_HOSPITAL.models.appointment import Appointment
from AATKA_HOSPITAL.models.medical_record import MedicalRecord
from AATKA_HOSPITAL.models.doctor import Doctor  # Import the Doctor model
from datetime import datetime  # Import datetime


bp = Blueprint('patient', __name__, url_prefix='/patient')


@bp.before_request
@login_required
def login_check():
    if current_user.role != 'patient':
        flash('You do not have permission to access this area.', 'danger')
        return redirect(url_for('main.index'))  # Corrected to 'main.index'


@bp.route('/dashboard')
def dashboard():
    """Patient dashboard view."""
    # Get the patient object
    patient = Patient.query.filter_by(patient_id=current_user.patient_id_fk).first()

    if not patient:
        flash('Patient profile incomplete. Please complete your profile.', 'warning')
        return redirect(url_for('auth.patient_details_form', user_id=current_user.user_id))

    # Get upcoming appointments for the patient, ordered by date
    appointments = Appointment.query.filter(
        Appointment.patient_id == patient.patient_id,
        Appointment.appointment_datetime >= datetime.now()  # Use datetime.now()
    ).order_by(Appointment.appointment_datetime).all()

    # Get medical records for the patient, ordered by date
    medical_records = MedicalRecord.query.filter_by(patient_id=patient.patient_id).order_by(
        MedicalRecord.record_datetime.desc()).all()

    return render_template('patient/dashboard.html', patient=patient, appointments=appointments,
                           medical_records=medical_records)



@bp.route('/book_appointment', methods=['GET', 'POST'])
def book_appointment():
    """View for booking a new appointment."""
    if request.method == 'POST':
        doctor_id = request.form['doctor_id']
        appointment_datetime_str = request.form['appointment_datetime']  # Get as string
        reason = request.form['reason']

        # Get the patient object
        patient = Patient.query.filter_by(patient_id=current_user.patient_id_fk).first()
        if not patient:
            flash('Patient profile incomplete. Please complete your profile.', 'warning')
            return redirect(url_for('auth.patient_details_form', user_id=current_user.user_id))

        # Convert appointment_datetime_str to datetime object.
        try:
            appointment_datetime = datetime.strptime(appointment_datetime_str, '%Y-%m-%dT%H:%M')
        except ValueError:
            flash('Invalid date and time format. Please use the format YYYY-MM-DD HH:MM', 'danger')
            return render_template('patient/book_appointment.html', doctors=Doctor.query.all())
        # Get the doctor object.
        doctor = Doctor.query.get(doctor_id)
        if not doctor:
            flash('Invalid doctor selected.', 'danger')
            return render_template('patient/book_appointment.html', doctors=Doctor.query.all())

        new_appointment = Appointment(
            patient_id=patient.patient_id,
            doctor_id=doctor_id,
            appointment_datetime=appointment_datetime,
            reason=reason,
            status='pending'  # Set initial status
        )
        db.session.add(new_appointment)
        db.session.commit()
        flash('Appointment request submitted successfully!', 'success')
        return redirect(url_for('patient.dashboard'))  # Redirect to dashboard

    # if it is a get request
    doctors = Doctor.query.all()
    return render_template('patient/book_appointment.html', doctors=doctors)


@bp.route('/view_medical_records')
def view_medical_records():
    """View for viewing medical records."""
    # Get the patient object
    patient = Patient.query.filter_by(patient_id=current_user.patient_id_fk).first()
    if not patient:
        flash('Patient profile incomplete. Please complete your profile.', 'warning')
        return redirect(url_for('auth.patient_details_form', user_id=current_user.user_id))

    # Get medical records for the patient, ordered by date
    medical_records = MedicalRecord.query.filter_by(patient_id=patient.patient_id).order_by(
        MedicalRecord.record_datetime.desc()).all()
    return render_template('patient/view_medical_records.html', medical_records=medical_records)



