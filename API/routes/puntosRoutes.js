const express = require('express');
const router = express.Router();
const puntosController = require('../controllers/puntosController');

/**
 * @swagger
 * tags:
 *   name: Puntos
 *   description: Todo sobre Puntos
 *
 * components:
 *   schemas:
 *     Punto:
 *       type: object
 *       required:
 *         - id_partido
 *         - id_equipo
 *         - tipo_punto
 *       properties:
 *         id_punto:
 *           type: integer
 *           description: Identificador único del punto.
 *         id_partido:
 *           type: integer
 *           description: Identificador del partido.
 *         id_jugador:
 *           type: integer
 *           description: Identificador del jugador.
 *         id_equipo:
 *           type: integer
 *           description: Identificador del equipo.
 *         tipo_punto:
 *           type: integer
 *           description: Tipo de punto.
 *         tiempo_punto:
 *           type: string
 *           format: date-time
 *           description: Fecha y hora del punto.
 *       example:
 *         id_punto: 1
 *         id_partido: 1
 *         id_jugador: 1
 *         id_equipo: 1
 *         tipo_punto: 1
 *         tiempo_punto: "2024-06-01T12:00:00Z"
 */

/**
 * @swagger
 * /puntos:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener todos los puntos
 *     responses:
 *       200:
 *         description: Lista de todos los puntos
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       500:
 *         description: Error al obtener los puntos
 */
router.get('/', puntosController.getAllPuntos);



/**
 * @swagger
 * /puntos/goles/jugador/{id}:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener goles de un jugador por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Lista de goles del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener los goles del jugador
 */
router.get('/goles/jugador/:id', puntosController.getGoalsByPlayer);

/**
 * @swagger
 * /puntos/goles/jugador/{id}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de goles de un jugador por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Total de goles del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_goals:
 *                   type: integer
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener el total de goles del jugador
 */
router.get('/goles/jugador/:id/total', puntosController.getTotalGoalsByPlayer);

/**
 * @swagger
 * /puntos/goles/usuario/{userId}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de goles de un jugador por ID de usuario
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del usuario
 *     responses:
 *       200:
 *         description: Total de goles del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_goals:
 *                   type: integer
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener el total de goles del jugador
 */
router.get('/goles/usuario/:userId/total', puntosController.getTotalGoalsByUserId);


/**
 * @swagger
 * /puntos/goles/equipo/{teamId}/partido/{matchId}:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener goles de un equipo en un partido
 *     parameters:
 *       - in: path
 *         name: teamId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *       - in: path
 *         name: matchId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Lista de goles del equipo en el partido
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       404:
 *         description: Equipo o partido no encontrado
 *       500:
 *         description: Error al obtener los goles del equipo en el partido
 */
router.get('/goles/equipo/:teamId/partido/:matchId', puntosController.getGoalsByTeamAndMatch);

/**
 * @swagger
 * /puntos/goles/crear:
 *   post:
 *     tags:
 *       - Puntos
 *     summary: Crear un punto de gol
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_partido:
 *                 type: integer
 *               id_jugador:
 *                 type: integer
 *             example:
 *               id_partido: 1
 *               id_jugador: 1
 *     responses:
 *       201:
 *         description: Punto de gol creado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_punto:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear el punto
 */
router.post('/goles/crear', puntosController.createGoalPoint);

/**
 * @swagger
 * /puntos/eliminar/{id}:
 *   delete:
 *     tags:
 *       - Puntos
 *     summary: Eliminar un punto  por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del punto
 *     responses:
 *       200:
 *         description: Punto eliminado exitosamente
 *       404:
 *         description: Punto no encontrado
 *       500:
 *         description: Error al eliminar el punto
 */
router.delete('/eliminar/:id', puntosController.removeGoal);

/**
 * @swagger
 * /puntos/goles/equipo/{teamId}/partido/{matchId}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de goles de un equipo en un partido
 *     parameters:
 *       - in: path
 *         name: teamId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *       - in: path
 *         name: matchId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Total de goles del equipo en el partido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_goals:
 *                   type: integer
 *       404:
 *         description: Equipo o partido no encontrado
 *       500:
 *         description: Error al obtener el total de goles del equipo en el partido
 */
router.get('/goles/equipo/:teamId/partido/:matchId/total', puntosController.getTotalGoalsByTeamPerMatch);

/**
 * @swagger
 * /puntos/partido/{id}:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener puntos por ID de partido
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Lista de puntos del partido
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al obtener los puntos del partido
 */
router.get('/partido/:id', puntosController.getPointsByMatch);

/**
 * @swagger
 * /puntos/green:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener todas las tarjetas verdes
 *     responses:
 *       200:
 *         description: Lista de todas las tarjetas verdes
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       500:
 *         description: Error al obtener las tarjetas verdes
 */
router.get('/green', puntosController.getAllGreenCards);

/**
 * @swagger
 * /puntos/green/player/{id}:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas verdes por ID de jugador
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Total de tarjetas verdes del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_green_cards:
 *                   type: integer
 *                   example: 5
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas verdes del jugador
 */
router.get('/green/player/:id', puntosController.getTotalGreenCardsByPlayer);

