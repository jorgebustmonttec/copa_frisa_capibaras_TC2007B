const db = require('../utils/db');

// Get all point types
exports.getAllTipoPuntos = (req, res) => {
    db.query('SELECT * FROM tipo_puntos', (err, results) => {
        if (err) {
            console.error('Error al obtener tipos de puntos:', err);
            res.status(500).json({ error: 'Error al obtener tipos de puntos' });
        } else {
            res.json(results);
        }
    });
};

// Get point type by ID
exports.getTipoPuntoById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM tipo_puntos WHERE id_tipo_punto = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener el tipo de punto:', err);
            res.status(500).json({ error: 'Error al obtener el tipo de punto' });
        } else if (result.length === 0) {
            res.status(404).json({ error: 'Tipo de punto no encontrado' });
        } else {
            res.json(result[0]);
        }
    });
};
