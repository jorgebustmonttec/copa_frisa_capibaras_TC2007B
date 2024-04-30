// controllers/articuloController.js

const Articulo = require('../models/articulo');
const db = require('../utils/db');


exports.getAllArticulos = (req, res) => {
    Articulo.getAll((err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};


exports.getAllUsuarioArticulo = (req, res) => {
    const sql = 'SELECT * FROM articulousuario'; 
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};



exports.getCarrosIdName= (req, res) => {
    const sql = 'SELECT IdArticulo, NombreArticulo FROM articulos WHERE TipoArticuloID=2'; 
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};

exports.getCarrosId= (req, res) => {
    const sql = 'SELECT IdArticulo FROM articulos WHERE TipoArticuloID=2';
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};

exports.getArticulosByUsuario = (req, res) => {
    const userId = req.params.id; 
    const sql = 'SELECT * FROM articulousuario WHERE IdUsuario = ?'; 

    db.query(sql, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        res.json(results);
    });
};

exports.getArticulosByUsuarioCarros = (req, res) => {
    const userId = req.params.id; 
    const sql = 'SELECT au.idarticulo FROM articulousuario au JOIN articulos a ON au.idarticulo = a.idarticulo WHERE a.TipoArticuloID = 2 AND au.IdUsuario=? ';

    db.query(sql, [userId], (err, results) => {
        if (err) {

            return res.status(500).json({ error: err.message });
        }

        res.json(results);
    });
};



exports.addUsuarioArticulo = (req, res) => {
    const { IdUsuario, IdArticulo } = req.body; 
    const checkSql = 'SELECT * FROM articulousuario WHERE IdUsuario = ? AND IdArticulo = ?';
    db.query(checkSql, [IdUsuario, IdArticulo], (checkErr, checkResults) => {
        if (checkErr) {
            return res.status(500).json({ error: checkErr.message });
        }

        if (checkResults.length > 0) {
            return res.status(200).json({ message: 'Entry already exists', IdUsuario, IdArticulo });
        }

        const insertSql = 'INSERT INTO articulousuario (IdUsuario, IdArticulo) VALUES (?, ?)';
        db.query(insertSql, [IdUsuario, IdArticulo], (insertErr, insertResults) => {
            if (insertErr) {
                return res.status(500).json({ error: insertErr.message });
            }
            res.status(201).json({ message: 'Entry added successfully', IdUsuario, IdArticulo });
        });
    });
};
exports.getArticlePrice = (req, res) => {
    const { id } = req.params;  

    const sql = 'SELECT PrecioArticulo FROM articulos WHERE IdArticulo = ?';

    db.query(sql, [id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'Article not found' });
        }
        res.json({ PrecioArticulo: results[0].PrecioArticulo });
    });
};



/**
 * Checks if a user owns a specific article.
 * @param {object} req - The request object from Express.
 * @param {object} res - The response object from Express.
 */
exports.checkUserArticleOwnership = (req, res) => {
    const userId = req.params.userId;
    const articuloId = req.params.articuloId;

    const sql = 'SELECT 1 FROM articulousuario WHERE IdUsuario = ? AND IdArticulo = ?';

    db.query(sql, [userId, articuloId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        const ownsArticle = results.length > 0;
        res.json({ ownsArticle });
    });
};