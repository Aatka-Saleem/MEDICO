from flask import Blueprint, render_template, url_for, redirect, flash, request
from flask_login import login_required, current_user
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.appointment import Appointment
from AATKA_HOSPITAL.models.patient import Patient  # Import the Patient model
from AATKA_HOSPITAL.models.medical_record import MedicalRecord  # Import MedicalRecord
from AATKA_HOSPITAL.models.doctor import Doctor  # Import Doctor
from AATKA_HOSPITAL.models.department import Department
from werkzeug.exceptions import NotFound  # Import NotFound


bp = Blueprint('doctor', __name__, url_prefix='/doctor')

@bp.before_request
def login_check():
    from flask import request  # Import request

    # Exclude the edit profile route from the login check
    if request.endpoint == 'doctor.edit_profile':
        return  # Skip the rest of the function for this route

    if not current_user.is_authenticated or current_user.role != 'doctor': # Added is_authenticated check
        flash('You do not have permission to access this area.', 'danger')
        return redirect(url_for('home.index'))

    # Ensure current_user.doctor is populated
    if not hasattr(current_user, 'doctor') or current_user.doctor is None:
        doctor = Doctor.query.filter_by(doctor_id=current_user.doctor_id_fk).first()
        if doctor:
            current_user.doctor = doctor
        else:
            # Handle the case where the doctor is not found.  This is CRITICAL.
            flash('Doctor profile not found. Please contact an administrator.', 'danger')
            return redirect(url_for('home.index'))  # Or some other appropriate page


@bp.route('/dashboard')
@login_required # Added login_required decorator
def dashboard():
    # Check if current_user has a doctor profile.  This check is now likely redundant, but good to keep.
    if hasattr(current_user, 'doctor') and current_user.doctor:
        upcoming_appointments = Appointment.query.filter_by(doctor_id=current_user.doctor.doctor_id).filter(
            Appointment.appointment_datetime >= db.func.now()).order_by(
            Appointment.appointment_datetime).all()
        return render_template('doctor/dashboard.html', upcoming_appointments=upcoming_appointments)
    else:
        flash('Doctor profile not found. Please contact an administrator.', 'danger')
        return redirect(url_for('home.index')) # Redirect to home, since doctor.edit_profile does not exist


@bp.route('/past_appointments')
@login_required # Added login_required decorator
def past_appointments():
    if hasattr(current_user, 'doctor') and current_user.doctor:
        past_appointments = Appointment.query.filter_by(doctor_id=current_user.doctor.doctor_id).filter(
            Appointment.appointment_datetime < db.func.now()).order_by(Appointment.appointment_datetime.desc()).all()
        return render_template('doctor/past_appointments.html', past_appointments=past_appointments)
    else:
        flash('Doctor profile not found. Please contact an administrator.', 'danger')
        return redirect(url_for('home.index')) # Redirect to home, since doctor.edit_profile does not exist


@bp.route('/patients')
@login_required # Added login_required decorator
def view_patients():
    # Get distinct patients for the current doctor
    if hasattr(current_user, 'doctor') and current_user.doctor: #check doctor exists
        patients = db.session.query(Patient).join(Appointment).filter(
            Appointment.doctor_id == current_user.doctor.doctor_id).distinct().all()
        return render_template('doctor/view_patients.html', patients=patients)
    else:
        flash('Doctor profile not found. Please contact an administrator.', 'danger')
        return redirect(url_for('home.index'))

# @bp.route('/record/new')
@bp.route('/record')
@login_required # Added login_required decorator
def create_medical_record_select_patient():
    if hasattr(current_user, 'doctor') and current_user.doctor: #check doctor exists
        patients = db.session.query(Patient).join(Appointment).filter(
            Appointment.doctor_id == current_user.doctor.doctor_id).distinct().all()
        return render_template('doctor/create_medical_record_select_patient.html', patients=patients)
    else:
        flash('Doctor profile not found. Please contact an administrator.', 'danger')
        return redirect(url_for('home.index'))

@bp.route('/profile')
@login_required # Added login_required decorator
def view_profile():
    if hasattr(current_user, 'doctor') and current_user.doctor:
        return render_template('doctor/view_profile.html')
    else:
        flash('Doctor profile not found. Please contact an administrator.', 'danger')
        return redirect(url_for('home.index'))

