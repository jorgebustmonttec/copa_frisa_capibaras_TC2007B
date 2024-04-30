// controllers/articuloController.js
const db = require('../utils/db');


exports.getCarroUsado = (req, res) => {
    const userId = req.params.id; 
    const sql = 'SELECT idvehiculo FROM INVENTARIOUSUARIO WHERE idusuario=? '; 

    db.query(sql, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};


exports.cambiarVehiculo = (req, res) => {
    const { idUsuario, idArticulo } = req.body;
    const checkOwnershipSql = 'SELECT IdUsuario FROM ArticuloUsuario WHERE IdUsuario = ? AND IdArticulo = ?';
    const checkVehicleTypeSql = 'SELECT IdArticulo FROM Articulos WHERE IdArticulo = ? AND TipoArticuloID = 2';

    db.query(checkOwnershipSql, [idUsuario, idArticulo], (err, ownershipResults) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (ownershipResults.length === 0) {
            return res.status(404).json({ error: 'Artículo no encontrado para este usuario.' });
        }
        db.query(checkVehicleTypeSql, [idArticulo], (err, vehicleTypeResults) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            if (vehicleTypeResults.length === 0) {
                return res.status(400).json({ error: 'El artículo no es un vehículo.' });
            }
            const updateVehicleSql = 'UPDATE InventarioUsuario SET IdVehiculo = ? WHERE IdUsuario = ?';
            db.query(updateVehicleSql, [idArticulo, idUsuario], (err, updateResults) => {
                if (err) {
                    return res.status(500).json({ error: err.message });
                }
                res.json({ message: 'Vehículo actualizado con éxito.' });
            });
        });
    });
};