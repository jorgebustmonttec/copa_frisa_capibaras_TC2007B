// equipoController.js

const db = require('../utils/db');
const path = require('path');


exports.createEquipo = (req, res) => {
  const { nombre_equipo, escuela } = req.body;
  const escudo = req.file ? req.file.filename : 'generic.jpg';

  db.query(
    'INSERT INTO equipos (nombre_equipo, escudo, escuela) VALUES (?, ?, ?)',
    [nombre_equipo, `storage/img/escudos/${escudo}`, escuela],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: 'Error al crear el equipo' });
      } else {
        res.status(201).json({ message: 'Equipo creado exitosamente' });
      }
    }
  );
};

exports.getAllEquipos = (req, res) => {
  db.query('SELECT id_equipo, nombre_equipo, escuela FROM equipos', (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Error al obtener los equipos' });
    } else {
      res.json(results);
    }
  });
};

exports.getEquipoById = (req, res) => {
  const { id } = req.params;

  db.query('SELECT * FROM equipos WHERE id_equipo = ?', [id], (err, result) => {
    if (err) {
      res.status(500).json({ error: 'Error al obtener el equipo' });
    } else if (result.length === 0) {
      res.status(404).json({ error: 'Equipo no encontrado' });
    } else {
      res.json(result[0]);
    }
  });
};
