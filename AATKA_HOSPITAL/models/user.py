from AATKA_HOSPITAL import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from sqlalchemy.orm import relationship


class User(db.Model, UserMixin):
    __tablename__ = 'users'  # Note the lowercase 'user' to match your table name (SQLAlchemy often lowercases)

    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False, name='password')
    role = db.Column(db.Enum('admin', 'doctor', 'patient'), nullable=False)
    admin_id_fk = db.Column(db.Integer, db.ForeignKey('admins.admin_id'))  # Assuming you have an 'admins' table
    doctor_id_fk = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id'))  # Assuming you have a 'doctors' table
    patient_id_fk = db.Column(db.Integer, db.ForeignKey('patients.patient_id'))  # Assuming you have a 'patients' table
    created_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    updated_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())

     
    # Relationships (Optional, depending on your needs)
    admin = relationship('Admin', backref='admin_user', uselist=False)  # If you need to access the Admin object
    doctor = relationship('Doctor', backref='doctor_user', uselist=False) # If you need to access the Doctor object
    patient = relationship('Patient', backref='patient_user', uselist=False) #If you need to access the Patient object

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def get_id(self):
        return str(self.user_id)

    def __repr__(self):
        return f'<User {self.username}>'
    


