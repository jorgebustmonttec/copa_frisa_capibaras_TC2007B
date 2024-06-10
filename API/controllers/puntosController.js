//puntosController.js
const db = require('../utils/db');

// 1. Get all points
exports.getAllPuntos = (req, res) => {
    db.query('SELECT * FROM puntos', (err, results) => {
        if (err) {
            console.error('Error al obtener puntos:', err);
            res.status(500).json({ error: 'Error al obtener puntos' });
        } else {
            res.json(results);
        }
    });
};

// 2. Get all point types
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

// 3. Get point type by ID
exports.getTipoPuntoById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM tipo_puntos WHERE id_tipo = ?', [id], (err, result) => {
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

// 4. Get goals by player
exports.getGoalsByPlayer = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM puntos WHERE id_jugador = ? AND tipo_punto = 1', [id], (err, results) => {
        if (err) {
            console.error('Error al obtener goles del jugador:', err);
            res.status(500).json({ error: 'Error al obtener goles del jugador' });
        } else {
            res.json(results);
        }
    });
};

// 5. Get total goals by player
exports.getTotalGoalsByPlayer = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_goals FROM puntos WHERE id_jugador = ? AND tipo_punto = 1', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de goles del jugador:', err);
            res.status(500).json({ error: 'Error al obtener total de goles del jugador' });
        } else {
            res.json(result[0]);
        }
    });
};

// 6. Get goals by team and match
exports.getGoalsByTeamAndMatch = (req, res) => {
    const { teamId, matchId } = req.params;
    db.query('SELECT * FROM puntos WHERE id_equipo = ? AND id_partido = ? AND tipo_punto = 1', [teamId, matchId], (err, results) => {
        if (err) {
            console.error('Error al obtener goles del equipo en el partido:', err);
            res.status(500).json({ error: 'Error al obtener goles del equipo en el partido' });
        } else {
            res.json(results);
        }
    });
};

// 7. Create goal point
exports.createGoalPoint = (req, res) => {
    const { id_partido, id_jugador } = req.body;

    if (!id_partido || !id_jugador) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('SELECT id_equipo FROM jugadores WHERE id_jugador = ?', [id_jugador], (err, result) => {
        if (err) {
            console.error('Error al obtener el equipo del jugador:', err);
            return res.status(500).json({ error: 'Error al obtener el equipo del jugador' });
        }

        if (result.length === 0) {
            return res.status(404).json({ error: 'Jugador no encontrado' });
        }

        const id_equipo = result[0].id_equipo;
        db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, ?, 1)', [id_partido, id_jugador, id_equipo], (err, result) => {
            if (err) {
                console.error('Error al crear el punto:', err);
                res.status(500).json({ error: 'Error al crear el punto' });
            } else {
                res.status(201).json({ id_punto: result.insertId });
            }
        });
    });
};

// 8. Remove goal
exports.removeGoal = (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM puntos WHERE id_punto = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al eliminar el punto:', err);
            res.status(500).json({ error: 'Error al eliminar el punto' });
        } else if (result.affectedRows === 0) {
            res.status(404).json({ error: 'Punto no encontrado' });
        } else {
            res.status(200).json({ message: 'Punto eliminado exitosamente' });
        }
    });
};

// 9. Get total goals by team per match
exports.getTotalGoalsByTeamPerMatch = (req, res) => {
    const { teamId, matchId } = req.params;
    db.query('SELECT COUNT(*) as total_goals FROM puntos WHERE id_equipo = ? AND id_partido = ? AND tipo_punto = 1', [teamId, matchId], (err, result) => {
        if (err) {
            console.error('Error al obtener total de goles del equipo en el partido:', err);
            res.status(500).json({ error: 'Error al obtener total de goles del equipo en el partido' });
        } else {
            res.json(result[0]);
        }
    });
};


exports.getPointsByMatch = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM puntos WHERE id_partido = ?', [id], (err, results) => {
        if (err) {
            console.error('Error al obtener puntos del partido:', err);
            res.status(500).json({ error: 'Error al obtener puntos del partido' });
        } else if (results.length === 0) {
            res.status(404).json({ error: 'No se encontraron puntos para este partido' });
        } else {
            res.json(results);
        }
    });
};

