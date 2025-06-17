from flask import Blueprint, render_template, url_for, redirect, flash, request
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.appointment import Appointment
from AATKA_HOSPITAL.models.patient import Patient
from AATKA_HOSPITAL.models.doctor import Doctor
from flask_login import login_required, current_user
from datetime import datetime # Import datetime

bp = Blueprint('appointment', __name__, url_prefix='/appointment')

@bp.route('/book', methods=['GET', 'POST'])
@login_required
def book_appointment():
    """Allows a logged-in patient to book a new appointment."""
    if current_user.role != 'patient':
        flash('You do not have permission to access this page.', 'danger')
        return redirect(url_for('main.index'))  # Redirect non-patients

    if request.method == 'POST':
        # Get form data
        doctor_id = request.form.get('doctor_id')
        appointment_datetime_str = request.form.get('appointment_datetime') # Changed
        reason = request.form.get('reason')

        # Server-side validation (ensure doctor_id and appointment_datetime are provided)
        if not doctor_id or not appointment_datetime_str: #changed
            flash('Please select a doctor and appointment date/time.', 'danger')
            return render_template('patient/book_appointment.html', doctors=Doctor.query.all())

        # Convert appointment_datetime to a datetime object (important for database)
        try:
            appointment_datetime = datetime.strptime(appointment_datetime_str, '%Y-%m-%dT%H:%M')  # Assumes the datetime-local format
        except ValueError:
            flash('Invalid date/time format.  Please use the format YYYY-MM-DD HH:MM', 'danger')
            return render_template('patient/book_appointment.html', doctors=Doctor.query.all())

        # Get the Doctor object
        doctor = Doctor.query.get(doctor_id)
        if not doctor:
            flash('Invalid doctor ID.', 'danger')
            return render_template('patient/book_appointment.html', doctors=Doctor.query.all())

        # Get the patient object.  Important for using the relationship.
        patient = Patient.query.filter_by(patient_id=current_user.patient_id_fk).first()

        if not patient:
            flash('Patient not found.  Please login again.', 'danger')
            return redirect(url_for('auth.login'))

        # Create the new appointment
        appointment = Appointment(
            patient=patient,  # Use the patient object
            doctor_id=doctor_id,
            appointment_datetime=appointment_datetime,
            reason=reason,
            status='pending'  # Set initial status
        )

        db.session.add(appointment)
        db.session.commit()
        flash('Appointment booked successfully!', 'success')
        return redirect(url_for('patient.dashboard'))  # Redirect to patient dashboard

    # If it's a GET request, render the form
    doctors = Doctor.query.all()
    return render_template('patient/book_appointment.html', doctors=doctors)

@bp.route('/<int:appointment_id>/update', methods=['GET', 'POST'])
@login_required
def update_appointment(appointment_id):
    """Allows a logged-in patient to update their existing appointment."""
    appointment = Appointment.query.get_or_404(appointment_id)

    # Ensure the current user is the patient who owns this appointment
    if appointment.patient_id != current_user.patient.patient_id:
        flash('You do not have permission to update this appointment.', 'danger')
        return redirect(url_for('main.index'))

    if request.method == 'POST':
        # Get updated form data
        doctor_id = request.form.get('doctor_id')
        appointment_datetime_str = request.form.get('appointment_datetime') #changex
        reason = request.form.get('reason')
        status = request.form.get('status') #added status


       # Server-side validation (ensure doctor_id and appointment_datetime are provided)
        if not doctor_id or not appointment_datetime_str: #changed
            flash('Please select a doctor and appointment date/time.', 'danger')
            return render_template('appointment/update_appointment.html', appointment=appointment, doctors=Doctor.query.all(), patients=Patient.query.all()) #added patients

        # Convert appointment_datetime to a datetime object
        try:
            appointment_datetime = datetime.strptime(appointment_datetime_str, '%Y-%m-%dT%H:%M')
        except ValueError:
            flash('Invalid date/time format.  Please use the format YYYY-MM-DD HH:MM', 'danger')
            return render_template('appointment/update_appointment.html', appointment=appointment, doctors=Doctor.query.all(), patients=Patient.query.all()) #added patients

        # Get the Doctor object
        doctor = Doctor.query.get(doctor_id)
        if not doctor:
            flash('Invalid doctor ID.', 'danger')
            return render_template('appointment/update_appointment.html', appointment=appointment, doctors=Doctor.query.all(), patients=Patient.query.all()) #added patients

        # Update the appointment object
        appointment.doctor_id = doctor_id
        appointment.appointment_datetime = appointment_datetime
        appointment.reason = reason
        appointment.status = status #update status

        db.session.commit()
        flash('Appointment updated successfully!', 'success')
        return redirect(url_for('patient.dashboard'))  # Redirect to patient dashboard

    # If it's a GET request, render the form with current appointment data
    doctors = Doctor.query.all()
    patients = Patient.query.all() #added patients
    return render_template('appointment/update_appointment.html', appointment=appointment, doctors=doctors, patients=patients) #added patients
