//partidoRoutes.js

const express = require('express');
const router = express.Router();
const partidoController = require('../controllers/partidoController');

/**
 * @swagger
 * tags:
 *   name: Partidos
 *   description: Todo sobre Partidos
 *
 * components:
 *   schemas:
 *     Partido:
 *       type: object
 *       required:
 *         - equipo_a
 *         - equipo_b
 *         - fecha
 *       properties:
 *         id_partido:
 *           type: integer
 *           description: Identificador único del partido.
 *         id_copa:
 *           type: integer
 *           description: Identificador de la copa.
 *         equipo_a:
 *           type: integer
 *           description: Identificador del equipo A.
 *         equipo_b:
 *           type: integer
 *           description: Identificador del equipo B.
 *         fecha:
 *           type: string
 *           format: date-time
 *           description: Fecha del partido.
 *         ganador:
 *           type: integer
 *           description: Identificador del equipo ganador.
 *       example:
 *         id_partido: 1
 *         id_copa: 1
 *         equipo_a: 1
 *         equipo_b: 2
 *         fecha: "2024-06-01T12:00:00Z"
 *         ganador: null
 */

/**
 * @swagger
 * /partidos:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener todos los partidos
 *     responses:
 *       200:
 *         description: Lista de todos los partidos
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Partido'
 *       500:
 *         description: Error al obtener los partidos
 */
router.get('/', partidoController.getAllPartidos);

/**
 * @swagger
 * /partidos/single/{id}:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener un partido por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Información del partido
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Partido'
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al obtener el partido
 */
router.get('/single/:id', partidoController.getPartidoById);

/**
 * @swagger
 * /partidos/pasados:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener partidos pasados
 *     responses:
 *       200:
 *         description: Lista de partidos pasados
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Partido'
 *       500:
 *         description: Error al obtener los partidos pasados
 */
router.get('/pasados', partidoController.getPastPartidos);

/**
 * @swagger
 * /partidos/futuros:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener partidos futuros
 *     responses:
 *       200:
 *         description: Lista de partidos futuros
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Partido'
 *       500:
 *         description: Error al obtener los partidos futuros
 */
router.get('/futuros', partidoController.getFuturePartidos);

/**
 * @swagger
 * /partidos/crear:
 *   post:
 *     tags:
 *       - Partidos
 *     summary: Crear un nuevo partido
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               equipo_a:
 *                 type: integer
 *               equipo_b:
 *                 type: integer
 *               fecha:
 *                 type: string
 *                 format: date-time
 *             example:
 *               equipo_a: 1
 *               equipo_b: 2
 *               fecha: "2024-06-01T12:00:00Z"
 *     responses:
 *       201:
 *         description: Partido creado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_partido:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear el partido
 */
router.post('/crear', partidoController.createPartido);

/**
 * @swagger
 * /partidos/eliminar/{id}:
 *   delete:
 *     tags:
 *       - Partidos
 *     summary: Eliminar un partido por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Partido eliminado exitosamente
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al eliminar el partido
 */
router.delete('/eliminar/:id', partidoController.deletePartido);

/**
 * @swagger
 * /partidos/actualizar/{id}:
 *   put:
 *     tags:
 *       - Partidos
 *     summary: Actualizar un partido
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               equipo_a:
 *                 type: integer
 *               equipo_b:
 *                 type: integer
 *               fecha:
 *                 type: string
 *                 format: date-time
 *               ganador:
 *                 type: integer
 *             example:
 *               equipo_a: 1
 *               equipo_b: 2
 *               fecha: "2024-06-01T12:00:00Z"
 *               ganador: null
 *     responses:
 *       200:
 *         description: Partido actualizado exitosamente
 *       400:
 *         description: Faltan campos obligatorios
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al actualizar el partido
 */
router.put('/actualizar/:id', partidoController.updatePartido);

/**
 * @swagger
 * /partidos/lastgamebyuser/{id}:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener información del último partido por ID de usuario
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del usuario
 *     responses:
 *       200:
 *         description: Información del último partido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Success
 *                 date:
 *                   type: string
 *                   format: date-time
 *                   example: "2024-06-09T19:21:17.000Z"
 *                 result:
 *                   type: string
 *                   example: "5 - 2"
 *       404:
 *         description: Jugador o partido no encontrado
 *       500:
 *         description: Error al obtener la información del partido
 */
router.get('/lastgamebyuser/:id', partidoController.getLastGameInfoByUserId);


/**
 * @swagger
 * /partidos/points/{teamId}:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener los puntos de un equipo
 *     parameters:
 *       - in: path
 *         name: teamId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Puntos del equipo
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 teamId:
 *                   type: integer
 *                 totalPoints:
 *                   type: integer
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener los puntos del equipo
 */
router.get('/points/:teamId', partidoController.getPointsByTeamId);


/**
 * @swagger
 * /partidos/teams/ordered-by-points:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener equipos ordenados por puntos
 *     responses:
 *       200:
 *         description: Lista de equipos ordenados por puntos
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id_equipo:
 *                     type: integer
 *                   total_points:
 *                     type: integer
 *       500:
 *         description: Error al obtener equipos ordenados por puntos
 */
router.get('/teams/ordered-by-points', partidoController.getTeamsOrderedByPoints);


/**
 * @swagger
 * /partidos/determine-winner/all:
 *   put:
 *     tags:
 *       - Partidos
 *     summary: Determinar el ganador de todos los partidos pasados
 *     responses:
 *       200:
 *         description: Ganadores determinados exitosamente para todos los partidos pasados
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *       500:
 *         description: Error al determinar los ganadores
 */
router.put('/determine-winner/all', partidoController.determineWinnerForAllMatches);


/**
 * @swagger
 * /partidos/determine-winner/single/{id}:
 *   put:
 *     tags:
 *       - Partidos
 *     summary: Determinar el ganador de un partido por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Ganador determinado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 ganador:
 *                   type: integer
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al determinar el ganador
 */
router.put('/determine-winner/single/:id', partidoController.determineWinnerById);


/**
 * @swagger
 * /partidos/clear-winner/{id}:
 *   put:
 *     tags:
 *       - Partidos
 *     summary: Eliminar el resultado del partido
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del partido
 *     responses:
 *       200:
 *         description: Resultado del partido eliminado exitosamente
 *       404:
 *         description: Partido no encontrado
 *       500:
 *         description: Error al eliminar el resultado del partido
 */
router.put('/clear-winner/:id', partidoController.clearWinner);

/**
 * @swagger
 * /partidos/wins/{teamId}:
 *   get:
 *     tags:
 *       - Partidos
 *     summary: Obtener el total de victorias de un equipo
 *     parameters:
 *       - in: path
 *         name: teamId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Total de victorias del equipo
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total_wins:
 *                   type: integer
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el total de victorias del equipo
 */
router.get('/wins/:teamId', partidoController.getTotalWinsByTeam);


module.exports = router;
