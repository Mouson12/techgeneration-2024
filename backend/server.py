from flask import Flask, render_template, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from models import db
from config import Config
from urls.auth import auth
from urls.api import api
from flask_jwt_extended import JWTManager
from flasgger import Swagger
from sqlalchemy.exc import OperationalError

app = Flask(__name__)

try:
    # Load app config
    app.config.from_object(Config)

    # Initialize the app
    db.init_app(app)

    # Try creating tables
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


jwt = JWTManager(app)

swagger = Swagger(app, template={
    "info": {
        "title": "User API - monitoring smart devices",
        "description": "API for user management, checking sensor readings and managing alerts in a device network.",
        "version": "1.0.0"
    }
})


app.register_blueprint(auth, url_prefix="/auth")
app.register_blueprint(api, url_prefix="/api")

@app.errorhandler(404)
def page_not_found(e):
    return jsonify({"error": "Page not found"}), 404


# if __name__ == '__main__': 
#     app.run(port=5000, debug=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)