CREATE DATABASE sistema_diagnostico;

USE sistema_diagnostico;

-- Tabla de Síntomas
CREATE TABLE sintomas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla de Enfermedades
CREATE TABLE enfermedades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tratamiento_medico TEXT,
    tratamiento_alternativo TEXT
);

-- Tabla de Reglas (relaciona síntomas con enfermedades)
CREATE TABLE reglas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sintoma_id INT,
    enfermedad_id INT,
    FOREIGN KEY (sintoma_id) REFERENCES sintomas(id),
    FOREIGN KEY (enfermedad_id) REFERENCES enfermedades(id)
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL  -- Para definir si es admin o usuario
);

-- Insertar el administrador con las credenciales proporcionadas
INSERT INTO usuarios (email, password, role) VALUES 
('prueba@admin.com', 'prueba123', 'admin');

-- Insertar un usuario de ejemplo
INSERT INTO usuarios (email, password, role) VALUES 
('usuario@ejemplo.com', 'usuario123', 'usuario');
usuarios
-- Población de la tabla de síntomas
INSERT INTO sintomas (nombre) VALUES
('congestión nasal'),
('diarrea'),
('dolor abdominal'),
('dolor articular'),
('dolor de cabeza'),
('dolor de garganta'),
('dolor muscular'),
('dolor en el pecho'),
('dolor al orinar'),
('dificultad para respirar'),
('dificultad para tragar'),
('escalofríos'),
('erupciones cutáneas'),
('fiebre'),
('fatiga'),
('falta de apetito'),
('frecuencia urinaria'),
('ictericia'),
('indigestión'),
('mareo'),
('náuseas'),
('ojos llorosos'),
('picazón'),
('presión facial'),
('pérdida del gusto'),
('pérdida del olfato'),
('ronquera'),
('silbido en el pecho'),
('sudoración excesiva'),
('sudoración nocturna'),
('sequedad de la piel');

