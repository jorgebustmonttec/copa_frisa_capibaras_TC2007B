const Usuario = require('../models/usuario');
const db = require('../utils/db');

const usuarioModel = new Usuario(db);

exports.getAllUsuarios = (req, res) => {
  usuarioModel.getAll((err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(results);
  });
};


exports.registerUsuario = (req, res) => {
    // Your logic to handle the registration
    const { Nombre, PrimerApellido, SegundoApellido, Direccion, Telefono, Usuario, Correo, Password, Genero, FechaNacimiento } = req.body;
    const sql = "INSERT INTO usuarios (NombresUsuario, ApellidoPUsuario, ApellidoMUsuario, DireccionUsuarioCalle, TelefonoUsuario, UsernameUsuario, CorreoUsuario, PasswordUsuario, GeneroUsuario, FechaNacimientoUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    db.query(sql, [Nombre, PrimerApellido, SegundoApellido, Direccion, Telefono, Usuario, Correo, Password, Genero, FechaNacimiento], (err, result) => {
        if (err) {
            console.error("Error inserting data into Database!", err);
            return res.status(500).send(err.message);
        }
        res.status(200).send("Usuario registered successfully.");
    });
};

exports.getUsuarioArticulos = (req, res) => {
  const userId = req.params.id;
  const sql = "SELECT * FROM articulousuario WHERE IdUsuario = ?";
  db.query(sql, [userId], (err, results) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      if (results.length === 0) {
          return res.status(404).json({ message: 'No articles found for this usuario.' });
      }
      res.json(results);
  });
};

exports.getUsuarioInventario = (req, res) => {
  const userId = req.params.id;
  const sql = "SELECT * FROM inventariousuario WHERE IdUsuario = ?";
  db.query(sql, [userId], (err, results) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      if (results.length === 0) {
          return res.status(404).json({ message: 'Inventory not found for this usuario.' });
      }
      res.json(results);
  });
};

exports.getUsuarioById = (req, res) => {
  const userId = req.params.id;
  const sql = "SELECT * FROM usuarios WHERE IdUsuario = ?";
  db.query(sql, [userId], (err, result) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      if (result.length === 0) {
          return res.status(404).json({ message: 'Usuario not found.' });
      }
      res.json(result[0]); // Return the first (and should be only) result.
  });
};


exports.checkAdminStatus = (req, res) => {
  const userId = req.params.id;
  const sql = "SELECT Administrador FROM usuarios WHERE IdUsuario = ?";
  db.query(sql, [userId], (err, result) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      if (result.length === 0) {
          return res.status(404).json({ message: 'Usuario not found.' });
      }
      res.json({ Administrador: result[0].Administrador });
  });
};

exports.authenticateUsuario = (req, res) => {
  const { Correo, Password } = req.body;
  const sql = "SELECT IdUsuario, PasswordUsuario, Administrador FROM usuarios WHERE CorreoUsuario = ?";

  db.query(sql, [Correo], (err, results) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      if (results.length === 0) {
          return res.status(401).json({ message: 'Authentication failed.' });
      }

      const user = results[0];
      // TODO: Compare hashed password if you store hashed passwords
      if (user.PasswordUsuario === Password) {
          // Return some user details (avoid sending sensitive information)
          res.json({ userId: user.IdUsuario, isAdmin: user.Administrador });
      } else {
          res.status(401).json({ message: 'Authentication failed.' });
      }
  });
};


// Method to check if an email exists in the database
exports.checkEmailExists = (req, res) => {
  const email = req.query.email;
  const sql = "SELECT COUNT(*) AS count FROM usuarios WHERE CorreoUsuario = ?";
  
  db.query(sql, [email], (err, result) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      res.json({ exists: result[0].count > 0 });
  });
};

// Method to check if a username exists in the database
exports.checkUsernameExists = (req, res) => {
  const username = req.query.username;
  const sql = "SELECT COUNT(*) AS count FROM usuarios WHERE UsernameUsuario = ?";
  
  db.query(sql, [username], (err, result) => {
      if (err) {
          return res.status(500).json({ error: err.message });
      }
      res.json({ exists: result[0].count > 0 });
  });
};

// In usuarioController.js