// 1. Add a green card point
exports.createGreenCardPoint = (req, res) => {
    const { id_partido, id_jugador } = req.body;

    if (!id_partido || !id_jugador) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('SELECT id_equipo FROM jugadores WHERE id_jugador = ?', [id_jugador], (err, result) => {
        if (err) {
            console.error('Error al obtener el equipo del jugador:', err);
            return res.status(500).json({ error: 'Error al obtener el equipo del jugador' });
        }

        if (result.length === 0) {
            return res.status(404).json({ error: 'Jugador no encontrado' });
        }

        const id_equipo = result[0].id_equipo;
        db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, ?, 2)', [id_partido, id_jugador, id_equipo], (err, result) => {
            if (err) {
                console.error('Error al crear el punto:', err);
                res.status(500).json({ error: 'Error al crear el punto' });
            } else {
                res.status(201).json({ id_punto: result.insertId });
            }
        });
    });
};

// 2. Get total green cards by player
exports.getTotalGreenCardsByPlayer = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_green_cards FROM puntos WHERE id_jugador = ? AND tipo_punto = 2', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas verdes del jugador:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas verdes del jugador' });
        } else {
            res.json(result[0]);
        }
    });
};

// 3. Get total green cards by team
exports.getTotalGreenCardsByTeam = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_green_cards FROM puntos WHERE id_equipo = ? AND tipo_punto = 2', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas verdes del equipo:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas verdes del equipo' });
        } else {
            res.json(result[0]);
        }
    });
};

// 4. Get all green card points
exports.getAllGreenCards = (req, res) => {
    db.query('SELECT * FROM puntos WHERE tipo_punto = 2', (err, results) => {
        if (err) {
            console.error('Error al obtener tarjetas verdes:', err);
            res.status(500).json({ error: 'Error al obtener tarjetas verdes' });
        } else {
            res.json(results);
        }
    });
};


// 10. Add a yellow card
// 10. Add a yellow card
exports.addYellowCard = (req, res) => {
    const { id_partido, id_jugador } = req.body;

    if (!id_partido || !id_jugador) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('SELECT COUNT(*) as yellow_card_count FROM puntos WHERE id_jugador = ? AND id_partido = ? AND tipo_punto IN (3, 4)', [id_jugador, id_partido], (err, result) => {
        if (err) {
            console.error('Error al obtener tarjetas amarillas:', err);
            return res.status(500).json({ error: 'Error al obtener tarjetas amarillas' });
        }

        const yellowCardCount = result[0].yellow_card_count;

        if (yellowCardCount < 1) {
            // Add first yellow card
            db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, (SELECT id_equipo FROM jugadores WHERE id_jugador = ?), 3)', [id_partido, id_jugador, id_jugador], (err, result) => {
                if (err) {
                    console.error('Error al agregar la tarjeta amarilla:', err);
                    res.status(500).json({ error: 'Error al agregar la tarjeta amarilla' });
                } else {
                    res.status(201).json({ id_punto: result.insertId });
                }
            });
        } else if (yellowCardCount === 1) {
            // Add second yellow card (indirect red)
            db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, (SELECT id_equipo FROM jugadores WHERE id_jugador = ?), 4)', [id_partido, id_jugador, id_jugador], (err, result) => {
                if (err) {
                    console.error('Error al agregar la tarjeta roja indirecta:', err);
                    res.status(500).json({ error: 'Error al agregar la tarjeta roja indirecta' });
                } else {
                    res.status(201).json({ id_punto: result.insertId });
                }
            });
        } else if (yellowCardCount === 2) {
            // Add direct red card for third yellow card
            db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, (SELECT id_equipo FROM jugadores WHERE id_jugador = ?), 5)', [id_partido, id_jugador, id_jugador], (err, result) => {
                if (err) {
                    console.error('Error al agregar la tarjeta roja directa:', err);
                    res.status(500).json({ error: 'Error al agregar la tarjeta roja directa' });
                } else {
                    res.status(201).json({ id_punto: result.insertId });
                }
            });
        } else {
            res.status(400).json({ error: 'El jugador ya tiene una tarjeta roja en este partido' });
        }
    });
};


