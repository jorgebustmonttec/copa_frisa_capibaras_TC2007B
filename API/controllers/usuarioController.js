//usuarioController.js

const db = require('../utils/db');
const path = require('path');
const fs = require('fs');
const bcrypt = require('bcryptjs');


exports.getAllUsuarios = (req, res) => {
  db.query('SELECT * FROM usuarios', (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else {
      res.json(results);
    }
  });
};

exports.getProfilePicture = (req, res) => {
  const userId = req.params.id;

  //first, check if the user exists in the database
  db.query('SELECT * FROM usuarios WHERE id_usuario = ?', [userId], (err, results) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else if (results.length === 0) {
      res.status(404).json({ error: 'usuario not found' });
    } else {
      sendProfilePicture(userId, res);
    }
  });

  //then, send the profile picture
  const sendProfilePicture = (userId, res) => {
    const imagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', `${userId}.jpg`);
    const defaultImagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', 'generic.jpg');

    fs.access(imagePath, fs.constants.F_OK, (err) => {
      if (err) {
        // If the image does not exist, send the default profile picture
        res.sendFile(defaultImagePath, err => {
          if (err) {
            console.error("Error sending default profile picture:", err);
            res.status(500).send("Error sending file");
          }
        });
      } else {
        // If the image exists, send the user's profile picture
        res.sendFile(imagePath, err => {
          if (err) {
            console.error("Error sending profile picture:", err);
            res.status(500).send("Error sending file");
          }
        });
      }
    });
  };

  /*
  const imagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', `${userId}.jpg`);
  const defaultImagePath = path.join(__dirname, '..', 'storage', 'img', 'perfil', 'generic.jpg');

  fs.access(imagePath, fs.constants.F_OK, (err) => {
      if (err) {
          // If the image does not exist, send the default profile picture
          res.sendFile(defaultImagePath, err => {
              if (err) {
                  console.error("Error sending default profile picture:", err);
                  res.status(500).send("Error sending file");
              }
          });
      } else {
          // If the image exists, send the user's profile picture
          res.sendFile(imagePath, err => {
              if (err) {
                  console.error("Error sending profile picture:", err);
                  res.status(500).send("Error sending file");
              }
          });
      }
  });
  */
};


exports.createAdmin = async (req, res) => {
  const { username, display_name, correo, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insert the new admin into the database
    const query = 'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario) VALUES (?, ?, ?, ?, 1)';
    db.query(query, [username, display_name, correo, hashedPassword], (err, results) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }

      res.status(201).json({ message: 'Admin account created successfully' });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.createUser = async (req, res) => {
  const { username, display_name, correo, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  try {
    // Check if the username already exists
    db.query('SELECT * FROM usuarios WHERE username = ?', [username], async (err, results) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      if (results.length > 0) {
        return res.status(400).json({ error: 'Username already exists' });
      }

      // Hash the password
      const hashedPassword = await bcrypt.hash(password, 10);

      // Insert the new user into the database
      const query = 'INSERT INTO usuarios (username, display_name, correo, password, tipo_usuario) VALUES (?, ?, ?, ?, 2)';
      db.query(query, [username, display_name, correo, hashedPassword], (err, results) => {
        if (err) {
          return res.status(500).json({ error: err.message });
        }

        res.status(201).json({ message: 'User account created successfully' });
      });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.loginUser = (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      message: 'Username and password are required',
      id_usuario: null,
      tipo_usuario: null
    });
  }

  db.query('SELECT * FROM usuarios WHERE username = ?', [username], async (err, results) => {
    if (err) {
      return res.status(500).json({
        message: err.message,
        id_usuario: null,
        tipo_usuario: null
      });
    }
    if (results.length === 0) {
      return res.status(400).json({
        message: 'Username not found',
        id_usuario: null,
        tipo_usuario: null
      });
    }

    const user = results[0];
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.status(400).json({
        message: 'Incorrect password',
        id_usuario: null,
        tipo_usuario: null
      });
    }

    res.status(200).json({
      message: 'Login successful',
      id_usuario: user.id_usuario,
      tipo_usuario: user.tipo_usuario
    });
  });
};