exports.getUserGenders = (req, res) => {
    const sql = "SELECT GeneroUsuario, COUNT(*) AS count FROM usuarios GROUP BY GeneroUsuario";
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        // Convert the array of results into an object with gender keys and counts
        const genderCount = results.reduce((acc, { GeneroUsuario, count }) => {
            acc[GeneroUsuario] = count;
            return acc;
        }, {});
        // Include "Prefiero No Decir" count if not present
        if (!genderCount["Prefiero No Decir"]) {
            genderCount["Prefiero No Decir"] = 0;
        }
        res.json(genderCount);
    });
};

exports.getUserAgeRanges = (req, res) => {
    const sql = `
    SELECT AgeRange, COUNT(*) AS Count
    FROM (
        SELECT CASE
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) BETWEEN 18 AND 24 THEN '18-24'
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) BETWEEN 45 AND 54 THEN '45-54'
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) BETWEEN 55 AND 64 THEN '55-64'
            WHEN TIMESTAMPDIFF(YEAR, FechaNacimientoUsuario, CURDATE()) >= 65 THEN '65+'
            ELSE 'Under 18'
        END AS AgeRange
        FROM usuarios
    ) AS AgeRanges
    GROUP BY AgeRange
    ORDER BY CASE AgeRange
        WHEN 'Under 18' THEN 1
        WHEN '18-24' THEN 2
        WHEN '25-34' THEN 3
        WHEN '35-44' THEN 4
        WHEN '45-54' THEN 5
        WHEN '55-64' THEN 6
        WHEN '65+' THEN 7
        ELSE 8
    END
`;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        // Convert the array of results into an object with age range keys and counts
        const ageRangesCount = results.reduce((acc, { AgeRange, Count }) => {
            acc[AgeRange] = Count;
            return acc;
        }, {});
        res.json(ageRangesCount);
    });
};

exports.getUserCreationDates = (req, res) => {
    const sql = "SELECT FechaCreacionUsuario FROM usuarios";
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results.map(user => user.FechaCreacionUsuario));
    });
};






exports.getUserGems = (req, res) => {
    const sql = "SELECT u.IdUsuario, (COALESCE(SUM(tdr.CantidadGemasOtorgadas), 0) + COALESCE(SUM(lj.GemasGanadas), 0) - COALESCE(SUM(tg.CantidadGemas), 0)) AS TotalGem FROM usuarios u LEFT JOIN transaccionesdineroreal tdr ON u.IdUsuario = tdr.idUsuario AND tdr.Tipo LEFT JOIN logjuego lj ON u.IdUsuario = lj.IdUsuario LEFT JOIN transaccionesgemas tg ON u.IdUsuario = tg.idUsuario AND tg.Tipo GROUP BY u.IdUsuario;";
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};


exports.getGemsById = (req, res) => {
    const userId = req.params.id;

    // First, check if the user exists in the usuarios table
    const userCheckSql = "SELECT COUNT(*) AS count FROM usuarios WHERE IdUsuario = ?";
    db.query(userCheckSql, [userId], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (result[0].count === 0) {
            return res.status(404).json({ message: 'User does not exist.' });
        }

        // If the user exists, calculate the total gems
        const gemsSql = `
            SELECT 
                SUM(gemas) AS Total_Gemas
            FROM (
                SELECT 
                    idUsuario, 
                    gemasGanadas AS gemas
                FROM logjuego
                WHERE idUsuario = ?

                UNION ALL

                SELECT 
                    idUsuario, 
                    cantidadgemasotorgadas AS gemas
                FROM transaccionesdineroreal
                WHERE idUsuario = ?

                UNION ALL

                SELECT 
                    idUsuario, 
                    -cantidadgemas AS gemas
                FROM transaccionesgemas
                WHERE idUsuario = ?
            ) AS combined
        `;
        
        db.query(gemsSql, [userId, userId, userId], (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            if (result.length === 0 || result[0].Total_Gemas === null) {
                return res.json({ Total_Gemas: "0" });
            }
            res.json({ Total_Gemas: result[0].Total_Gemas });
        });
    });
};


// usuariosController.js

exports.getUserByIdAndAdminStatus = (req, res) => {
    const userEmail = req.query.email;
    const sql = 'SELECT IdUsuario, Administrador FROM usuarios WHERE CorreoUsuario = ?';
    
    db.query(sql, [userEmail], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'User not found.' });
        }
        res.json({
            IdUsuario: results[0].IdUsuario,
            Administrador: results[0].Administrador
        });
    });
};



