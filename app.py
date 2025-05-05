from flask import Flask, render_template, request, redirect, url_for, session,jsonify
import os
from datetime import datetime
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Change this to a secure secret key

# Define the MySQL database connection
db_config = {
    'host': 'localhost',
    'user': 'Bhargav',
    'password': 'N@ni@12102002',
    'database': 'hospital_management'
}

def get_db_connection():
    connection = mysql.connector.connect(**db_config)
    return connection

@app.route('/')
def index():
    return render_template('login.html')
@app.route('/other_page')
def other_page():
    # Your logic to render the other page
    return render_template('contactpage.html')


@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    
    # Check in Doctor table
    cursor.execute("SELECT * FROM Doctor WHERE DoctorID = %s AND Password = %s", (username, password))
    doctor = cursor.fetchone()
    if doctor:
        # Fetch nurses assigned to the doctor
        cursor.execute("SELECT DISTINCT Nurse.* FROM Nurse JOIN Patient ON Nurse.NurseID = Patient.NurseID WHERE Patient.DoctorID = %s", (username,))
        nurses = cursor.fetchall()
        connection.close()
        return render_template('doctor.html', doctor=doctor, nurses=nurses)
    
    # Check in Nurse table
    cursor.execute("SELECT * FROM Nurse WHERE NurseID = %s AND Password = %s", (username, password))
    nurse = cursor.fetchone()
    if nurse:
        session['nurse_id'] = nurse['NurseID']  # Store nurse ID in session
        connection.close()
        return redirect(url_for('nurse_homepage'))
    
    # Check in Patient table
    cursor.execute("SELECT * FROM Patient WHERE PatientID = %s AND Password = %s", (username, password))
    patient = cursor.fetchone()
    if patient:
        # Storing patient ID in session
        session['patient_id'] = username
        connection.close()
        return redirect(url_for('patient_homepage'))
    else:
        connection.close()
        return render_template('login.html', error="Invalid username or password")

@app.route('/doctor')
def doctor_homepage():
    return render_template('doctor.html')

@app.route('/nurse_homepage')
def nurse_homepage():
    if 'nurse_id' in session:
        nurse_id = session['nurse_id']
        
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        # Fetch patients assigned to the nurse
        cursor.execute("SELECT * FROM Patient WHERE NurseID = %s", (nurse_id,))
        patients = cursor.fetchall()
        
        connection.close()
        
        return render_template('nurse_patients.html', patients=patients)
    else:
        return redirect(url_for('index'))


@app.route('/patient')
def patient_homepage():
    if 'patient_id' in session:
        patient_id = session['patient_id']
        
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        
        # Fetch patient details based on patient ID
        cursor.execute("SELECT * FROM Patient WHERE PatientID = %s", (patient_id,))
        patient = cursor.fetchone()
        
        connection.close()
        
        return render_template('patient.html', patient=patient)
    else:
        return redirect(url_for('index'))

@app.route('/doc_patients.html')
def doc_patients():
    # Get nurse_id and doctor_id from URL parameters
    nurse_id = request.args.get('nurse_id')
    doctor_id = request.args.get('doctor_id')

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    
    # Fetch patients assigned to the nurse and doctor
    cursor.execute("SELECT * FROM Patient WHERE DoctorID = %s AND NurseID = %s", (doctor_id, nurse_id))
    patients = cursor.fetchall()

    # Get the nurse's name
    cursor.execute("SELECT NurseName FROM Nurse WHERE NurseID = %s", (nurse_id,))
    nurse_name = cursor.fetchone()['NurseName']

    connection.close()

    # Render the doc_patients.html template with patients and nurse_name
    return render_template('doc_patients.html', patients=patients, nurse_name=nurse_name)

@app.route('/final_doc_patients')
def final_doc_patients():
    doctor_id = None  # Define a default value for doctor_id
    if 'doctor_id' in session:
        doctor_id = session['doctor_id']
    patient_id = request.args.get('patient_id')
    nurse_id = request.args.get('nurse_id')
    
    # Fetch patient details using the patient_id
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Patient WHERE PatientID = %s", (patient_id,))
    patient = cursor.fetchone()

    # Fetch nurse details using the nurse_id
    cursor.execute("SELECT * FROM Nurse WHERE NurseID = %s", (nurse_id,))
    nurse = cursor.fetchone()

    # Fetch doctor notes using the doctor_id and patient_id
    if doctor_id:
        cursor.execute("SELECT * FROM DoctorNotes WHERE DoctorID = %s AND PatientID = %s", (doctor_id, patient_id))
        doctor_notes = cursor.fetchall()
    else:
        doctor_notes = []

    cursor.execute("SELECT * FROM NurseNotes WHERE NurseID = %s AND PatientID = %s", (nurse_id, patient_id))
    nurse_notes = cursor.fetchall()

    connection.close()

    return render_template('final_doc_patients.html', patient=patient, nurse=nurse, nurse_notes=nurse_notes, doctor_notes=doctor_notes)
