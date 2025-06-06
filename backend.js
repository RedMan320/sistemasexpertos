require('dotenv').config();
console.log("📦 Cargando variables desde .env:");
console.log("HOST:", process.env.HOST);
console.log("USER:", process.env.USER);
console.log("PASSWORD:", process.env.PASSWORD);
console.log("DATABASE:", process.env.DATABASE);
console.log("DBPORT:", process.env.DBPORT);

const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
app.use(bodyParser.json());

// Servir archivos estáticos desde 'public'
app.use(express.static(path.join(__dirname, 'public')));

// 🔌 Conexión a MySQL en Railway
const connection = mysql.createConnection({
    host: process.env.HOST || 'mysql.railway.internal',
    user: process.env.USER || 'root',
    password: process.env.PASSWORD,
    database: process.env.DATABASE || 'railway',
    port: process.env.DBPORT || 3306,
    ssl: { rejectUnauthorized: false }
});

connection.connect(err => {
    if (err) {
        console.error('❌ Error de conexión a Railway:', err.stack);
        return;
    }
    console.log('✅ Conectado a Railway con id ' + connection.threadId);
});

// 🔁 Redirigir la raíz al login.html
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.get("/login.html", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.post('/diagnosticar', (req, res) => {
    const sintomasSeleccionados = req.body.sintomas;

    if (!sintomasSeleccionados || sintomasSeleccionados.length === 0) {
        return res.status(400).json({ message: 'No se recibieron síntomas' });
    }

    const query = `
        SELECT 
            e.id AS enfermedad_id,
            e.nombre AS enfermedad,
            e.tratamiento_medico,
            e.tratamiento_alternativo,
            COUNT(DISTINCT CASE WHEN s.nombre IN (?) THEN s.id END) AS coincidencias,
            COUNT(DISTINCT s.id) AS total_sintomas
        FROM enfermedades e
        JOIN reglas r ON e.id = r.enfermedad_id
        JOIN sintomas s ON r.sintoma_id = s.id
        GROUP BY e.id
        HAVING coincidencias > 0
        ORDER BY coincidencias DESC
    `;

    connection.query(query, [sintomasSeleccionados], (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error al realizar la consulta' });
        }

        const diagnostico = results.map(row => {
            const probabilidad = ((row.coincidencias / row.total_sintomas) * 100).toFixed(1);
            return {
                enfermedad: row.enfermedad,
                tratamiento_medico: row.tratamiento_medico,
                tratamiento_alternativo: row.tratamiento_alternativo,
                coincidencias: row.coincidencias,
                total_sintomas: row.total_sintomas,
                probabilidad: probabilidad + '%'
            };
        });

        res.json({ diagnostico });
    });
});

// Admin: agregar síntoma
app.post('/admin/addSymptom', (req, res) => {
    const { nombre } = req.body;
    const query = `INSERT INTO sintomas (nombre) VALUES (?)`;
    connection.query(query, [nombre], (err) => {
        if (err) return res.status(500).json({ message: 'Error al agregar el síntoma' });
        res.status(200).json({ message: 'Síntoma agregado correctamente' });
    });
});

// Admin: agregar enfermedad
app.post('/admin/addDisease', (req, res) => {
    const { nombre, tratamiento_medico, tratamiento_alternativo } = req.body;
    const query = `INSERT INTO enfermedades (nombre, tratamiento_medico, tratamiento_alternativo) VALUES (?, ?, ?)`;
    connection.query(query, [nombre, tratamiento_medico, tratamiento_alternativo], (err) => {
        if (err) return res.status(500).json({ message: 'Error al agregar la enfermedad' });
        res.status(200).json({ message: 'Enfermedad agregada correctamente' });
    });
});

// Admin: vincular síntoma a enfermedad
app.post('/admin/linkSymptomToDisease', (req, res) => {
    const { sintoma_id, enfermedad_id } = req.body;
    const query = `INSERT INTO reglas (sintoma_id, enfermedad_id) VALUES (?, ?)`;
    connection.query(query, [sintoma_id, enfermedad_id], (err) => {
        if (err) return res.status(500).json({ message: 'Error al relacionar síntoma con enfermedad' });
        res.status(200).json({ message: 'Relación agregada correctamente' });
    });
});

// Admin: obtener síntomas
app.get('/admin/getSymptoms', (req, res) => {
    const query = 'SELECT * FROM sintomas';
    connection.query(query, (err, results) => {
        if (err) return res.status(500).json({ message: 'Error al obtener los síntomas' });
        res.json({ sintomas: results });
    });
});

// Admin: obtener enfermedades
app.get('/admin/getDiseases', (req, res) => {
    const query = 'SELECT * FROM enfermedades';
    connection.query(query, (err, results) => {
        if (err) return res.status(500).json({ message: 'Error al obtener las enfermedades' });
        res.json({ enfermedades: results });
    });
});

// Ruta del panel admin
app.get('/admin', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'admin.html'));
});

// Ruta de login
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const query = 'SELECT * FROM usuarios WHERE email = ? AND password = ?';
    connection.query(query, [email, password], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error en la consulta de autenticación' });
        if (results.length > 0) {
            const user = results[0];
            if (user.role === 'admin') {
                res.status(200).json({ message: 'Autenticación exitosa', redirectTo: '/admin' });
            } else if (user.role === 'usuario') {
                res.status(200).json({ message: 'Autenticación exitosa', redirectTo: '/frontend.html' });
            } else {
                res.status(401).json({ message: 'Rol no autorizado' });
            }
        } else {
            res.status(401).json({ message: 'Credenciales incorrectas' });
        }
    });
});

// 🟢 Escucha en el puerto que Render asigne dinámicamente
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