-- Población de la tabla de enfermedades
INSERT INTO enfermedades (nombre, tratamiento_medico, tratamiento_alternativo) VALUES
('COVID-19', 'Medicamentos antivirales como Remdesivir o Favipiravir, oxígeno si es necesario, monitorización constante en hospital', 'Descanso completo, mantener una buena hidratación, cuidado intensivo en hospitales si es necesario'),
('Resfriado', 'Paracetamol o Ibuprofeno para reducir fiebre y dolor, líquidos abundantes, reposo', 'Infusión de jengibre con miel para la garganta, té caliente, descanso adecuado'),
('Gripe', 'Antivirales como Oseltamivir, descanso absoluto, líquidos para mantener la hidratación', 'Té de eucalipto con miel y limón para aliviar la garganta, descanso en un ambiente cálido'),
('Alergia', 'Antihistamínicos como Loratadina, sprays nasales para congestión', 'Té de manzanilla, evitar alergenos conocidos, mantener el ambiente libre de polvo y polen'),
('Bronquitis', 'Antibióticos como Amoxicilina o Azitromicina, medicamentos para la tos como Dextrometorfano', 'Inhalación de vapor con eucalipto, descanso absoluto, mantener el ambiente con alta humedad'),
('Asma', 'Inhaladores de broncodilatadores como Salbutamol o formoterol, corticosteroides inhalados', 'Terapias respiratorias, evitar alérgenos, realizar ejercicios respiratorios como la respiración diafragmática'),
('Faringitis', 'Antibióticos si es bacteriana (Amoxicilina), analgésicos como Paracetamol para aliviar el dolor', 'Gárgaras con agua salada tibia, té de miel y jengibre, evitar irritantes como el humo'),
('Laringitis', 'Reposo vocal completo, analgésicos como Paracetamol o Ibuprofeno', 'Té de jengibre con miel, vapor de agua caliente para aliviar la inflamación de las cuerdas vocales'),
('Neumonía', 'Antibióticos intravenosos en hospitalización (como Ceftriaxona o Levofloxacina), oxígeno si es necesario', 'Descanso absoluto, mantener líquidos, inhalación de vapor con eucalipto para descongestionar las vías respiratorias'),
('Sinusitis', 'Antibióticos como Amoxicilina o Doxiciclina, descongestionantes nasales', 'Té de menta y eucalipto, inhalación de vapor con eucalipto, humidificador en el cuarto'),
('Apendicitis', 'Cirugía urgente para extirpación del apéndice (apendicectomía)', 'No se recomienda tratamiento alternativo, es una condición quirúrgica'),
('Gastritis', 'Medicamentos antiácidos como Omeprazol, dieta blanda, evitar irritantes como el alcohol', 'Té de manzanilla o menta, evitar alimentos picantes o ácidos'),
('Migraña', 'Analgesicos como Ibuprofeno, medicamentos para la migraña como Triptanos', 'Té de jengibre, descansar en un lugar oscuro y silencioso, técnicas de relajación como yoga'),
('Infección urinaria', 'Antibióticos como Nitrofurantoína o Ciprofloxacina', 'Beber mucho líquido, té de arándano o jugo de arándano para prevenir infecciones recurrentes'),
('Hepatitis', 'Antivirales como Sofosbuvir, tratamiento de apoyo para mejorar los síntomas', 'Descanso adecuado, dieta saludable rica en antioxidantes y baja en grasas'),
('Tuberculosis', 'Tratamiento con antibióticos como Rifampicina, Isoniazida, y Pirazinamida durante un período largo', 'Aumentar la ingesta de líquidos, descanso adecuado, alimentos ricos en vitaminas'),
('Cólera', 'Rehidratación oral con solución de sales, antibióticos si es necesario (Tetraciclina)', 'Beber líquidos con sales de rehidratación oral, evitar alimentos crudos, descanso'),
('Mononucleosis', 'Medicamentos para aliviar los síntomas, reposo total', 'Té de menta, descanso, mantener una dieta nutritiva y adecuada'),
('Escarlatina', 'Antibióticos como Penicilina, tratamiento sintomático como analgésicos', 'Descanso, beber líquidos, evitar contacto con otras personas'),
('Varicela', 'Antihistamínicos como Loratadina para aliviar la picazón, medicamentos para fiebre como Paracetamol', 'Baños de avena, evitar rascarse las erupciones, aplicar cremas hidratantes'),
('Rubéola', 'Tratamiento sintomático para fiebre y dolor, vacuna contra la rubéola (si es en adultos)', 'Té de manzanilla, evitar el contacto cercano con otras personas para prevenir la transmisión'),
('Meningitis', 'Antibióticos o antivirales específicos según la causa, hospitalización', 'No se recomienda tratamiento alternativo, la meningitis requiere atención médica urgente'),
('Tifoidea', 'Antibióticos como Ciprofloxacina o Azitromicina, reposo', 'Beber líquidos, evitar alimentos crudos, descansar adecuadamente'),
('Sarna', 'Crema antimicrobiana como Permetrina, medicamentos para la picazón como Hidrocortisona', 'Baños de avena, mantener la piel hidratada con cremas humectantes'),
('Zika', 'Tratamiento sintomático con paracetamol para fiebre y dolor', 'Descanso, mantenerse hidratado, evitar la picazón con cremas calmantes'),
('Chikungunya', 'Tratamiento sintomático con analgésicos como Paracetamol', 'Descanso, mantenerse hidratado, evitar la exposición a más picaduras de mosquitos'),
('Eczema', 'Cremas hidratantes, esteroides tópicos como Hidrocortisona', 'Baños de avena para aliviar la picazón, evitar el contacto con irritantes como jabones fuertes');

