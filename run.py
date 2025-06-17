from AATKA_HOSPITAL import create_app, db
from flask_login import LoginManager

app = create_app()

from AATKA_HOSPITAL.models.user import User 


login_manager = LoginManager(app)
login_manager.login_view = 'auth.login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Create database tables if they don't exist # REMOVE THIS
with app.app_context():
    db.create_all()

if __name__ == '__main__': app.run(debug=True)
