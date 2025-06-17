from flask import Blueprint, render_template, redirect, url_for, flash, request
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.user import User
from AATKA_HOSPITAL.models.admin import Admin
from AATKA_HOSPITAL.models.doctor import Doctor
from AATKA_HOSPITAL.models.patient import Patient
from werkzeug.security import generate_password_hash
from flask_login import login_user, logout_user, LoginManager, current_user, login_required


bp = Blueprint('auth', __name__, url_prefix='/auth')
login_manager = LoginManager()
login_manager.login_view = 'auth.login'  # Corrected: Set the login view

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@bp.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('auth.register'))

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if not username or not password:
            flash('Username and password are required.', 'danger')
            return render_template('auth/register.html')

        if User.query.filter_by(username=username).first():
            flash('Username already exists. Please choose a different one.', 'warning')
            return render_template('auth/register.html')

        new_user = User(username=username, role='patient')  # Default role is patient
        new_user.set_password(password)
        db.session.add(new_user)
        db.session.commit()
        flash('Account created. Please provide your patient details.', 'info')
        return redirect(url_for('auth.patient_details_form', user_id=new_user.user_id))

    return render_template('auth/register.html')
@bp.route('/patient/details/<int:user_id>', methods=['GET'])
def patient_details_form(user_id):
    user = User.query.get_or_404(user_id)
    if user.role != 'patient':
        flash('Invalid user role for patient details.', 'danger')
        return redirect(url_for('main.index'))
    return render_template('auth/patient_details_form.html', user_id=user_id)

@bp.route('/patient/details/<int:user_id>', methods=['POST'])
def submit_patient_details(user_id):
    user = User.query.get_or_404(user_id)
    if user.role != 'patient' or user.patient_id_fk is not None:
        flash('Patient details already submitted or invalid user.', 'danger')
        # return redirect(url_for('main.index'))
        return redirect(url_for('home.index'))

    first_name = request.form['first_name']
    last_name = request.form['last_name']
    date_of_birth = request.form.get('date_of_birth')
    gender = request.form.get('gender')
    contact_number = request.form.get('contact_number')
    address = request.form.get('address')
    email = request.form.get('email')

    new_patient = Patient(
        first_name=first_name,
        last_name=last_name,
        date_of_birth=date_of_birth,
        gender=gender,
        contact_number=contact_number,
        address=address,
        email=email
    )
    db.session.add(new_patient)
    db.session.flush()
    user.patient_id_fk = new_patient.patient_id
    db.session.commit()

    flash('Patient details saved successfully!', 'success')
    return redirect(url_for('auth.login'))

@bp.route('/doctor/details/<int:user_id>', methods=['GET'])
def doctor_details_form(user_id):
    user = User.query.get_or_404(user_id)
    if user.role != 'doctor':
        flash('Invalid user role for doctor details.', 'danger')
        return redirect(url_for('main.index'))
    return render_template('auth/doctor_details_form.html', user_id=user_id)

@bp.route('/doctor/details/<int:user_id>', methods=['POST'])
def submit_doctor_details(user_id):
    user = User.query.get_or_404(user_id)
    if user.role != 'doctor':
        flash('Invalid user role. Expected doctor.', 'danger')
        return redirect(url_for('home.index'))  # Redirect to home or appropriate page

    if hasattr(user, 'doctor_profile') and user.doctor_profile is not None:
        flash('Doctor details already submitted for this user.', 'danger')
        return redirect(url_for('home.index'))

    try:
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        specialization = request.form.get('specialization')
        # department = request.form.get('department')  <-- Removed direct department
        department_id = request.form.get('department_id') #changed to department_id
        email = request.form.get('email')
        contact_number = request.form.get('contact_number')

        # added validation
        if not first_name or not last_name:
            flash('First name and last name are required.', 'danger')
            return redirect(url_for('auth.doctor_details_form', user_id=user.user_id))  # Stay on form

        # Ensure department exists if provided
        if department_id:
            department = Department.query.get(department_id) # changed from .get
            if not department:
                flash('Invalid department ID.', 'danger')
                return redirect(url_for('auth.doctor_details_form', user_id=user.user_id))

        new_doctor = Doctor(
            first_name=first_name,
            last_name=last_name,
            specialization=specialization,
            department_id=department_id, # Save department_id
            email=email,
            contact_number=contact_number,
            user=user  # Set the relationship
        )
        db.session.add(new_doctor)
        db.session.commit()

        flash('Doctor details saved successfully!', 'success')
        return redirect(url_for('auth.login'))  # Or wherever appropriate

    except Exception as e:
        db.session.rollback()
        flash(f'An error occurred: {str(e)}', 'danger')
        return redirect(url_for('auth.doctor_details_form', user_id=user.user_id))  # Stay on form

    finally:
        db.session.close()



@bp.route('/login', methods=['GET', 'POST'])
def login():
    """Handles user login."""
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        remember = True if request.form.get('remember') else False # Added "remember me" functionality

        user = User.query.filter_by(username=username).first()

        if user and user.check_password(password):
            login_user(user, remember=remember) # Added remember me.
            flash('Login successful!', 'success')
            return _handle_login_redirect(user)
        else:
            flash('Invalid username or password.', 'danger')
            return render_template('auth/login.html')

    return render_template('auth/login.html')  # This line is crucial


def _handle_login_redirect(user):
    """Helper function to handle login redirection based on user role."""
    if user.role == 'doctor':
        if user.doctor_id_fk:  # Check if doctor_id_fk is not None
            doctor = Doctor.query.filter_by(doctor_id=user.doctor_id_fk).first()
            if doctor:
                return redirect(url_for('doctor.dashboard'))
            else:
                flash('Doctor profile incomplete.  Please complete it.', 'warning')
                return redirect(url_for('auth.doctor_details_form', user_id=user.user_id))
        else:
            flash('Doctor profile incomplete.  Please complete it.', 'warning')
            return redirect(url_for('auth.doctor_details_form', user_id=user.user_id))
    elif user.role == 'patient':
        if user.patient_id_fk: # Check if patient_id_fk is not None
            patient = Patient.query.filter_by(patient_id=user.patient_id_fk).first()
            if patient:
                return redirect(url_for('patient.dashboard'))
            else:
                flash('Patient profile incomplete.  Please complete it.', 'warning')
                return redirect(url_for('auth.patient_details_form', user_id=user.user_id))
        else:
            flash('Patient profile incomplete.  Please complete it.', 'warning')
            return redirect(url_for('auth.patient_details_form', user_id=user.user_id))
    elif user.role == 'admin':
        return redirect(url_for('admin.dashboard'))
    else:
        return redirect(url_for('auth.login'))

@bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Logged out successfully.', 'info')
    return redirect(url_for('auth.login'))

 