-- Población de la tabla de reglas (relacionando síntomas con enfermedades)
-- Población de la tabla de reglas (relacionando síntomas con enfermedades más específicas)
INSERT INTO reglas (sintoma_id, enfermedad_id) VALUES
  -- COVID-19 (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'tos'), (SELECT id FROM enfermedades WHERE nombre = 'COVID-19')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'COVID-19')),
  ((SELECT id FROM sintomas WHERE nombre = 'perdida del gusto'), (SELECT id FROM enfermedades WHERE nombre = 'COVID-19')),
  ((SELECT id FROM sintomas WHERE nombre = 'dificultad para respirar'), (SELECT id FROM enfermedades WHERE nombre = 'COVID-19')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'COVID-19')),

  -- Resfriado (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'tos'), (SELECT id FROM enfermedades WHERE nombre = 'Resfriado')),
  ((SELECT id FROM sintomas WHERE nombre = 'congestion nasal'), (SELECT id FROM enfermedades WHERE nombre = 'Resfriado')),
  ((SELECT id FROM sintomas WHERE nombre = 'escalofríos'), (SELECT id FROM enfermedades WHERE nombre = 'Resfriado')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'Resfriado')),

  -- Gripe (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Gripe')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor muscular'), (SELECT id FROM enfermedades WHERE nombre = 'Gripe')),
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Gripe')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de cabeza'), (SELECT id FROM enfermedades WHERE nombre = 'Gripe')),

  -- Alergia (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'congestion nasal'), (SELECT id FROM enfermedades WHERE nombre = 'Alergia')),
  ((SELECT id FROM sintomas WHERE nombre = 'ojos llorosos'), (SELECT id FROM enfermedades WHERE nombre = 'Alergia')),

  -- Bronquitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'tos'), (SELECT id FROM enfermedades WHERE nombre = 'Bronquitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'dificultad para respirar'), (SELECT id FROM enfermedades WHERE nombre = 'Bronquitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Bronquitis')),

  -- Asma (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dificultad para respirar'), (SELECT id FROM enfermedades WHERE nombre = 'Asma')),
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Asma')),
  ((SELECT id FROM sintomas WHERE nombre = 'silbido en el pecho'), (SELECT id FROM enfermedades WHERE nombre = 'Asma')),

  -- Faringitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'Faringitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Faringitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'dificultad para tragar'), (SELECT id FROM enfermedades WHERE nombre = 'Faringitis')),

  -- Laringitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'Laringitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'tos'), (SELECT id FROM enfermedades WHERE nombre = 'Laringitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'ronquera'), (SELECT id FROM enfermedades WHERE nombre = 'Laringitis')),

  -- Neumonía (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dificultad para respirar'), (SELECT id FROM enfermedades WHERE nombre = 'Neumonía')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Neumonía')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor en el pecho'), (SELECT id FROM enfermedades WHERE nombre = 'Neumonía')),

  -- Sinusitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de cabeza'), (SELECT id FROM enfermedades WHERE nombre = 'Sinusitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'presión facial'), (SELECT id FROM enfermedades WHERE nombre = 'Sinusitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'congestion nasal'), (SELECT id FROM enfermedades WHERE nombre = 'Sinusitis')),

  -- Apendicitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor abdominal'), (SELECT id FROM enfermedades WHERE nombre = 'Apendicitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Apendicitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'falta de apetito'), (SELECT id FROM enfermedades WHERE nombre = 'Apendicitis')),

  -- Gastritis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor abdominal'), (SELECT id FROM enfermedades WHERE nombre = 'Gastritis')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Gastritis')),
  ((SELECT id FROM sintomas WHERE nombre = 'indigestión'), (SELECT id FROM enfermedades WHERE nombre = 'Gastritis')),

  -- Migraña (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de cabeza'), (SELECT id FROM enfermedades WHERE nombre = 'Migraña')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Migraña')),
  ((SELECT id FROM sintomas WHERE nombre = 'sensibilidad a la luz'), (SELECT id FROM enfermedades WHERE nombre = 'Migraña')),

  -- Infección urinaria (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor abdominal'), (SELECT id FROM enfermedades WHERE nombre = 'Infección urinaria')),
  ((SELECT id FROM sintomas WHERE nombre = 'frecuencia urinaria'), (SELECT id FROM enfermedades WHERE nombre = 'Infección urinaria')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor al orinar'), (SELECT id FROM enfermedades WHERE nombre = 'Infección urinaria')),

  -- Hepatitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Hepatitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Hepatitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'ictericia'), (SELECT id FROM enfermedades WHERE nombre = 'Hepatitis')),

  -- Tuberculosis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'tos'), (SELECT id FROM enfermedades WHERE nombre = 'Tuberculosis')),
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Tuberculosis')),
  ((SELECT id FROM sintomas WHERE nombre = 'sudoración nocturna'), (SELECT id FROM enfermedades WHERE nombre = 'Tuberculosis')),

  -- Cólera (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'diarrea'), (SELECT id FROM enfermedades WHERE nombre = 'Cólera')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Cólera')),
  ((SELECT id FROM sintomas WHERE nombre = 'vómito'), (SELECT id FROM enfermedades WHERE nombre = 'Cólera')),

  -- Mononucleosis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'fatiga'), (SELECT id FROM enfermedades WHERE nombre = 'Mononucleosis')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'Mononucleosis')),
  ((SELECT id FROM sintomas WHERE nombre = 'ganglios inflamados'), (SELECT id FROM enfermedades WHERE nombre = 'Mononucleosis')),

  -- Escarlatina (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de garganta'), (SELECT id FROM enfermedades WHERE nombre = 'Escarlatina')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Escarlatina')),
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Escarlatina')),

  -- Varicela (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Varicela')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Varicela')),
  ((SELECT id FROM sintomas WHERE nombre = 'picazón'), (SELECT id FROM enfermedades WHERE nombre = 'Varicela')),

  -- Rubéola (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Rubéola')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Rubéola')),

  -- Meningitis (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'dolor de cabeza'), (SELECT id FROM enfermedades WHERE nombre = 'Meningitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Meningitis')),
  ((SELECT id FROM sintomas WHERE nombre = 'rigidez en el cuello'), (SELECT id FROM enfermedades WHERE nombre = 'Meningitis')),

  -- Tifoidea (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'diarrea'), (SELECT id FROM enfermedades WHERE nombre = 'Tifoidea')),
  ((SELECT id FROM sintomas WHERE nombre = 'náuseas'), (SELECT id FROM enfermedades WHERE nombre = 'Tifoidea')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor abdominal'), (SELECT id FROM enfermedades WHERE nombre = 'Tifoidea')),

  -- Sarna (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Sarna')),
  ((SELECT id FROM sintomas WHERE nombre = 'picazón'), (SELECT id FROM enfermedades WHERE nombre = 'Sarna')),

  -- Zika (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Zika')),
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Zika')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor articular'), (SELECT id FROM enfermedades WHERE nombre = 'Zika')),

  -- Chikungunya (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'fiebre'), (SELECT id FROM enfermedades WHERE nombre = 'Chikungunya')),
  ((SELECT id FROM sintomas WHERE nombre = 'dolor muscular'), (SELECT id FROM enfermedades WHERE nombre = 'Chikungunya')),

  -- Eczema (más específico)
  ((SELECT id FROM sintomas WHERE nombre = 'erupciones cutáneas'), (SELECT id FROM enfermedades WHERE nombre = 'Eczema')),
  ((SELECT id FROM sintomas WHERE nombre = 'picazón'), (SELECT id FROM enfermedades WHERE nombre = 'Eczema')),
  ((SELECT id FROM sintomas WHERE nombre = 'sequedad de la piel'), (SELECT id FROM enfermedades WHERE nombre = 'Eczema'));
  