@app.route('/final_nurse_patients')
def final_nurse_patients():
    patient_id = request.args.get('patient_id')
    nurse_id = request.args.get('nurse_id')
    # doctor_id = request.args.get('doctor_id')

    # Fetch patient details using the patient_id
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Patient WHERE PatientID = %s", (patient_id,))
    patient = cursor.fetchone()

    # Fetch nurse details using the nurse_id
    cursor.execute("SELECT * FROM Nurse WHERE NurseID = %s", (nurse_id,))
    nurse = cursor.fetchone()

    # Fetch doctor details using the doctor_id
    # cursor.execute("SELECT * FROM Doctor WHERE DoctorID = %s", (doctor_id,))
    # doctor = cursor.fetchone()

    connection.close()

    # Pass the patient, nurse, and doctor details to the final_doc_patients.html template
    return render_template('final_nurse_patients.html', patient=patient, nurse=nurse)

@app.route('/doc_prescription/<patient_id>')
def doc_prescription(patient_id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    
    # Fetch medicine details based on patient ID
    cursor.execute("SELECT * FROM Pill WHERE PatientID = %s", (patient_id,))
    medicines = cursor.fetchall()  # Fetch all medicines for the patient
    
    connection.close()
    
    return render_template('doc_prescription.html', medicines=medicines)
@app.route('/doc_update/<patient_id>', methods=['GET', 'POST'])
def doc_update(patient_id):
    if request.method == 'POST':
        connection = get_db_connection()
        cursor = connection.cursor()

        # Get the number of pills submitted in the form
        num_pills = 1  # We assume only one pill for now

        # Get pill information from form
        pill_name = request.form['pill-name-1']
        pill_time = request.form['pill-time-1']
        pill_dosage = request.form['pill-dosage-1']
        pill_duration = request.form['pill-duration-1']

        # Insert pill information into the database
        cursor.execute("""
            INSERT INTO Pill (            PatientID, NumberOfPills, PillName, PillTime, PillDuration)
            VALUES (%s, %s, %s, %s, %s)
        """, (patient_id, pill_dosage, pill_name, pill_time, pill_duration))

        connection.commit()
        connection.close()

        return redirect(url_for('final_doc_patients', patient_id=patient_id))
    else:
        return render_template('doc_update.html', patient_id=patient_id)

@app.route('/doc_track/<patient_id>')
def doc_track(patient_id):
    # Fetch data from the Track table joined with the Pill table for the specified patient_id
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("""
        SELECT Track.*, Pill.PillName 
        FROM Track 
        JOIN Pill ON Track.PillID = Pill.PillID 
        WHERE Track.PatientID = %s
    """, (patient_id,))
    track_data = cursor.fetchall()
    connection.close()

    # Render the doc_track.html template with the fetched data
    return render_template('doc_track.html', track_data=track_data)

@app.route('/prescription')
def prescription():
    patient_id = request.args.get('patient_id')
    # Process prescription logic here...
    return redirect(url_for('doc_prescription', patient_id=patient_id))

@app.route('/update_prescription')
def update_prescription():
    patient_id = request.args.get('patient_id')
    # Process update prescription logic here...
    return redirect(url_for('doc_update', patient_id=patient_id))

@app.route('/track_activities')
def track_activities():
    patient_id = request.args.get('patient_id')
    # Process track activities logic here...
    return redirect(url_for('doc_track', patient_id=patient_id))
@app.route('/nurse_track')
def nurse_track():
    patient_id = request.args.get('patient_id')
    
    # Fetch pills from database for the given patient_id
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Pill WHERE PatientID = %s", (patient_id,))
    pills = cursor.fetchall()
    connection.close()
    
    return render_template('nurse_track.html', patient_id=patient_id, pills=pills)

@app.route('/track_pill', methods=['POST'])
def track_pill():
    pill_id = request.form.get('pill_id')
    patient_id = request.form.get('patient_id')
    pill_taken = request.form.get('pill_taken')
    image = request.files.get('image')

    connection = get_db_connection()
    cursor = connection.cursor()
    
    if pill_taken is not None:
        pill_taken = bool(int(pill_taken))
        cursor.execute("""
            INSERT INTO Track (Date, PillID, PatientID, Time, PillTakenOrNot)
            VALUES (%s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE PillTakenOrNot=%s, Time=%s
        """, (
            datetime.now().date(), pill_id, patient_id, datetime.now().time(),
            pill_taken, pill_taken, datetime.now().time()
        ))

    if image:
        image_path = f"uploads/{image.filename}"
        image.save(image_path)
        cursor.execute("""
            UPDATE Track SET Image = %s
            WHERE PillID = %s AND PatientID = %s AND Date = %s
        """, (image_path, pill_id, patient_id, datetime.now().date()))
    
    connection.commit()
    connection.close()

    return redirect(url_for('final_nurse_patients', patient_id=patient_id))

if __name__ == "__main__":
    app.run(debug=True)