// 11. Add a direct red card
exports.addRedCard = (req, res) => {
    const { id_partido, id_jugador } = req.body;

    if (!id_partido || !id_jugador) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('INSERT INTO puntos (id_partido, id_jugador, id_equipo, tipo_punto) VALUES (?, ?, (SELECT id_equipo FROM jugadores WHERE id_jugador = ?), 5)', [id_partido, id_jugador, id_jugador], (err, result) => {
        if (err) {
            console.error('Error al agregar la tarjeta roja directa:', err);
            res.status(500).json({ error: 'Error al agregar la tarjeta roja directa' });
        } else {
            res.status(201).json({ id_punto: result.insertId });
        }
    });
};

// 12. Get total yellow cards by player
exports.getTotalYellowCardsByPlayer = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_yellow_cards FROM puntos WHERE id_jugador = ? AND tipo_punto = 3', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas amarillas del jugador:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas amarillas del jugador' });
        } else {
            res.json(result[0]);
        }
    });
};

// 13. Get total red cards by player
exports.getTotalRedCardsByPlayer = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_red_cards FROM puntos WHERE id_jugador = ? AND tipo_punto IN (4, 5)', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas rojas del jugador:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas rojas del jugador' });
        } else {
            res.json(result[0]);
        }
    });
};

// 14. Get total yellow cards by team
exports.getTotalYellowCardsByTeam = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_yellow_cards FROM puntos WHERE id_equipo = ? AND tipo_punto = 3', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas amarillas del equipo:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas amarillas del equipo' });
        } else {
            res.json(result[0]);
        }
    });
};

// 15. Get total red cards by team
exports.getTotalRedCardsByTeam = (req, res) => {
    const { id } = req.params;
    db.query('SELECT COUNT(*) as total_red_cards FROM puntos WHERE id_equipo = ? AND tipo_punto IN (4, 5)', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener total de tarjetas rojas del equipo:', err);
            res.status(500).json({ error: 'Error al obtener total de tarjetas rojas del equipo' });
        } else {
            res.json(result[0]);
        }
    });
};

// 16. Get all yellow cards
exports.getAllYellowCards = (req, res) => {
    db.query('SELECT * FROM puntos WHERE tipo_punto = 3', (err, results) => {
        if (err) {
            console.error('Error al obtener tarjetas amarillas:', err);
            res.status(500).json({ error: 'Error al obtener tarjetas amarillas' });
        } else {
            res.json(results);
        }
    });
};

// 17. Get all red cards
exports.getAllRedCards = (req, res) => {
    db.query('SELECT * FROM puntos WHERE tipo_punto IN (4, 5)', (err, results) => {
        if (err) {
            console.error('Error al obtener tarjetas rojas:', err);
            res.status(500).json({ error: 'Error al obtener tarjetas rojas' });
        } else {
            res.json(results);
        }
    });
};

exports.getTotalGoalsByUserId = (req, res) => {
    const { userId } = req.params;
    db.query(
        'SELECT id_jugador FROM jugadores WHERE id_usuario = ?',
        [userId],
        (err, result) => {
            if (err) {
                console.error('Error al obtener el jugador:', err);
                return res.status(500).json({ error: 'Error al obtener el jugador' });
            }
            if (result.length === 0) {
                return res.status(404).json({ error: 'Jugador no encontrado' });
            }
            const playerId = result[0].id_jugador;
            db.query(
                'SELECT COUNT(*) as total_goals FROM puntos WHERE id_jugador = ? AND tipo_punto = 1',
                [playerId],
                (err, result) => {
                    if (err) {
                        console.error('Error al obtener total de goles del jugador:', err);
                        res.status(500).json({ error: 'Error al obtener total de goles del jugador' });
                    } else {
                        res.json(result[0]);
                    }
                }
            );
        }
    );
};