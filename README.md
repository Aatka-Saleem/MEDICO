MEDICO – Hospital Management System

MEDICO is a modern, web-based hospital management system designed to automate and streamline hospital operations for administrators, doctors, and patients. It also includes an independent AI-powered fitness advisor that offers personalized health suggestions.

Built using Flask (Python), MySQL, and Bootstrap for the main system, and Streamlit with the GROQ API (LLaMA model) for the AI tool, MEDICO delivers both clinical efficiency and intelligent digital health support.

Objectives

Digitalize and automate routine hospital workflows

Provide secure, role-based access for admins, doctors, and patients

Integrate an AI-based fitness module for health and wellness advice

Offer a responsive and user-friendly interface across devices

Key Features

Role-Based Access

Admin: Manage doctors, patients, appointments, and hospital data

Doctor: View patients, update medical records, manage appointments

Patient: Book appointments, access personal records and reports

Appointment Management

Schedule, reschedule, and cancel appointments

Medical Record Handling

Persistent patient histories and treatment records

Secure and access-controlled data editing

AI Fitness Advisor (Independent Module)

Built using Streamlit for real-time interaction

Calculates BMI and provides diet plan 

Uses GROQ’s LLaMA language model

Operates independently and does not interact with the hospital database

Technology Stack

Frontend: HTML5, CSS3, JavaScript, Bootstrap

Backend: Python (Flask Framework)

Database: MySQL

AI Module: Streamlit + GROQ API (LLaMA model)

Authentication: Flask session-based login with password hashing

Project Structure

run.py – Main Flask application file

/templates – HTML (Jinja2) templates for the UI

/static – CSS, JavaScript, and images

requirements.txt – Project dependencies

README.md – Documentation

How to Run the Project

Clone the Repository
Run: git clone https://github.com/Aatka-Saleem/MEDICO.git
Then: cd MEDICO

Install Required Packages
Run: pip install -r requirements.txt

Set Up the Database

Create a new database in MySQL named hospital

Import the SQL file provided at:

bash
AATKA_HOSPITAL/hospital_management (1).sql
You can import it using:

phpMyAdmin:

Open phpMyAdmin

Create a database named hospital

Go to the Import tab

Select the file: AATKA_HOSPITAL/hospital_management (1).sql

Click Go

Or via MySQL Command Line:

bash
mysql -u root -p hospital < "AATKA_HOSPITAL/hospital_management (1).sql"
📌 Make sure the file path is correct relative to where you run the command.

Run the Flask Application
Run: python run.py
Open in browser: http://localhost:5000

Database Tables Overview

users: Stores login credentials and user roles

doctors, patients, admins: Role-specific details

appointments: Scheduling and booking data

medicalrecords: Complete patient history

departments: Doctor specializations

Database is normalized up to 3NF for performance and consistency.

Security Highlights

Passwords securely hashed before storage

Secure session management using Flask

Role-based access control to restrict features

SQL injection prevention using parameterized queries

Future Enhancements

Email and SMS notifications for appointments

Management and scheduling  appointments for doctors

Health analytics and visualization dashboards

Cloud deployment (e.g., Heroku, Render)

Activity logging for admin actions

Author

Aatka Saleem
Developer | AI Enthusiast | Healthcare Tech Explorer
GitHub: https://github.com/Aatka-Saleem

License

This project is licensed under the MIT License.

Contribution Guidelines

Contributions are welcome. To contribute:

Fork the repository

Create a new branch: git checkout -b feature-name

Make your changes and commit: git commit -m "Add feature"

Push to GitHub: git push origin feature-name

Open a pull request

