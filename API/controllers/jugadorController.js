//jugadorController.js
const db = require('../utils/db');
const bcrypt = require('bcryptjs');
const fs = require('fs');
const path = require('path');

const saltRounds = 10;

exports.createJugador = async (req, res) => {
  const { display_name, correo, fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo, posicion } = req.body;

  if (!display_name || !correo || !fecha_nac || !CURP || !domicilio || !telefono || !nombre || !apellido_p || !apellido_m || !num_imss || !id_equipo || !posicion) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    const [emailCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE correo = ?', [correo]);
    if (emailCheckResult.length > 0) {
      return res.status(400).json({ error: 'El correo ya está en uso' });
    }

    const [curpCheckResult] = await db.promise().query('SELECT id_jugador FROM jugadores WHERE CURP = ?', [CURP]);
    if (curpCheckResult.length > 0) {
      return res.status(400).json({ error: 'El CURP ya está en uso' });
    }

    let username;
    for (let i = 0; i < 50; i++) {
      const randomNum = Math.floor(100 + Math.random() * 900);
      username = `${nombre[0]}${apellido_p[0]}${randomNum}`;
      const [usernameCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE username = ?', [username]);
      if (usernameCheckResult.length === 0) break;
      if (i === 49) return res.status(400).json({ error: 'No se pudo generar un nombre de usuario único' });
    }

    const password = CURP.slice(-8);
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const [userResult] = await db.promise().query(
      'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario, imagen, created_at, first_login) VALUES (?, ?, ?, ?, 2, "NA", NOW(), true)',
      [username, display_name, correo, hashedPassword]
    );

    const userId = userResult.insertId;

    await db.promise().query(
      'INSERT INTO jugadores (fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_usuario, id_equipo, posicion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, userId, id_equipo, posicion]
    );

    const userPwdDir = path.join(__dirname, '..', 'storage', 'files', 'userpwd');
    if (!fs.existsSync(userPwdDir)) {
        fs.mkdirSync(userPwdDir, { recursive: true });
    }

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
    `SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, jugadores.posicion,
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
    `SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo,  jugadores.posicion,
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


exports.getJugadorById = (req, res) => {
  const { id } = req.params;
  
  db.query(
    `SELECT 
        jugadores.id_jugador, jugadores.fecha_nac, jugadores.CURP, jugadores.domicilio, jugadores.telefono, 
        jugadores.nombre, jugadores.apellido_p, jugadores.apellido_m, jugadores.num_imss, jugadores.id_equipo, jugadores.posicion,
        jugadores.doc_carta_responsabilidad, jugadores.doc_curp, jugadores.doc_ine, 
        usuarios.id_usuario, usuarios.username, usuarios.display_name, usuarios.correo, usuarios.tipo_usuario, 
        usuarios.imagen, usuarios.created_at, usuarios.first_login 
     FROM jugadores 
     JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario 
     WHERE jugadores.id_jugador = ?`,
    [id],
    (err, result) => {
      if (err) {
        console.error('Error al obtener el jugador:', err);
        res.status(500).json({ error: 'Error al obtener el jugador' });
      } else if (result.length === 0) {
        res.status(404).json({ error: 'Jugador no encontrado' });
      } else {
        res.json(result[0]);
      }
    }
  );
};

exports.getJugadorByUserId = (req, res) => {
  const { id } = req.params;
  
  db.query(
    `SELECT 
        jugadores.id_jugador, jugadores.fecha_nac, jugadores.CURP, jugadores.domicilio, jugadores.telefono, 
        jugadores.nombre, jugadores.apellido_p, jugadores.apellido_m, jugadores.num_imss, jugadores.id_equipo, jugadores.posicion, 
        jugadores.doc_carta_responsabilidad, jugadores.doc_curp, jugadores.doc_ine, 
        usuarios.id_usuario, usuarios.username, usuarios.display_name, usuarios.correo, usuarios.tipo_usuario, 
        usuarios.imagen, usuarios.created_at, usuarios.first_login 
     FROM jugadores 
     JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario 
     WHERE usuarios.id_usuario = ?`,
    [id],
    (err, result) => {
      if (err) {
        console.error('Error al obtener el jugador:', err);
        res.status(500).json({ error: 'Error al obtener el jugador' });
      } else if (result.length === 0) {
        res.status(404).json({ error: 'Jugador no encontrado' });
      } else {
        res.json(result[0]);
      }
    }
  );
}

exports.updateJugador = async (req, res) => {
  const { id } = req.params;
  const { username, display_name, correo, password, fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo, posicion } = req.body;

  if (!username || !display_name || !correo || !fecha_nac || !CURP || !domicilio || !telefono || !nombre || !apellido_p || !apellido_m || !num_imss || !id_equipo || !posicion) {
    return res.status(400).json({ error: 'Faltan campos obligatorios' });
  }

  try {
    const [emailCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE correo = ? AND id_usuario != (SELECT id_usuario FROM jugadores WHERE id_jugador = ?)', [correo, id]);
    if (emailCheckResult.length > 0) {
      return res.status(400).json({ error: 'El correo ya está en uso' });
    }

    const [curpCheckResult] = await db.promise().query('SELECT id_jugador FROM jugadores WHERE CURP = ? AND id_jugador != ?', [CURP, id]);
    if (curpCheckResult.length > 0) {
      return res.status(400).json({ error: 'El CURP ya está en uso' });
    }

    const [usernameCheckResult] = await db.promise().query('SELECT id_usuario FROM usuarios WHERE username = ? AND id_usuario != (SELECT id_usuario FROM jugadores WHERE id_jugador = ?)', [username, id]);
    if (usernameCheckResult.length > 0) {
      return res.status(400).json({ error: 'El nombre de usuario ya está en uso' });
    }

    let hashedPassword;
    if (password) {
      hashedPassword = await bcrypt.hash(password, saltRounds);
    }

    const [userUpdateResult] = await db.promise().query(
      'UPDATE usuarios SET username = ?, display_name = ?, correo = ?, password = ?, first_login = false WHERE id_usuario = (SELECT id_usuario FROM jugadores WHERE id_jugador = ?)',
      [username, display_name, correo, hashedPassword || null, id]
    );

    const [playerUpdateResult] = await db.promise().query(
      'UPDATE jugadores SET fecha_nac = ?, CURP = ?, domicilio = ?, telefono = ?, nombre = ?, apellido_p = ?, apellido_m = ?, num_imss = ?, id_equipo = ?, posicion = ? WHERE id_jugador = ?',
      [fecha_nac, CURP, domicilio, telefono, nombre, apellido_p, apellido_m, num_imss, id_equipo, posicion, id]
    );

    res.status(200).json({ message: 'Jugador actualizado exitosamente' });
  } catch (err) {
    console.error('Error:', err);
    res.status(500).json({ error: 'Error al actualizar el jugador' });
  }
};


exports.getJugadoresByEquipo = (req, res) => {
  const { id_equipo } = req.params;

  db.query(
    `SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, 
            COALESCE(equipos.nombre_equipo, 'Sin Equipo') AS nombre_equipo, 
            usuarios.username, usuarios.display_name 
     FROM jugadores 
     LEFT JOIN equipos ON jugadores.id_equipo = equipos.id_equipo 
     JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario 
     WHERE jugadores.id_equipo = ?`,
    [id_equipo],
    (err, results) => {
      if (err) {
        res.status(500).json({ error: err.message });
      } else {
        res.json(results);
      }
    }
  );
};

exports.getJugadoresByMatch = (req, res) => {
  const { matchId } = req.params;
  
  db.query(`
      SELECT jugadores.id_jugador, jugadores.nombre, jugadores.id_equipo, 
             COALESCE(equipos.nombre_equipo, 'Sin Equipo') AS nombre_equipo, 
             usuarios.username, usuarios.display_name 
      FROM jugadores 
      LEFT JOIN equipos ON jugadores.id_equipo = equipos.id_equipo 
      JOIN usuarios ON jugadores.id_usuario = usuarios.id_usuario 
      JOIN puntos ON jugadores.id_jugador = puntos.id_jugador 
      WHERE puntos.id_partido = ?
  `, [matchId], (err, results) => {
      if (err) {
          res.status(500).json({ error: err.message });
      } else {
          res.json(results);
      }
  });
};
