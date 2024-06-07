//jugadorController.js


const db = require('../utils/db');
const path = require('path');
const fs = require('fs');
const bcrypt = require('bcryptjs');

const saltRounds = 10;

exports.createJugador = async (req, res) => {
  const { username, display_name, correo, password, fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo } = req.body;
  
  if (!username || !display_name || !correo || !password || !fecha_nac || !CURP || !domicilio || !telefono || !nombre || !apellido_p || !apellido_m || !num_imss || !id_equipo) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const userResult = await new Promise((resolve, reject) => {
      db.query(
        'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario, imagen, created_at) VALUES (?, ?, ?, ?, 2, "NA", NOW())',
        [username, display_name, correo, hashedPassword],
        (err, result) => {
          if (err) {
            console.error('Error al insertar en usuarios:', err);
            reject(new Error('Error en la base de datos al crear el usuario'));
          } else {
            resolve(result);
          }
        }
      );
    });

    const userId = userResult.insertId;

    await new Promise((resolve, reject) => {
      db.query(
        'INSERT INTO jugadores (fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_usuario, id_equipo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, userId, id_equipo],
        (err, result) => {
          if (err) {
            console.error('Error al insertar en jugadores:', err);
            reject(new Error('Error en la base de datos al crear el jugador'));
          } else {
            resolve(result);
          }
        }
      );
    });

    res.status(201).json({ message: 'Cuenta de jugador creada exitosamente' });
  } catch (err) {
    console.error('Error:', err);
    res.status(500).json({ error: err.message });
  }
};

exports.getAllJugadoresSmall = (req, res) => {
  db.query(
    `SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, 
            COALESCE(equipos.nombre_equipo, 'Sin Equipo') AS nombre_equipo, 
            usuarios.username, usuarios.display_name 
     FROM jugadores 
     LEFT JOIN equipos ON jugadores.id_equipo = equipos.id_equipo 
     JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario`,
    (err, results) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.json(results);
      }
    }
  );
};

exports.getJugadorSmallById = (req, res) => {
  const { id } = req.params;
  db.query(
    `SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, 
            COALESCE(equipos.nombre_equipo, 'Sin Equipo') AS nombre_equipo, 
            usuarios.username, usuarios.display_name 
     FROM jugadores 
     LEFT JOIN equipos ON jugadores.id_equipo = equipos.id_equipo 
     JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario 
     WHERE jugadores.id_jugador = ?`,
    [id],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else if (result.length === 0) {
        res.status(404).json({ error: 'Jugador no encontrado' });
      } else {
        res.json(result[0]);
      }
    }
  );
};


exports.addJugadorToEquipo = (req, res) => {
  const { id_jugador, id_equipo } = req.body;

  db.query(
    'UPDATE jugadores SET id_equipo = ? WHERE id_jugador = ?',
    [id_equipo, id_jugador],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else if (result.affectedRows === 0) {
        res.status(404).json({ error: 'Jugador no encontrado' });
      } else {
        res.status(200).json({ message: 'Jugador agregado al equipo exitosamente' });
      }
    }
  );
};

exports.removeJugadorFromEquipo = (req, res) => {
  const { id_jugador } = req.body;

  db.query(
    'UPDATE jugadores SET id_equipo = NULL WHERE id_jugador = ?',
    [id_jugador],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else if (result.affectedRows === 0) {
        res.status(404).json({ error: 'Jugador no encontrado' });
      } else {
        res.status(200).json({ message: 'Jugador removido del equipo exitosamente' });
      }
    }
  );
};
