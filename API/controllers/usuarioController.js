//usuarioController.js

const db = require('../utils/db');
const path = require('path');
const fs = require('fs');

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
