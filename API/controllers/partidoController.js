//partidoController.js
const db = require('../utils/db');

exports.getAllPartidos = (req, res) => {
    db.query('SELECT * FROM partidos', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos:', err);
            res.status(500).json({ error: 'Error al obtener partidos' });
        } else {
            res.json(results);
        }
    });
};

exports.getPartidoById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT * FROM partidos WHERE id_partido = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener el partido:', err);
            res.status(500).json({ error: 'Error al obtener el partido' });
        } else if (result.length === 0) {
            res.status(404).json({ error: 'Partido no encontrado' });
        } else {
            res.json(result[0]);
        }
    });
};

exports.getPastPartidos = (req, res) => {
    db.query('SELECT * FROM partidos WHERE fecha < now()', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos pasados:', err);
            res.status(500).json({ error: 'Error al obtener partidos pasados' });
        } else {
            res.json(results);
        }
    });
};

exports.getFuturePartidos = (req, res) => {
    db.query('SELECT * FROM partidos WHERE fecha >= now()', (err, results) => {
        if (err) {
            console.error('Error al obtener partidos futuros:', err);
            res.status(500).json({ error: 'Error al obtener partidos futuros' });
        } else {
            res.json(results);
        }
    });
};


exports.createPartido = (req, res) => {
    const { equipo_a, equipo_b, fecha } = req.body;
    const id_copa = 1; // Assuming id_copa is always 1

    if (!equipo_a || !equipo_b || !fecha) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    // Convert fecha to MySQL datetime format
    const formattedFecha = new Date(fecha).toISOString().slice(0, 19).replace('T', ' ');

    db.query('INSERT INTO partidos (id_copa, equipo_a, equipo_b, fecha) VALUES (?, ?, ?, ?)', [id_copa, equipo_a, equipo_b, formattedFecha], (err, result) => {
        if (err) {
            console.error('Error al crear el partido:', err);
            res.status(500).json({ error: 'Error al crear el partido' });
        } else {
            res.status(201).json({ id_partido: result.insertId });
        }
    });
};

exports.deletePartido = (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM puntos WHERE id_partido = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al eliminar los puntos del partido:', err);
            res.status(500).json({ error: 'Error al eliminar los puntos del partido' });
        } else {
            db.query('DELETE FROM partidos WHERE id_partido = ?', [id], (err, result) => {
                if (err) {
                    console.error('Error al eliminar el partido:', err);
                    res.status(500).json({ error: 'Error al eliminar el partido' });
                } else if (result.affectedRows === 0) {
                    res.status(404).json({ error: 'Partido no encontrado' });
                } else {
                    res.status(200).json({ message: 'Partido y sus puntos eliminados exitosamente' });
                }
            });
        }
    });
};

exports.updatePartido = (req, res) => {
    const { id } = req.params;
    const { equipo_a, equipo_b, fecha, ganador } = req.body;

    if (!equipo_a || !equipo_b || !fecha) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    const formattedFecha = new Date(fecha).toISOString().slice(0, 19).replace('T', ' ');

    db.query(
        'UPDATE partidos SET equipo_a = ?, equipo_b = ?, fecha = ?, ganador = ? WHERE id_partido = ?',
        [equipo_a, equipo_b, formattedFecha, ganador || null, id],
        (err, result) => {
            if (err) {
                console.error('Error al actualizar el partido:', err);
                res.status(500).json({ error: 'Error al actualizar el partido' });
            } else if (result.affectedRows === 0) {
                res.status(404).json({ error: 'Partido no encontrado' });
            } else {
                res.status(200).json({ message: 'Partido actualizado exitosamente' });
            }
        }
    );
};

