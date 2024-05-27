//equipoController.js

const db = require('../utils/db');
const path = require('path');

exports.createEquipo = (req, res) => {
  const { nombre_equipo } = req.body;
  const escudo = req.file ? req.file.filename : 'generic.jpg';

  db.query(
    'INSERT INTO equipos (nombre_equipo, escudo) VALUES (?, ?)',
    [nombre_equipo, `storage/img/escudos/${escudo}`],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.status(201).json({ message: 'Equipo created successfully' });
      }
    }
  );
};


exports.getAllEquipos = (req, res) => {
  db.query('SELECT * FROM equipos', (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else {
      res.json(results);
    }
  });
};

exports.getEquipoById = (req, res) => {
  const { id } = req.params;

  db.query('SELECT * FROM equipos WHERE id_equipo = ?', [id], (err, result) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else if (result.length === 0) {
      res.status(404).json({ error: 'Equipo not found' });
    } else {
      res.json(result[0]);
    }
  });
};
