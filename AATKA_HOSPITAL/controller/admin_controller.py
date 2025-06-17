from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_required, current_user
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.user import User
from AATKA_HOSPITAL.models.doctor import Doctor
from AATKA_HOSPITAL.models.admin import Admin
from AATKA_HOSPITAL.models.department import Department  # Import the Department model
from werkzeug.security import generate_password_hash


bp = Blueprint('admin', __name__, url_prefix='/admin')

@bp.before_request
@login_required
def admin_required():
    if not current_user.is_authenticated or current_user.role != 'admin':
        flash('You do not have permission to access this area.', 'danger')
        return redirect(url_for('home.index'))

@bp.route('/dashboard')
def dashboard():
    return render_template('admin/dashboard.html')

@bp.route('/departments')
def list_departments():
    departments = Department.query.all()
    return render_template('admin/list_departments.html', departments=departments)

@bp.route('/departments/add', methods=['GET', 'POST'])
def add_department():
    if request.method == 'POST':
        name = request.form['name']
        description = request.form.get('description')
        if name:
            existing_department = Department.query.filter_by(name=name).first()
            if existing_department:
                flash('Department name already exists.', 'warning')
            else:
                new_department = Department(name=name, description=description)
                db.session.add(new_department)
                db.session.commit()
                flash(f'Department "{name}" added successfully!', 'success')
                return redirect(url_for('admin.list_departments'))
        else:
            flash('Department name is required.', 'danger')
    return render_template('admin/add_department.html')

@bp.route('/departments/delete/<int:department_id>', methods=['POST'])
def delete_department(department_id):
    department = Department.query.get_or_404(department_id)
    db.session.delete(department)
    db.session.commit()
    flash(f'Department "{department.name}" deleted successfully!', 'success')
    return redirect(url_for('admin.list_departments'))

@bp.route('/delete_doctor/<int:doctor_id>', methods=['POST'])
def delete_doctor(doctor_id):
    """
    Deletes a doctor from the database.

    Args:
        doctor_id (int): The ID of the doctor to delete.

    Returns:
        A redirect to the list_doctors page after successful deletion.
    """
    doctor = Doctor.query.get_or_404(doctor_id)  # Get the doctor or return 404 if not found
    db.session.delete(doctor)
    db.session.commit()
    flash(f'Doctor "{doctor.first_name} {doctor.last_name}" deleted successfully!', 'success')
    return redirect(url_for('admin.list_doctors'))  # Redirect to the list of doctors

@bp.route('/register/doctor', methods=['GET', 'POST'])
def register_doctor():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        specialization = request.form.get('specialization')
        department_id = request.form.get('department_id')
        email = request.form.get('email')
        contact_number = request.form.get('contact_number')

        departments = Department.query.all()

        if User.query.filter_by(username=username).first():
            flash('Username already exists.', 'warning')
            return render_template('admin/register_doctor.html', departments=departments)

        if Doctor.query.filter_by(email=email).first():  # Check for duplicate email
            flash('Email address already exists. Please enter a different email.', 'danger')
            return render_template('admin/register_doctor.html', departments=departments)

        new_user = User(username=username, role='doctor')
        new_user.set_password(password)
        db.session.add(new_user)
        db.session.flush()

        new_doctor = Doctor(
            first_name=first_name,
            last_name=last_name,
            specialization=specialization,
            department_id=department_id,
            email=email,
            contact_number=contact_number
        )
        db.session.add(new_doctor)
        db.session.flush()
        new_user.doctor_id_fk = new_doctor.doctor_id
        db.session.commit()

        flash(f'Doctor "{first_name} {last_name}" registered successfully!', 'success')
        return redirect(url_for('admin.list_doctors'))

    departments = Department.query.all()
    return render_template('admin/register_doctor.html', departments=departments)


@bp.route('/register/admin', methods=['GET', 'POST'])
def register_admin():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        last = request.form['last_name']
        first = request.form['first_name']
        

        if User.query.filter_by(username=username).first():
            flash('Username already exists.', 'warning')
            return render_template('admin/register_admin.html')

        new_user = User(username=username, role='admin')
        new_user.set_password(password)
        db.session.add(new_user)
        db.session.flush()

        new_admin = Admin(username=username, password=generate_password_hash(password), email=email,first_name=first,last_name=last)
        db.session.add(new_admin)
        db.session.flush()
        new_user.admin_id_fk = new_admin.admin_id
        db.session.commit()

        flash(f'Admin "{username}" registered successfully!', 'success')
        return redirect(url_for('admin.list_admins'))

    return render_template('admin/register_admin.html')

@bp.route('/doctors')
def list_doctors():
    doctors = Doctor.query.all()
    return render_template('admin/list_doctors.html', doctors=doctors)

@bp.route('/admins')
def list_admins():
    admins = Admin.query.all()
    return render_template('admin/list_admins.html', admins=admins)