exports.getLastGameInfoByUserId = (req, res) => {
    const { id } = req.params;

    // Step 1: Get player details using user ID
    db.query('SELECT id_equipo FROM jugadores WHERE id_usuario = ?', [id], (err, jugadorResult) => {
        if (err) {
            console.error('Error al obtener el jugador:', err);
            return res.status(500).json({ error: 'Error al obtener el jugador' });
        } else if (jugadorResult.length === 0) {
            return res.status(404).json({ error: 'Jugador no encontrado' });
        }

        const teamId = jugadorResult[0].id_equipo;

        // Step 2: Get the latest match for the team that has already happened
        db.query('SELECT * FROM partidos WHERE (equipo_a = ? OR equipo_b = ?) AND fecha < now() ORDER BY fecha DESC LIMIT 1', [teamId, teamId], (err, partidoResult) => {
            if (err) {
                console.error('Error al obtener el partido:', err);
                return res.status(500).json({ error: 'Error al obtener el partido' });
            } else if (partidoResult.length === 0) {
                return res.status(404).json({ error: 'No se encontraron partidos para este equipo' });
            }

            const partido = partidoResult[0];

            // Step 3: Get the total goals for both teams in the latest match
            const getGoalsQuery = 'SELECT id_equipo, COUNT(*) as total_goals FROM puntos WHERE id_partido = ? AND tipo_punto = 1 GROUP BY id_equipo';

            db.query(getGoalsQuery, [partido.id_partido], (err, goalsResult) => {
                if (err) {
                    console.error('Error al obtener los goles del partido:', err);
                    return res.status(500).json({ error: 'Error al obtener los goles del partido' });
                }

                let golesA = 0;
                let golesB = 0;

                goalsResult.forEach(goal => {
                    if (goal.id_equipo === partido.equipo_a) {
                        golesA = goal.total_goals;
                    } else if (goal.id_equipo === partido.equipo_b) {
                        golesB = goal.total_goals;
                    }
                });

                // Ensure the player's team's goals are always on the left
                let resultString = "";
                if (teamId === partido.equipo_a) {
                    resultString = `${golesA} - ${golesB}`;
                } else {
                    resultString = `${golesB} - ${golesA}`;
                }

                // Step 4: Format the response
                const response = {
                    message: 'Success',
                    date: partido.fecha,
                    result: resultString
                };

                res.json(response);
            });
        });
    });
};

// New method to fetch points for a specific team
exports.getPointsByTeamId = (req, res) => {
    const { teamId } = req.params;
    
    const query = `
        SELECT 
            IF(ganador = ?, 3, IF(ganador = 0, 1, 0)) AS points
        FROM partidos
        WHERE equipo_a = ? OR equipo_b = ?
    `;

    db.query(query, [teamId, teamId, teamId], (err, results) => {
        if (err) {
            console.error('Error al obtener puntos del equipo:', err);
            res.status(500).json({ error: 'Error al obtener puntos del equipo' });
        } else {
            const totalPoints = results.reduce((sum, row) => sum + row.points, 0);
            res.json({ teamId, totalPoints });
        }
    });
};

