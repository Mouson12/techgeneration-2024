from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timezone
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import JWTManager, create_access_token
from datetime import timedelta

db = SQLAlchemy()


class Drawer(db.Model):
    __tablename__ = 'drawer'
    id = db.Column(db.Integer, primary_key=True)
    is_open = db.Column(db.Boolean, nullable=False, default=False)  # 0 or 1
    
    def __repr__(self):
        return f"<Drawer(id={self.id}, is_open={self.is_open})>"

class Alarm(db.Model):
    __tablename__ = 'alarm'
    id = db.Column(db.Integer, primary_key=True)
    fall_detected = db.Column(db.Boolean, nullable=False, default=False)  # True if fall detected
    
    def __repr__(self):
        return f"<Alarm(id={self.id}, fall_detected={self.fall_detected})>"

class Medications(db.Model):
    __tablename__ = 'medications'
    id = db.Column(db.Integer, primary_key=True)
    last_dose = db.Column(db.DateTime, nullable=False, default=datetime.now(timezone.utc))  # Timestamp of last dose
    next_dose = db.Column(db.DateTime, nullable=False)  # Timestamp of next dose
    delay_minutes = db.Column(db.Integer, nullable=False)  # Delay in minutes
    
    def __repr__(self):
        return f"<Medications(id={self.id}, last_dose={self.last_dose}, next_dose={self.next_dose}, delay_minutes={self.delay_minutes})>"
