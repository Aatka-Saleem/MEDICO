from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from AATKA_HOSPITAL.config import Config
from sqlalchemy.orm import configure_mappers

import logging

db = SQLAlchemy()

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    db.init_app(app)

    # Set up logging
    logging.basicConfig(level=logging.DEBUG)

    # Import models *before* the application context
    from AATKA_HOSPITAL.models.user import User
    from AATKA_HOSPITAL.models.admin import Admin
    from AATKA_HOSPITAL.models.patient import Patient
    from AATKA_HOSPITAL.models.doctor import Doctor
    from AATKA_HOSPITAL.models.appointment import Appointment
    from AATKA_HOSPITAL.models.medical_record import MedicalRecord
    from AATKA_HOSPITAL.models.department import Department

    from AATKA_HOSPITAL.controller import auth_controller
    from AATKA_HOSPITAL.controller import doctor_controller
    from AATKA_HOSPITAL.controller import patient_controller
    from AATKA_HOSPITAL.controller import appointment_controller
    from AATKA_HOSPITAL.controller import record_controller
    from AATKA_HOSPITAL.controller import home_controller
    from AATKA_HOSPITAL.controller import admin_controller
    from AATKA_HOSPITAL.controller import department_controller

    

    app.register_blueprint(auth_controller.bp)
    app.register_blueprint(doctor_controller.bp)
    app.register_blueprint(patient_controller.bp)
    app.register_blueprint(appointment_controller.bp)
    app.register_blueprint(record_controller.bp)
    app.register_blueprint(home_controller.bp)
    app.register_blueprint(admin_controller.bp)
    app.register_blueprint(department_controller.bp)
     # Register the new blueprint

    with app.app_context():
        logging.debug("Configuring mappers...")
        configure_mappers()
        logging.debug("Mappers configured.")
        db.create_all() # Moved db.create_all() here
        logging.info("Database tables created")

    return app