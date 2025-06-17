from flask import Blueprint, render_template
from AATKA_HOSPITAL.models.department import Department  # Import the Department model
from AATKA_HOSPITAL.models.doctor import Doctor
from AATKA_HOSPITAL import db #Import the db instance

bp = Blueprint('home', __name__, url_prefix='/')

@bp.route('/')
def index():
    return render_template("home/index.html")

@bp.route('/about')
def about():
    return render_template("home/about.html")

@bp.route('/doctors')
def doctors():
    doctors = Doctor.query.all()  # Fetch all doctors from the database
    departments = Department.query.all()  # Fetch all departments for the navbar
    return render_template('home/doctor.html', doctors=doctors, departments=departments) # Pass both to template

@bp.route('/departments')
def departments():
    departments = Department.query.all()  # Query all departments from the database
    return render_template("home/department.html", departments=departments)  # Pass the departments to the template

@bp.route('/doctors/department/<department_name>')
def filter_doctors_by_department(department_name):
    department = Department.query.filter_by(name=department_name).first_or_404()
    doctors = Doctor.query.filter_by(department_id=department.department_id).all()
    departments = Department.query.all()  # Keep departments for the navbar
    return render_template('home/doctor.html', doctors=doctors, departments=departments, active_department=department_name)