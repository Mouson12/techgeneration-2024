# endpoints.py
from flask import request, jsonify, Blueprint
from datetime import datetime
from models import db, Drawer, Alarm, Medications

# Create a Blueprint for routes
api = Blueprint('api', __name__)

# Drawer endpoint
@api.route('/drawer', methods=['GET', 'POST'])
def manage_drawer():
    if request.method == 'POST':
        data = request.get_json()
        is_open = data.get('is_open', False)
        
        # Create a new drawer state
        drawer = Drawer(is_open=is_open)
        db.session.add(drawer)
        db.session.commit()
        
        return jsonify({'message': 'Drawer state saved'}), 201
    
    # GET request to get the last state of the drawer
    drawer = Drawer.query.order_by(Drawer.id.desc()).first()
    if drawer:
        return jsonify({'is_open': drawer.is_open}), 200
    return jsonify({'message': 'No drawer state found'}), 404

# Alarm endpoint
@api.route('/alarm', methods=['GET', 'POST'])
def manage_alarm():
    if request.method == 'POST':
        data = request.get_json()
        fall_detected = data.get('fall_detected', False)
        
        # Create a new alarm state
        alarm = Alarm(fall_detected=fall_detected)
        db.session.add(alarm)
        db.session.commit()
        
        return jsonify({'message': 'Alarm state saved'}), 201
    
    # GET request to check if a fall was detected
    alarm = Alarm.query.order_by(Alarm.id.desc()).first()
    if alarm:
        return jsonify({'fall_detected': alarm.fall_detected}), 200
    return jsonify({'message': 'No alarm state found'}), 404

# Medications endpoint
@api.route('/medications', methods=['POST'])
def manage_medications():
    data = request.get_json()
    last_dose = data.get('last_dose', datetime.utcnow())
    next_dose = data.get('next_dose')
    delay_minutes = data.get('delay_minutes')
    
    if not next_dose or not delay_minutes:
        return jsonify({'message': 'Next dose and delay minutes are required'}), 400
    
    # Create a new medication entry
    medication = Medications(last_dose=last_dose, next_dose=next_dose, delay_minutes=delay_minutes)
    db.session.add(medication)
    db.session.commit()
    
    return jsonify({'message': 'Medication data saved'}), 201

# Endpoint for getting medication details by ID
@api.route('/medications/<int:id>', methods=['GET'])
def get_medication(id):
    medication = Medications.query.get(id)
    if medication:
        return jsonify({
            'last_dose': medication.last_dose,
            'next_dose': medication.next_dose,
            'delay_minutes': medication.delay_minutes
        }), 200
    return jsonify({'message': 'Medication not found'}), 404