@bp.route('/profile/edit/<int:doctor_id>', methods=['GET', 'POST'])
@login_required # Added login_required decorator
def edit_profile(doctor_id):
    try:
        doctor = Doctor.query.get_or_404(doctor_id)  # get the doctor to be edited.
    except NotFound:
        flash('Doctor not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))

    if request.method == 'POST':
        # Update doctor's information
        doctor.first_name = request.form['first_name']
        doctor.last_name = request.form['last_name']
        doctor.specialization = request.form.get('specialization')

        # Handle department_id correctly
        department_id = request.form.get('department')  # Get department ID from form
        if department_id:
            try:
                department = Department.query.get(int(department_id))  # Fetch the Department object
                if department:
                    doctor.department = department  # Assign the Department object
                else:
                    flash('Invalid department selected.', 'warning') # error message
            except ValueError:
                flash('Invalid department ID.', 'warning')
        else:
            doctor.department = None

        email = request.form.get('email')
        # Check for duplicate email
        if email != doctor.email and Doctor.query.filter_by(email=email).first():
            flash('Email already exists. Please use a different email.', 'danger')
            return render_template('doctor/edit_profile.html', doctor=doctor, departments=Department.query.all())

        doctor.email = email
        doctor.contact_number = request.form.get('contact_number')
        db.session.commit()
        flash('Profile updated successfully!', 'success')
        return redirect(url_for('doctor.view_profile'))

    # Get the doctor's information for pre-filling the form
    return render_template('doctor/edit_profile.html', doctor=doctor, departments=Department.query.all())



@bp.route('/appointment/<int:appointment_id>')
@login_required # Added login_required decorator
def view_appointment(appointment_id):
    try:
        appointment = Appointment.query.get_or_404(appointment_id)
    except NotFound:
        flash('Appointment not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))

    if appointment.doctor_id != current_user.doctor.doctor_id:
        flash('You do not have permission to view this appointment.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    return render_template('doctor/view_appointment.html', appointment=appointment)

@bp.route('/patient/<int:patient_id>')
@login_required # Added login_required decorator
def view_patient(patient_id):
    try:
        patient = Patient.query.get_or_404(patient_id)
    except NotFound:
        flash('Patient not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    # Ensure the patient has an appointment with the current doctor (for security)
    appointment = Appointment.query.filter_by(patient_id=patient_id, doctor_id=current_user.doctor.doctor_id).first()
    if not appointment:
        flash('You do not have permission to view this patient.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    # return render_template('doctor/view_patient.html', patient=patient) # Removed line, there is no return


@bp.route('/patient/<int:patient_id>/records')
@login_required # Added login_required decorator
def view_patient_records(patient_id):
    try:
        patient = Patient.query.get_or_404(patient_id)
    except NotFound:
        flash('Patient not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    # Again, ensure there's a relationship (e.g., appointment)
    appointment = Appointment.query.filter_by(patient_id=patient_id, doctor_id=current_user.doctor.doctor_id).first()
    if not appointment:
        flash('You do not have permission to view records for this patient.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    records = MedicalRecord.query.filter_by(patient_id=patient_id, doctor_id=current_user.doctor.doctor_id).order_by(
        MedicalRecord.record_datetime.desc()).all()
    return render_template('doctor/view_patient_records.html', patient=patient, records=records)



@bp.route('/patient/<int:patient_id>/record', methods=['GET', 'POST'])
@login_required # Added login_required decorator
def create_medical_record(patient_id):
    try:
        patient = Patient.query.get_or_404(patient_id)
    except NotFound:
        flash('Patient not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    # Ensure the doctor has an appointment with this patient
    appointment = Appointment.query.filter_by(patient_id=patient_id, doctor_id=current_user.doctor.doctor_id).first()
    if not appointment:
        flash('You do not have permission to create records for this patient.', 'danger')
        return redirect(url_for('doctor.dashboard'))

    if request.method == 'POST':
        diagnosis = request.form['diagnosis']
        treatment = request.form['treatment']
        medications = request.form.get('medications')
        notes = request.form.get('notes')

        new_record = MedicalRecord(
            patient_id=patient_id,
            doctor_id=current_user.doctor.doctor_id,
            diagnosis=diagnosis,
            treatment=treatment,
            medications=medications,
            notes=notes
        )
        db.session.add(new_record)
        db.session.commit()
        flash('Medical record created successfully!', 'success')
        return redirect(url_for('doctor.view_patient_records', patient_id=patient_id))

    return render_template('doctor/create_medical_record.html', patient=patient)  # Corrected line



@bp.route('/appointment/<int:appointment_id>/manage', methods=['GET', 'POST'])
@login_required # Added login_required decorator
def edit_appointment_status(appointment_id):
    try:
        appointment = Appointment.query.get_or_404(appointment_id)
    except NotFound:
        flash('Appointment not found.', 'danger')
        return redirect(url_for('doctor.dashboard'))
    if appointment.doctor_id != current_user.doctor.doctor_id:
        flash('You do not have permission to manage this appointment.', 'danger')
        return redirect(url_for('doctor.dashboard'))

    if request.method == 'POST':
        status = request.form['status']
        appointment.status = status
        db.session.commit()
        flash('Appointment status updated.', 'success')
        return redirect(url_for('doctor.dashboard'))

    return render_template('doctor/edit_appointment_status.html', appointment=appointment)
