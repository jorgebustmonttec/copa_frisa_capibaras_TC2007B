//partidoController.js
const db = require('../utils/db');

exports.getAllPartidos = (req, res) => {
    db.query('SELECT * FROM partidos', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos:', err);
            res.status(500).json({ error: 'Error al obtener partidos' });
        } else {
            res.json(results);
        }
    });
};

exports.getPartidoById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM partidos WHERE id_partido = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener el partido:', err);
            res.status(500).json({ error: 'Error al obtener el partido' });
        } else if (result.length === 0) {
            res.status(404).json({ error: 'Partido no encontrado' });
        } else {
            res.json(result[0]);
        }
    });
};

exports.getPastPartidos = (req, res) => {
    db.query('SELECT * FROM partidos WHERE fecha < now()', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos pasados:', err);
            res.status(500).json({ error: 'Error al obtener partidos pasados' });
        } else {
            res.json(results);
        }
    });
};

exports.getFuturePartidos = (req, res) => {
    db.query('SELECT * FROM partidos WHERE fecha >= now()', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos futuros:', err);
            res.status(500).json({ error: 'Error al obtener partidos futuros' });
        } else {
            res.json(results);
        }
    });
};


exports.createPartido = (req, res) => {
    const { equipo_a, equipo_b, fecha } = req.body;
    const id_copa = 1; // Assuming id_copa is always 1

    if (!equipo_a || !equipo_b || !fecha) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    // Convert fecha to MySQL datetime format
    const formattedFecha = new Date(fecha).toISOString().slice(0, 19).replace('T', ' ');

    db.query('INSERT INTO partidos (id_copa, equipo_a, equipo_b, fecha) VALUES (?, ?, ?, ?)', [id_copa, equipo_a, equipo_b, formattedFecha], (err, result) => {
        if (err) {
            console.error('Error al crear el partido:', err);
            res.status(500).json({ error: 'Error al crear el partido' });
        } else {
            res.status(201).json({ id_partido: result.insertId });
        }
    });
};
