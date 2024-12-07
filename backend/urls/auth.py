from flask import Blueprint, jsonify, request
from models import db, User
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import JWTManager, create_access_token
from flasgger import swag_from

auth = Blueprint('auth', __name__)

# Registration Endpoint
@auth.route('/register', methods=['POST'])
@swag_from('../swagger_templates/register.yml')
def register():
    data = request.get_json()

    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    if not username or not email or not password:
        return jsonify({"message": "Username, email, and password are required."}), 400

    # Check if the email already exists
    existing_user = User.query.filter((User.email == email)).first()
    if existing_user:
        return jsonify({"message": "Username or email already in use."}), 400

    # Create a new user and hash the password
    new_user = User(username=username, email=email)
    new_user.set_password(password)
    
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully."}), 201


# Login Endpoint
@auth.route('/login', methods=['POST'])
@swag_from('../swagger_templates/login.yml')
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"message": "Email and password are required."}), 400

    # Find the user by email
    user = User.query.filter_by(email=email).first()
    if user and user.check_password(password):
        # Generate JWT token
        access_token = user.generate_jwt()
        return jsonify({
            "message": "Login successful.",
            "access_token": access_token
        }), 200
    else:
        return jsonify({"message": "Invalid email or password."}), 401