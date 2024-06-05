//jugadorController.js

const db = require('../utils/db');
const path = require('path');

const fs = require('fs');
const bcrypt = require('bcryptjs');
const saltRounds = 10;

exports.createJugador = async (req, res) => {
  const { username, display_name, correo, password, fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo } = req.body;
  
  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Insert into usuarios table
    const userResult = await new Promise((resolve, reject) => {
      db.query(
        'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario, imagen, created_at) VALUES (?, ?, ?, ?, 2, "NA", NOW())',
        [username, display_name, correo, hashedPassword],
        (err, result) => {
          if (err) reject(err);
          else resolve(result);
        }
      );
    });

    const userId = userResult.insertId;

    // Insert into jugadores table
    await new Promise((resolve, reject) => {
      db.query(
        'INSERT INTO jugadores (fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_usuario, id_equipo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, userId, id_equipo],
        (err, result) => {
          if (err) reject(err);
          else resolve(result);
        }
      );
    });

    res.status(201).json({ message: 'Jugador account created successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getAllJugadoresSmall = (req, res) => {
  db.query(
    'SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, equipos.nombre_equipo, usuarios.username, usuarios.display_name FROM jugadores JOIN equipos ON jugadores.id_equipo = equipos.id_equipo JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario',
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
    'SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, equipos.nombre_equipo, usuarios.username, usuarios.display_name FROM jugadores JOIN equipos ON jugadores.id_equipo = equipos.id_equipo JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario WHERE jugadores.id_jugador = ?',
    [id],
    (err, result) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else if (result.length === 0) {
        res.status(404).json({ error: 'Jugador not found' });
      } else {
        res.json(result[0]);
      }
    }
  );
};





