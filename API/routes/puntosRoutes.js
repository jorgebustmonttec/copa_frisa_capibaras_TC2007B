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
 * /puntos/goles/eliminar/{id}:
 *   delete:
 *     tags:
 *       - Puntos
 *     summary: Eliminar un punto de gol por ID
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
router.delete('/goles/eliminar/:id', puntosController.removeGoal);

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

module.exports = router;
