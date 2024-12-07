from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flasgger import Swagger
from config import Config
from endpoints import api
from models import db, Drawer, Alarm, Medications
from sqlalchemy.exc import OperationalError

app = Flask(__name__)

# Configure app from config.py
try:
    app.config.from_object(Config)
    
    # Initialize database with app context
    db.init_app(app)
    
    # Attempt to create tables
    with app.app_context():
        db.create_all()
        
except OperationalError as e:
    print("Database connection failed. Please ensure the database is running and accessible.")
    print(f"Error: {e}")
    exit(1)
except Exception as e:
    print("An unexpected error occurred during app initialization.")
    print(f"Error: {e}")
    exit(1)

# Initialize JWTManager for authentication
jwt = JWTManager(app)

# Setup Swagger for API documentation
swagger = Swagger(app, template={
    "info": {
        "title": "User API - Monitoring Smart Devices",
        "description": "API for user management, sensor readings, and device network alerts.",
        "version": "1.0.0"
    }
})

# Register Blueprints (routes)
app.register_blueprint(api, url_prefix="/api")  # Register the API Blueprint

# Error handler for 404 errors
@app.errorhandler(404)
def page_not_found(e):
    return jsonify({"error": "Page not found"}), 404

# Run the app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
