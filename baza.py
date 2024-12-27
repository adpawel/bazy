import random
import datetime

# Generating the SQL file content
output_path = "medical_database_export.sql"

# Helper functions for generating random data
def random_date(start, end):
    """Generate a random datetime between `start` and `end`."""
    return start + datetime.timedelta(seconds=random.randint(0, int((end - start).total_seconds())))


def random_string(length):
    """Generate a random string of fixed length."""
    return ''.join(random.choices("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", k=length))

def random_pesel():
    """Generate a random valid PESEL."""
    year = random.randint(1900, 2023)
    month = random.randint(1, 12)
    day = random.randint(1, 28)  # Simplified for demo
    serial = random.randint(1000, 9999)
    return f"{year % 100:02}{month:02}{day:02}{serial:04}"

# Basic SQL definitions for tables
sql_statements = """
-- Tabela pacjenci
CREATE TABLE pacjenci (
    id_pacjenta INTEGER PRIMARY KEY,
    nazwa VARCHAR(130) NOT NULL,
    data_urodzenia DATE NOT NULL,
    pesel CHARACTER(11) NOT NULL
);

-- Tabela lekarze
CREATE TABLE lekarze (
    id_lekarza INTEGER PRIMARY KEY,
    nazwa VARCHAR(130) NOT NULL,
    specjalizacje VARCHAR[] NOT NULL
);

-- Tabela konsultacje
CREATE TABLE konsultacje (
    id_konsultacji INTEGER PRIMARY KEY,
    id_lekarza INTEGER NOT NULL REFERENCES lekarze(id_lekarza),
    id_pacjenta INTEGER REFERENCES pacjenci(id_pacjenta),
    termin TIMESTAMP NOT NULL,
    specjalizacja VARCHAR(30) NOT NULL,
    cena NUMERIC(7,2) NOT NULL,
    zrealizowana BOOLEAN NOT NULL DEFAULT FALSE
);

-- Tabela badania
CREATE TABLE badania (
    id_badania INTEGER PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    cena NUMERIC(7,2) NOT NULL,
    na_czczo BOOLEAN NOT NULL
);

-- Tabela zlecenia
CREATE TABLE zlecenia (
    id_zlecenia INTEGER PRIMARY KEY,
    id_pacjenta INTEGER NOT NULL REFERENCES pacjenci(id_pacjenta),
    id_lekarza INTEGER NOT NULL REFERENCES lekarze(id_lekarza),
    id_badania INTEGER NOT NULL REFERENCES badania(id_badania),
    data_wystawienia DATE NOT NULL,
    data_realizacji DATE
);
"""

# Populating tables with sample data
# Pacjenci
patients = []
for i in range(1, 101):
    name = f"Pacjent_{i}"
    birth_date = random_date(datetime.date(1940, 1, 1), datetime.date(2010, 1, 1))
    pesel = random_pesel()
    patients.append(f"({i}, '{name}', '{birth_date}', '{pesel}')")

sql_statements += "\n-- Wstawianie danych do pacjenci\n"
sql_statements += "INSERT INTO pacjenci (id_pacjenta, nazwa, data_urodzenia, pesel) VALUES\n"
sql_statements += ",\n".join(patients) + ";\n"

# Lekarze
doctors = []
specializations = ["dermatolog", "chirurg", "kardiolog", "neurolog", "okulista"]
for i in range(1, 21):
    name = f"Lekarz_{i}"
    specs = "{" + ", ".join(random.sample(specializations, random.randint(1, 3))) + "}"
    doctors.append(f"({i}, '{name}', '{specs}')")

sql_statements += "\n-- Wstawianie danych do lekarze\n"
sql_statements += "INSERT INTO lekarze (id_lekarza, nazwa, specjalizacje) VALUES\n"
sql_statements += ",\n".join(doctors) + ";\n"

# Badania
tests = [
    "(1, 'Morfologia', 20.00, TRUE)",
    "(2, 'CRP', 30.00, TRUE)",
    "(3, 'Rezonans Magnetyczny', 500.00, FALSE)",
    "(4, 'Glukoza', 15.00, TRUE)",
    "(5, 'Żelazo', 25.00, TRUE)"
]

sql_statements += "\n-- Wstawianie danych do badania\n"
sql_statements += "INSERT INTO badania (id_badania, nazwa, cena, na_czczo) VALUES\n"
sql_statements += ",\n".join(tests) + ";\n"

# Konsultacje
consultations = []
for i in range(1, 201):
    doctor_id = random.randint(1, 20)
    patient_id = random.choice([None, random.randint(1, 100)])  # Nullable for free slots
    spec = random.choice(specializations)
    date_time = random_date(datetime.datetime(2024, 1, 1), datetime.datetime(2025, 12, 31))
    price = round(random.uniform(100, 300), 2)
    done = random.choice(["TRUE", "FALSE"])
    patient_ref = f"{patient_id}" if patient_id else "NULL"
    consultations.append(f"({i}, {doctor_id}, {patient_ref}, '{date_time}', '{spec}', {price}, {done})")

sql_statements += "\n-- Wstawianie danych do konsultacje\n"
sql_statements += "INSERT INTO konsultacje (id_konsultacji, id_lekarza, id_pacjenta, termin, specjalizacja, cena, zrealizowana) VALUES\n"
sql_statements += ",\n".join(consultations) + ";\n"

# Zlecenia
orders = []
for i in range(1, 301):
    patient_id = random.randint(1, 100)
    doctor_id = random.randint(1, 20)
    test_id = random.randint(1, 5)
    issue_date = random_date(datetime.date(2024, 1, 1), datetime.date(2025, 12, 31))
    realization_date = random.choice(["NULL", f"'{random_date(issue_date, datetime.date(2025, 12, 31))}'"])
    orders.append(f"({i}, {patient_id}, {doctor_id}, {test_id}, '{issue_date}', {realization_date})")

sql_statements += "\n-- Wstawianie danych do zlecenia\n"
sql_statements += "INSERT INTO zlecenia (id_zlecenia, id_pacjenta, id_lekarza, id_badania, data_wystawienia, data_realizacji) VALUES\n"
sql_statements += ",\n".join(orders) + ";\n"

# Writing to the file
with open(output_path, "w") as f:
    f.write(sql_statements)

output_path
