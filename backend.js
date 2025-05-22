const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
app.use(bodyParser.json());

// Servir archivos estáticos desde la carpeta 'public'
app.use(express.static('public'));

// Conexión a la base de datos MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root', // Usuario de MySQL
    password: 'ROOT', // Contraseña de MySQL
    database: 'sistema_diagnostico' // Nombre de la base de datos
});

// Conectar a MySQL
connection.connect((err) => {
    if (err) {
        console.error('Error de conexión: ' + err.stack);
        return;
    }
    console.log('Conectado a la base de datos con id ' + connection.threadId);
});


// Ruta para la raíz del servidor
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

// Ruta para el login (si es necesario)
app.get("/login.html", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.post('/diagnosticar', (req, res) => {
    const sintomasSeleccionados = req.body.sintomas;

    if (!sintomasSeleccionados || sintomasSeleccionados.length === 0) {
        return res.status(400).json({ message: 'No se recibieron síntomas' });
    }

    // Consulta para obtener cuántos síntomas tiene cada enfermedad y cuántos coinciden con los seleccionados
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

        // Calculamos la probabilidad
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

        if (diagnostico.length > 0) {
            res.json({ diagnostico });
        } else {
            res.json({ message: 'No se encontró un diagnóstico basado en los síntomas seleccionados.' });
        }
    });
});





// Ruta para agregar un síntoma (solo para admin)
app.post('/admin/addSymptom', (req, res) => {
    const { nombre } = req.body;

    const query = `INSERT INTO sintomas (nombre) VALUES (?)`;
    connection.query(query, [nombre], (err, result) => {
        if (err) {
            return res.status(500).json({ message: 'Error al agregar el síntoma' });
        }
        res.status(200).json({ message: 'Síntoma agregado correctamente' });
    });
});

// Ruta para agregar una enfermedad (solo para admin)
app.post('/admin/addDisease', (req, res) => {
    const { nombre, tratamiento_medico, tratamiento_alternativo } = req.body;

    const query = `INSERT INTO enfermedades (nombre, tratamiento_medico, tratamiento_alternativo) VALUES (?, ?, ?)`;
    connection.query(query, [nombre, tratamiento_medico, tratamiento_alternativo], (err, result) => {
        if (err) {
            return res.status(500).json({ message: 'Error al agregar la enfermedad' });
        }
        res.status(200).json({ message: 'Enfermedad agregada correctamente' });
    });
});

// Ruta para agregar relación entre síntomas y enfermedades (solo para admin)
app.post('/admin/linkSymptomToDisease', (req, res) => {
    const { sintoma_id, enfermedad_id } = req.body;

    const query = `INSERT INTO reglas (sintoma_id, enfermedad_id) VALUES (?, ?)`;
    connection.query(query, [sintoma_id, enfermedad_id], (err, result) => {
        if (err) {
            return res.status(500).json({ message: 'Error al relacionar síntoma con enfermedad' });
        }
        res.status(200).json({ message: 'Relación agregada correctamente' });
    });
});

// Ruta para obtener todos los síntomas
app.get('/admin/getSymptoms', (req, res) => {
    const query = 'SELECT * FROM sintomas';
    connection.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error al obtener los síntomas' });
        }
        res.json({ sintomas: results });
    });
});

// Ruta para obtener todas las enfermedades
app.get('/admin/getDiseases', (req, res) => {
    const query = 'SELECT * FROM enfermedades';
    connection.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error al obtener las enfermedades' });
        }
        res.json({ enfermedades: results });
    });
});

// Ruta para servir el frontend (cuando el administrador quiere acceder)
app.get('/admin', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'admin.html'));
});


// Ruta para la autenticación de login (para todos los roles)
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    const query = 'SELECT * FROM usuarios WHERE email = ? AND password = ?';
    connection.query(query, [email, password], (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error en la consulta de autenticación' });
        }

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




// Configura el puerto donde se escuchará el servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
