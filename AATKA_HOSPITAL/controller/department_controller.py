from flask import Blueprint, render_template, redirect, url_for, flash, request
from AATKA_HOSPITAL import db
from AATKA_HOSPITAL.models.department import Department  # Import the Department model
from flask_login import login_required, current_user
from AATKA_HOSPITAL import create_app  # Import the Flask app instance

bp = Blueprint('department', __name__, url_prefix='/departments')

@bp.before_request
@login_required
def admin_required():
    if not current_user.is_authenticated or current_user.role != 'admin':
        flash('You do not have permission to access this area.', 'danger')
        return redirect(url_for('home.index'))

@bp.route('/')
def list_departments():
    departments = Department.query.all()
    return render_template('admin/list_departments.html', departments=departments)

@bp.route('/departments')
def departments():
    all_departments = Department.query.all()
    return render_template('department.html', departments=all_departments)

@bp.route('/add', methods=['GET', 'POST'])
def add_department():
    if request.method == 'POST':
        name = request.form['name']
        description = request.form.get('description')
        if not name:
            flash('Department name is required.', 'danger')
            return render_template('admin/add_department.html') #changed path
        existing_department = Department.query.filter_by(name=name).first()
        if existing_department:
            flash('Department name already exists.', 'warning')
            return render_template('admin/add_department.html')  # Stay on the add page
        new_department = Department(name=name, description=description)
        db.session.add(new_department)
        db.session.commit()
        flash(f'Department "{name}" added successfully!', 'success')
        return redirect(url_for('department.list_departments')) #changed admin to department

    return render_template('admin/add_department.html') #changed path

@bp.route('/edit/<int:department_id>', methods=['GET', 'POST'])
def edit_department(department_id):
    department = Department.query.get_or_404(department_id)
    if request.method == 'POST':
        name = request.form['name']
        description = request.form.get('description')
        if not name:
            flash('Department name is required.', 'danger')
            return render_template('admin/edit_department.html', department=department)
        existing_department = Department.query.filter_by(name=name).first()
        if existing_department and existing_department.department_id != department.department_id:
            flash('Department name already exists.', 'warning')
            return render_template('admin/edit_department.html', department=department)
        department.name = name
        department.description = description
        db.session.commit()
        flash(f'Department "{name}" updated successfully!', 'success')
        return redirect(url_for('department.list_departments')) #changed admin to department
    return render_template('admin/edit_department.html', department=department) #changed path

@bp.route('/delete/<int:department_id>', methods=['POST'])
def delete_department(department_id):
    department = Department.query.get_or_404(department_id)
    db.session.delete(department)
    db.session.commit()
    flash(f'Department "{department.name}" deleted successfully!', 'success')
    return redirect(url_for('department.list_departments'))  #changed admin to department
