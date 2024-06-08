// equipoController.js
const db = require('../utils/db');
const path = require('path');
const fs = require('fs');


exports.getAllEquipos = (req, res) => {
    db.query('SELECT id_equipo, nombre_equipo, escuela FROM equipos', (err, results) => {
        if (err) {
            console.error('Error al obtener equipos:', err);
            res.status(500).json({ error: 'Error al obtener equipos' });
        } else {
            res.json(results);
        }
    });
};

exports.getEquipoById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT id_equipo, nombre_equipo, escuela FROM equipos WHERE id_equipo = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener el equipo:', err);
            res.status(500).json({ error: 'Error al obtener el equipo' });
        } else if (result.length === 0) {
            res.status(404).json({ error: 'Equipo no encontrado' });
        } else {
            res.json(result[0]);
        }
    });
};

exports.getEquipoShieldById = (req, res) => {
  const { id } = req.params;
  db.query('SELECT escudo FROM equipos WHERE id_equipo = ?', [id], (err, result) => {
      if (err) {
          console.error('Error al obtener el escudo del equipo:', err);
          return res.status(500).json({ error: 'Error al obtener el escudo del equipo' });
      } else if (result.length === 0) {
          return res.status(404).json({ error: 'Equipo no encontrado' });
      } else {
          const escudoPath = result[0].escudo;
          const absolutePath = path.resolve(process.cwd(), escudoPath);
          res.sendFile(absolutePath, (err) => {
              if (err) {
                  console.error('Error al enviar el archivo:', err);
                  if (!res.headersSent) {
                      return res.status(500).json({ error: 'Error al enviar el archivo' });
                  }
              }
          });
      }
  });
};

exports.createEquipo = (req, res) => {
  const { nombre_equipo, escuela } = req.body;
  if (!nombre_equipo || !escuela) {
      return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  db.query('INSERT INTO equipos (nombre_equipo, escuela) VALUES (?, ?)', [nombre_equipo, escuela], (err, result) => {
      if (err) {
          console.error('Error al crear el equipo:', err);
          res.status(500).json({ error: 'Error al crear el equipo' });
      } else {
          res.status(201).json({ id_equipo: result.insertId });
      }
  });
};
exports.addEquipoImg = (req, res) => {
  const { id } = req.params;
  const escudo = req.file ? req.file.path : null;

  if (!escudo) {
      return res.status(400).json({ error: 'No se proporcionó ninguna imagen' });
  }

  const relativePath = path.relative(process.cwd(), escudo).replace(/^API[\\/]/, ''); // Remove 'API/' prefix

  db.query('UPDATE equipos SET escudo = ? WHERE id_equipo = ?', [relativePath, id], (err, result) => {
      if (err) {
          console.error('Error al actualizar el escudo del equipo:', err);
          return res.status(500).json({ error: 'Error al actualizar el escudo del equipo' });
      } else if (result.affectedRows === 0) {
          return res.status(404).json({ error: 'Equipo no encontrado' });
      } else {
          res.status(200).json({ message: 'Escudo del equipo actualizado exitosamente' });
      }
  });
};