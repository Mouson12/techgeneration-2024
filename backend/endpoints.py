# endpoints.py
from flask import request, jsonify, Blueprint
from datetime import datetime, timezone
from models import db, Drawer, Alarm, Medications, Temperature, PulseOximeter

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

@api.route('/medications', methods=['GET'])
def get_medication():
    medication = Medications.query.order_by(Medications.id.desc()).first()
    
    if medication:
        return jsonify({
            'last_dose': medication.last_dose, 
            'next_dose': medication.next_dose,
            'delay_minutes': medication.delay_minutes
        }), 200
    return jsonify({'message': 'Medication not found'}), 404


# Temperature endpoint
@api.route('/temperature', methods=['GET', 'POST'])
def manage_temperature():
    if request.method == 'POST':
        data = request.get_json()
        value = data.get('value')
        
        if value is None:
            return jsonify({'message': 'Temperature value is required'}), 400
        
        # Create a new temperature entry
        temperature = Temperature(value=value)
        db.session.add(temperature)
        db.session.commit()
        
        print(f"Temperature data saved: {value}")
        return jsonify({'message': 'Temperature data saved'}), 201
    
    # GET request to get the latest temperature
    temperature = Temperature.query.order_by(Temperature.id.desc()).first()
    if temperature:
        return jsonify({'value': temperature.value}), 200
    return jsonify({'message': 'No temperature data found'}), 404


# Pulse Oximeter endpoint
@api.route('/Pulsometr', methods=['GET', 'POST'])
def manage_pulse_oximeter():
    if request.method == 'POST':
        data = request.get_json()
        value = data.get('value')
        
        if value is None :
            return jsonify({'message': 'Oxygen saturation and pulse rate are required'}), 400
        
        # Create a new pulse oximeter entry
        pulse_oximeter = PulseOximeter(value=value)
        db.session.add(pulse_oximeter)
        db.session.commit()
        
        return jsonify({'message': 'Pulse oximeter data saved'}), 201
    
    # GET request to get the latest pulse oximeter data
    pulse_oximeter = PulseOximeter.query.order_by(PulseOximeter.id.desc()).first()
    if pulse_oximeter:
        return jsonify({
            'value': pulse_oximeter.value,
        }), 200
    return jsonify({'message': 'No pulse oximeter data found'}), 404



#ToDo: meds_taken edpoint fix

@api.route('/meds-taken', methods=['GET'])
def check_meds_taken():
    # Znajdź ostatni wpis w tabeli Medications
    medication = Medications.query.order_by(Medications.id.desc()).first()
    
    if not medication:
        return jsonify({'meds_taken': False}), 404
    
    # Sprawdź, czy aktualny czas >= next_dose
    meds_taken = datetime.now(timezone.utc) >= medication.next_dose
    
    return jsonify({'meds_taken': meds_taken}), 200
