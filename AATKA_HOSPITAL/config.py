import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'aatka_super_secure_key_123'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'mysql+pymysql://root@localhost/HOSPITAL_MANAGEMENT'
    SQLALCHEMY_TRACK_MODIFICATIONS = False