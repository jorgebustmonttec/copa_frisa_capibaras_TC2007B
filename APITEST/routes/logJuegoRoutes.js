// routes/logJuegoRoutes.js

const express = require('express');
const logJuegoController = require('../controllers/logJuegoController');
const router = express.Router();

/**
 * @swagger
 * tags:
 *   - name: LogJuego
 *     description: Operations about log juego
 *
 * /logJuego/addLog:
 *   post:
 *     tags: [LogJuego]
 *     summary: Create a log juego entry
 *     description: Add a new entry to the log juego table.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - IdUsuario
 *               - GemsGanadas
 *               - DuracionJuego
 *               - Puntuacion  # Add Puntuacion as a required property
 *             properties:
 *               IdUsuario:
 *                 type: integer
 *                 description: The ID of the usuario.
 *               GemsGanadas:
 *                 type: integer
 *                 description: The number of gems won.
 *               DuracionJuego:
 *                 type: integer
 *                 description: The duration of the game in seconds.
 *               Puntuacion:   # Add Puntuacion property description
 *                 type: integer
 *                 description: The points earned in the game.
 *     responses:
 *       201:
 *         description: Log entry created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 id:
 *                   type: integer
 *                   description: The ID of the created log entry.
 *       500:
 *         description: Server error.
 */

router.post('/addLog', logJuegoController.addLogJuegoEntry);




/**
 * @swagger
 * tags:
 *   - name: LogJuego
 *     description: Operations about log juego
 * 
 * /logJuego/all:
 *   get:
 *     tags: [LogJuego]
 *     summary: Retrieve all log entries
 *     description: Fetches all entries from the logjuego table which records user game logs.
 *     responses:
 *       200:
 *         description: An array of log entries.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   IdUsuario:
 *                     type: integer
 *                     description: The ID of the user.
 *                   idlogJuego:
 *                     type: integer
 *                     description: The log entry's unique ID.
 *                   TiempoInicio:
 *                     type: string
 *                     format: date-time
 *                     description: The start time of the game session.
 *                   DuracionJuego:
 *                     type: integer
 *                     description: The duration of the game session.
 *                   Puntuacion:
 *                     type: integer
 *                     description: The score achieved in the game session.
 *                   GemasGanadas:
 *                     type: integer
 *                     description: The number of gems won in the game session.
 *       500:
 *         description: Error occurred while fetching the logs.
 */

router.get('/all', logJuegoController.checkLogs);

module.exports = router;
