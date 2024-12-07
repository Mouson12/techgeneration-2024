# endpoints.py
from flask import request, jsonify, Blueprint
from datetime import datetime, timezone, timedelta
from models import db, Drawer, Alarm, Medications, Temperature, PulseOximeter
import pytz

GMT = pytz.timezone("Etc/GMT")

# utc_plus_2 = pytz.timezone('Etc/GMT-2')

# Create a Blueprint for routes
api = Blueprint('api', __name__)


# Drawer endpoint
@api.route('/drawer', methods=['GET', 'POST'])
def manage_drawer():
    if request.method == 'POST':
        data = request.get_json()
        is_open = data.get('is_open', False)
        
        # Pobierz ostatni stan szuflady
        last_drawer = Drawer.query.order_by(Drawer.id.desc()).first()

        # Sprawdź, czy poprzedni stan był otwarty (1), a nowy jest zamknięty (0)
        if last_drawer and last_drawer.is_open == 1 and is_open == 0:
            # Pobierz rekord z tabeli medications
            medication = Medications.query.order_by(Medications.id.desc()).first()
            if medication:
                # Aktualizuj pola last_dose, next_dose i delay
                medication.last_dose = medication.next_dose
                medication.next_dose = datetime.now() + timedelta(hours=1) + timedelta(minutes=2)
                medication.delay_minutes = 0
                db.session.commit()

        # Zapisz nowy stan szuflady
        new_drawer = Drawer(is_open=is_open)
        db.session.add(new_drawer)
        db.session.commit()
        
        return jsonify({'message': 'Drawer state saved'}), 201
    
    # GET request to get the last state of the drawer
    last_drawer = Drawer.query.order_by(Drawer.id.desc()).first()
    if last_drawer:
        return jsonify({'is_open': last_drawer.is_open}), 200
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
    last_dose = data.get('last_dose', datetime.now() + timedelta(hours=1))
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

@api.route('/current-time', methods=['GET'])
def get_current_time():
    current_time = datetime.now() + timedelta(hours=1)  # Z oznacza czas UTC
    return jsonify({'current_time': current_time}), 200


# Click endpoint
@api.route('/click', methods=['POST'])
def handle_click():
    data = request.get_json()
    value = data.get('value')

    if value is None:
        return jsonify({'message': 'Value is required'}), 400

    if value == 1:
        # Pobierz ostatni rekord w tabeli Medications
        medication = Medications.query.order_by(Medications.id.desc()).first()
        if not medication:
            return jsonify({'message': 'No medication data found'}), 404
        
        # Zwiększ delay_minutes o 15 sekund
        medication.delay_minutes += 1  # 15 sekund = 0.25 minut
        db.session.commit()

        return jsonify({'message': 'Delay increased by 15 seconds'}), 200

    elif value == 3:
        # Utwórz nowy alarm lub zaktualizuj istniejący rekord
        alarm = Alarm.query.order_by(Alarm.id.desc()).first()
        if not alarm:
            alarm = Alarm(fall_detected=True)
            db.session.add(alarm)
        else:
            alarm.fall_detected = True
        db.session.commit()

        return jsonify({'message': 'Alarm set to true'}), 200

    return jsonify({'message': 'Invalid value'}), 400


#ToDo: meds_taken edpoint fix

@api.route('/meds-taken', methods=['GET'])
def check_meds_taken():
    # Znajdź ostatni wpis w tabeli Medications
    medication = Medications.query.order_by(Medications.id.desc()).first()
    
    if not medication:
        return jsonify({'meds_taken': False}), 404
    
    # Sprawdź, czy aktualny czas >= next_dose
    meds_taken = datetime.now() + timedelta(hours=1) >= medication.next_dose
    
    return jsonify({'meds_taken': meds_taken}), 200
