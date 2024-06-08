

//usuarioController.js

const db = require('../utils/db');
const path = require('path');
const fs = require('fs');
const bcrypt = require('bcryptjs');

exports.getAllUsuarios = (req, res) => {
  db.query('SELECT * FROM usuarios', (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Error en el servidor' });
    } else {
      res.json(results);
    }
  });
};

exports.getProfilePicture = (req, res) => {
  const userId = req.params.id;

  // Primero, verificar si el usuario existe en la base de datos
  db.query('SELECT * FROM usuarios WHERE id_usuario = ?', [userId], (err, results) => {
    if (err) {
      res.status(500).json({ error: 'Error en el servidor' });
    } else if (results.length === 0) {
      res.status(404).json({ error: 'Usuario no encontrado' });
    } else {
      sendProfilePicture(userId, res);
    }
  });

  // Luego, enviar la foto de perfil
  const sendProfilePicture = (userId, res) => {
    const imagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', `${userId}.jpg`);
    const defaultImagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', 'generic.jpg');

    fs.access(imagePath, fs.constants.F_OK, (err) => {
      if (err) {
        // Si la imagen no existe, enviar la foto de perfil por defecto
        res.sendFile(defaultImagePath, err => {
          if (err) {
            console.error("Error al enviar la foto de perfil por defecto:", err);
            res.status(500).send("Error al enviar el archivo");
          }
        });
      } else {
        // Si la imagen existe, enviar la foto de perfil del usuario
        res.sendFile(imagePath, err => {
          if (err) {
            console.error("Error al enviar la foto de perfil:", err);
            res.status(500).send("Error al enviar el archivo");
          }
        });
      }
    });
  };
};


exports.createAdmin = async (req, res) => {
  const { username, display_name, correo, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Se requiere nombre de usuario y contraseña' });
  }

  try {
    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insertar el nuevo administrador en la base de datos
    const query = 'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario) VALUES (?, ?, ?, ?, 1)';
    db.query(query, [username, display_name, correo, hashedPassword], (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Error en el servidor' });
      }

      res.status(201).json({ message: 'Cuenta de administrador creada exitosamente' });
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el servidor' });
  }
};

exports.createUser = async (req, res) => {
  const { username, display_name, correo, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Se requiere nombre de usuario y contraseña' });
  }

  try {
    // Verificar si el nombre de usuario ya existe
    db.query('SELECT * FROM usuarios WHERE username = ?', [username], async (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Error en el servidor' });
      }
      if (results.length > 0) {
        return res.status(400).json({ error: 'El nombre de usuario ya existe' });
      }

      // Encriptar la contraseña
      const hashedPassword = await bcrypt.hash(password, 10);

      // Insertar el nuevo usuario en la base de datos
      const query = 'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario) VALUES (?, ?, ?, ?, 2)';
      db.query(query, [username, display_name, correo, hashedPassword], (err, results) => {
        if (err) {
          return res.status(500).json({ error: 'Error en el servidor' });
        }

        res.status(201).json({ message: 'Cuenta de usuario creada exitosamente' });
      });
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el servidor' });
  }
};

exports.loginUser = (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      message: 'Se requiere nombre de usuario y contraseña',
      id_usuario: null,
      tipo_usuario: null
    });
  }

  db.query('SELECT * FROM usuarios WHERE username = ?', [username], async (err, results) => {
    if (err) {
      return res.status(500).json({
        message: 'Error en el servidor',
        id_usuario: null,
        tipo_usuario: null
      });
    }
    if (results.length === 0) {
      return res.status(400).json({
        message: 'Nombre de usuario no encontrado',
        id_usuario: null,
        tipo_usuario: null
      });
    }

    const user = results[0];
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.status(400).json({
        message: 'Contraseña incorrecta',
        id_usuario: null,
        tipo_usuario: null
      });
    }

    res.status(200).json({
      message: 'Inicio de sesión exitoso',
      id_usuario: user.id_usuario,
      tipo_usuario: user.tipo_usuario
    });
  });
};


exports.signup = async (req, res) => {
  const { username, display_name, correo, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Se requiere nombre de usuario y contraseña' });
  }

  try {
    // Verificar si el nombre de usuario o correo electrónico ya existen
    db.query('SELECT * FROM usuarios WHERE username = ? OR correo = ?', [username, correo], async (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Error en el servidor' });
      }
      if (results.length > 0) {
        const existingField = results[0].username === username ? 'Nombre de usuario' : 'Correo electrónico';
        return res.status(400).json({ error: `${existingField} ya existe` });
      }

      // Encriptar la contraseña
      const hashedPassword = await bcrypt.hash(password, 10);

      // Insertar el nuevo usuario en la base de datos
      const query = 'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario) VALUES (?, ?, ?, ?, 3)';
      db.query(query, [username, display_name, correo, hashedPassword], (err, results) => {
        if (err) {
          return res.status(500).json({ error: 'Error en el servidor' });
        }

        res.status(201).json({ message: 'Cuenta de usuario creada exitosamente' });
      });
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el servidor' });
  }
};
