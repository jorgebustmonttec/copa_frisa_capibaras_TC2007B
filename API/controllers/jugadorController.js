//jugadorController.js
const db = require('../utils/db');
const bcrypt = require('bcryptjs');
const fs = require('fs');
const path = require('path');

const saltRounds = 10;

exports.createJugador = async (req, res) => {
  const { display_name, correo, fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo } = req.body;

  if (!display_name || !correo || !fecha_nac || !CURP || !domicilio || !telefono || !nombre || !apellido_p || !apellido_m || !num_imss || !id_equipo) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    // Check for unique email and CURP
    const [emailCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE correo = ?', [correo]);
    if (emailCheckResult.length > 0) {
      return res.status(400).json({ error: 'El correo ya está en uso' });
    }

    const [curpCheckResult] = await db.promise().query('SELECT id_jugador FROM jugadores WHERE CURP = ?', [CURP]);
    if (curpCheckResult.length > 0) {
      return res.status(400).json({ error: 'El CURP ya está en uso' });
    }

    // Generate unique username
    let username;
    for (let i = 0; i < 50; i++) {
      const randomNum = Math.floor(100 + Math.random() * 900); // Generate a random 3-digit number
      username = `${nombre[0]}${apellido_p[0]}${randomNum}`;
      const [usernameCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE username = ?', [username]);
      if (usernameCheckResult.length === 0) break;
      if (i === 49) return res.status(400).json({ error: 'No se pudo generar un nombre de usuario único' });
    }

    // Generate password using the last 8 digits of CURP
    const password = CURP.slice(-8);
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Insert into usuarios table
    const [userResult] = await db.promise().query(
      'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario, imagen, created_at, first_login) VALUES (?, ?, ?, ?, 2, "NA", NOW(), true)',
      [username, display_name, correo, hashedPassword]
    );

    const userId = userResult.insertId;

    // Insert into jugadores table
    await db.promise().query(
      'INSERT INTO jugadores (fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_usuario, id_equipo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, userId, id_equipo]
    );

    // Ensure directory exists
    const userPwdDir = path.join(__dirname, '..', 'storage', 'files', 'userpwd');
    if (!fs.existsSync(userPwdDir)) {
        fs.mkdirSync(userPwdDir, { recursive: true });
    }

    // Write username and password to a file
    const userPwdFilePath = path.join(userPwdDir, `${username}_credentials.txt`);
    const userPwdData = `Username: ${username}\nPassword: ${password}\n`;
    fs.writeFileSync(userPwdFilePath, userPwdData);

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
