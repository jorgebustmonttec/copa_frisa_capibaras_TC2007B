// controllers/transaccionesController.js

const db = require('../utils/db'); 

exports.addTransaccionDineroReal = (req, res) => {
    const { userId, amount } = req.body;

    const sql = `
        INSERT INTO transaccionesdineroreal(idusuario, tiempotransaccion, idarticulo, tipo, cantidadgemasotorgadas)
        VALUES (?, NOW(), NULL, 'Regalo', ?)
    `;

    db.query(sql, [userId, amount], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(201).json({ message: 'Transaction added successfully', transactionId: result.insertId });
    });
};

exports.addCompraTransaction = (req, res) => {
    const { idUsuario, idArticulo, detalle } = req.body;

    const precioSql = 'SELECT PrecioArticulo FROM articulos WHERE IdArticulo = ?';

    db.query(precioSql, [idArticulo], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'Article not found.' });
        }

        const precioArticulo = results[0].PrecioArticulo;

        const insertSql = `
            INSERT INTO transaccionesgemas (idUsuario, TiempoTransaccion, idArticulo, Tipo, CantidadGemas, Detalle)
            VALUES (?, NOW(), ?, 'Compra', ?, ?)
        `;

        db.query(insertSql, [idUsuario, idArticulo, precioArticulo, detalle], (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            res.status(201).json({ message: 'Transaction added successfully', transactionId: result.insertId });
        });
    });
};