// New method to fetch teams ordered by points
exports.getTeamsOrderedByPoints = (req, res) => {
    const query = `
        SELECT 
            id_equipo,
            SUM(IF(ganador = id_equipo, 3, IF(ganador = 0, 1, 0))) AS total_points
        FROM (
            SELECT equipo_a AS id_equipo, ganador FROM partidos
            UNION ALL
            SELECT equipo_b AS id_equipo, ganador FROM partidos
        ) AS all_teams
        GROUP BY id_equipo
        ORDER BY total_points DESC
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al obtener equipos ordenados por puntos:', err);
            res.status(500).json({ error: 'Error al obtener equipos ordenados por puntos' });
        } else {
            res.json(results);
        }
    });
};


exports.determineWinnerById = (req, res) => {
    const { id } = req.params;

    db.query(
        'SELECT id_equipo, COUNT(*) as total_goals FROM puntos WHERE id_partido = ? AND tipo_punto = 1 GROUP BY id_equipo',
        [id],
        (err, results) => {
            if (err) {
                console.error('Error al obtener los goles del partido:', err);
                return res.status(500).json({ error: 'Error al obtener los goles del partido' });
            }

            let ganador = null;
            if (results.length > 0) {
                const equipoA = results.find(r => r.id_equipo === partido.equipo_a) || { total_goals: 0 };
                const equipoB = results.find(r => r.id_equipo === partido.equipo_b) || { total_goals: 0 };

                if (equipoA.total_goals > equipoB.total_goals) {
                    ganador = partido.equipo_a;
                } else if (equipoA.total_goals < equipoB.total_goals) {
                    ganador = partido.equipo_b;
                } else {
                    ganador = 0; // It's a tie
                }
            } else {
                ganador = 0; // No goals scored, it's a tie
            }

            db.query(
                'UPDATE partidos SET ganador = ? WHERE id_partido = ?',
                [ganador, id],
                (err, result) => {
                    if (err) {
                        console.error('Error al actualizar el ganador del partido:', err);
                        return res.status(500).json({ error: 'Error al actualizar el ganador del partido' });
                    }

                    res.json({ message: 'Ganador determinado exitosamente', ganador });
                }
            );
        }
    );
};

exports.determineWinnerForAllMatches = (req, res) => {
    db.query(
        'SELECT * FROM partidos WHERE fecha < NOW()',
        (err, partidos) => {
            if (err) {
                console.error('Error al obtener partidos pasados:', err);
                return res.status(500).json({ error: 'Error al obtener partidos pasados' });
            }

            const updatePromises = partidos.map(partido => {
                return new Promise((resolve, reject) => {
                    db.query(
                        'SELECT id_equipo, COUNT(*) as total_goals FROM puntos WHERE id_partido = ? AND tipo_punto = 1 GROUP BY id_equipo',
                        [partido.id_partido],
                        (err, results) => {
                            if (err) {
                                console.error('Error al obtener los goles del partido:', err);
                                return reject('Error al obtener los goles del partido');
                            }

                            let ganador = null;
                            if (results.length > 0) {
                                const equipoA = results.find(r => r.id_equipo === partido.equipo_a) || { total_goals: 0 };
                                const equipoB = results.find(r => r.id_equipo === partido.equipo_b) || { total_goals: 0 };

                                if (equipoA.total_goals > equipoB.total_goals) {
                                    ganador = partido.equipo_a;
                                } else if (equipoA.total_goals < equipoB.total_goals) {
                                    ganador = partido.equipo_b;
                                } else {
                                    ganador = 0; // It's a tie
                                }
                            } else {
                                ganador = 0; // No goals scored, it's a tie
                            }

                            db.query(
                                'UPDATE partidos SET ganador = ? WHERE id_partido = ?',
                                [ganador, partido.id_partido],
                                (err, result) => {
                                    if (err) {
                                        console.error('Error al actualizar el ganador del partido:', err);
                                        return reject('Error al actualizar el ganador del partido');
                                    }

                                    resolve();
                                }
                            );
                        }
                    );
                });
            });

            Promise.all(updatePromises)
                .then(() => {
                    res.json({ message: 'Ganadores determinados exitosamente para todos los partidos pasados' });
                })
                .catch(error => {
                    res.status(500).json({ error });
                });
        }
    );
};

exports.clearWinner = (req, res) => {
    const { id } = req.params;

    db.query(
        'UPDATE partidos SET ganador = NULL WHERE id_partido = ?',
        [id],
        (err, result) => {
            if (err) {
                console.error('Error al eliminar el resultado del partido:', err);
                return res.status(500).json({ error: 'Error al eliminar el resultado del partido' });
            } else if (result.affectedRows === 0) {
                return res.status(404).json({ error: 'Partido no encontrado' });
            } else {
                return res.status(200).json({ message: 'Resultado del partido eliminado exitosamente' });
            }
        }
    );
};