/**
 * @swagger
 * /puntos/green/team/{id}:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas verdes por ID de equipo
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Total de tarjetas verdes del equipo
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_green_cards:
 *                   type: integer
 *                   example: 10
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas verdes del equipo
 */
router.get('/green/team/:id', puntosController.getTotalGreenCardsByTeam);

/**
 * @swagger
 * /puntos/green/create:
 *   post:
 *     tags:
 *       - Puntos
 *     summary: Crear una tarjeta verde
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - id_partido
 *               - id_jugador
 *             properties:
 *               id_partido:
 *                 type: integer
 *                 description: ID del partido
 *               id_jugador:
 *                 type: integer
 *                 description: ID del jugador
 *     responses:
 *       201:
 *         description: Tarjeta verde creada exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_punto:
 *                   type: integer
 *                   example: 1
 *       400:
 *         description: Faltan campos obligatorios
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al crear la tarjeta verde
 */
router.post('/green/create', puntosController.createGreenCardPoint);

/**
 * @swagger
 * /puntos/yellow/create:
 *   post:
 *     tags:
 *       - Puntos
 *     summary: Crear una tarjeta amarilla
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_partido:
 *                 type: integer
 *               id_jugador:
 *                 type: integer
 *             example:
 *               id_partido: 1
 *               id_jugador: 1
 *     responses:
 *       201:
 *         description: Tarjeta amarilla creada exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_punto:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear la tarjeta amarilla
 */
router.post('/yellow/create', puntosController.addYellowCard);

/**
 * @swagger
 * /puntos/red/create:
 *   post:
 *     tags:
 *       - Puntos
 *     summary: Crear una tarjeta roja directa
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_partido:
 *                 type: integer
 *               id_jugador:
 *                 type: integer
 *             example:
 *               id_partido: 1
 *               id_jugador: 1
 *     responses:
 *       201:
 *         description: Tarjeta roja directa creada exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_punto:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear la tarjeta roja directa
 */
router.post('/red/create', puntosController.addRedCard);

/**
 * @swagger
 * /puntos/yellow/player/{id}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas amarillas por ID de jugador
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Total de tarjetas amarillas del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_yellow_cards:
 *                   type: integer
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas amarillas del jugador
 */
router.get('/yellow/player/:id/total', puntosController.getTotalYellowCardsByPlayer);

/**
 * @swagger
 * /puntos/red/player/{id}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas rojas por ID de jugador
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Total de tarjetas rojas del jugador
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_red_cards:
 *                   type: integer
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas rojas del jugador
 */
router.get('/red/player/:id/total', puntosController.getTotalRedCardsByPlayer);

/**
 * @swagger
 * /puntos/yellow/team/{id}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas amarillas por ID de equipo
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Total de tarjetas amarillas del equipo
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_yellow_cards:
 *                   type: integer
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas amarillas del equipo
 */
router.get('/yellow/team/:id/total', puntosController.getTotalYellowCardsByTeam);

/**
 * @swagger
 * /puntos/red/team/{id}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas rojas por ID de equipo
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Total de tarjetas rojas del equipo
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_red_cards:
 *                   type: integer
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas rojas del equipo
 */
router.get('/red/team/:id/total', puntosController.getTotalRedCardsByTeam);

/**
 * @swagger
 * /puntos/yellow:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener todas las tarjetas amarillas
 *     responses:
 *       200:
 *         description: Lista de todas las tarjetas amarillas
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       500:
 *         description: Error al obtener las tarjetas amarillas
 */
router.get('/yellow', puntosController.getAllYellowCards);

/**
 * @swagger
 * /puntos/red:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener todas las tarjetas rojas
 *     responses:
 *       200:
 *         description: Lista de todas las tarjetas rojas
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Punto'
 *       500:
 *         description: Error al obtener las tarjetas rojas
 */
router.get('/red', puntosController.getAllRedCards);

// Add these routes to puntosRoutes.js
/**
 * @swagger
 * /puntos/goles/jugador/{playerId}/partido/{matchId}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de goles de un jugador en un partido
 *     parameters:
 *       - in: path
 *         name: playerId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *       - in: path
 *         name: matchId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Total de goles del jugador en el partido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_goals:
 *                   type: integer
 *       404:
 *         description: Jugador o partido no encontrado
 *       500:
 *         description: Error al obtener el total de goles del jugador en el partido
 */
router.get('/goles/jugador/:playerId/partido/:matchId/total', puntosController.getTotalGoalsByPlayerInMatch);

/**
 * @swagger
 * /puntos/green/jugador/{playerId}/partido/{matchId}/total:
 *   get:
 *     tags:
 *       - Puntos
 *     summary: Obtener el total de tarjetas verdes de un jugador en un partido
 *     parameters:
 *       - in: path
 *         name: playerId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *       - in: path
 *         name: matchId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Total de tarjetas verdes del jugador en el partido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_green_cards:
 *                   type: integer
 *       404:
 *         description: Jugador o partido no encontrado
 *       500:
 *         description: Error al obtener el total de tarjetas verdes del jugador en el partido
 */
router.get('/green/jugador/:playerId/partido/:matchId/total', puntosController.getTotalGreenCardsByPlayerInMatch);



module.exports = router;
