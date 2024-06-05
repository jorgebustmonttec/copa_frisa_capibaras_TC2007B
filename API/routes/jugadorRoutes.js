//jugadorRoutes.js

const express = require('express');
const router = express.Router();
const jugadorController = require('../controllers/jugadorController');

/**
 * @swagger
 * tags:
 *   name: Jugadores
 *   description: All about Jugadores
 * 
 * components:
 *   schemas:
 *     Jugador:
 *       type: object
 *       required:
 *         - username
 *         - display_name
 *         - correo
 *         - password
 *         - fecha_nac
 *         - CURP
 *         - domicilio
 *         - telefono
 *         - nombre
 *         - apellido_p
 *         - apellido_m
 *         - num_imss
 *         - id_equipo
 *       properties:
 *         username:
 *           type: string
 *           description: Username of the user.
 *         display_name:
 *           type: string
 *           description: Display name of the user.
 *         correo:
 *           type: string
 *           description: Email address of the user.
 *         password:
 *           type: string
 *           description: Password of the user.
 *         fecha_nac:
 *           type: string
 *           format: date
 *           description: Birth date of the player.
 *         CURP:
 *           type: string
 *           description: CURP of the player.
 *         domicilio:
 *           type: string
 *           description: Address of the player.
 *         telefono:
 *           type: string
 *           description: Phone number of the player.
 *         nombre:
 *           type: string
 *           description: First name of the player.
 *         apellido_p:
 *           type: string
 *           description: Paternal surname of the player.
 *         apellido_m:
 *           type: string
 *           description: Maternal surname of the player.
 *         num_imss:
 *           type: string
 *           description: IMSS number of the player.
 *         id_equipo:
 *           type: integer
 *           description: Team ID the player belongs to.
 *       example:
 *         username: johndoe
 *         display_name: John Doe
 *         correo: johndoe@example.com
 *         password: password123
 *         fecha_nac: "2000-01-01"
 *         CURP: ABCD123456HDEFLL09
 *         domicilio: 1234 Main St
 *         telefono: 555-1234
 *         nombre: John
 *         apellido_p: Doe
 *         apellido_m: Smith
 *         num_imss: 123456789
 *         id_equipo: 1
 *
 * /jugadores:
 *   post:
 *     tags:
 *       - Jugadores
 *     summary: Create a new jugador account
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Jugador'
 *     responses:
 *       201:
 *         description: Jugador account created successfully
 *       500:
 *         description: Server error
 */
router.post('/', jugadorController.createJugador);

/**
 * @swagger
 * tags:
 *   name: Jugadores
 *   description: All about Jugadores
 * 
 * components:
 *   schemas:
 *     JugadorSmall:
 *       type: object
 *       properties:
 *         id_jugador:
 *           type: integer
 *           description: Identificador único del jugador.
 *         nombre:
 *           type: string
 *           description: Nombre del jugador.
 *         id_equipo:
 *           type: integer
 *           description: Identificador del equipo al que pertenece el jugador.
 *         nombre_equipo:
 *           type: string
 *           description: Nombre del equipo al que pertenece el jugador.
 *         username:
 *           type: string
 *           description: Nombre de usuario del jugador.
 *         display_name:
 *           type: string
 *           description: Nombre para mostrar del jugador.
 *       example:
 *         id_jugador: 1
 *         nombre: Carlos
 *         id_equipo: 1
 *         nombre_equipo: Equipo A
 *         username: carlos.martinez
 *         display_name: Carlos Martinez
 *
 * /jugadores/small:
 *   get:
 *     tags:
 *       - Jugadores
 *     summary: Obtener una lista pequeña de jugadores
 *     responses:
 *       200:
 *         description: Una lista de jugadores con información básica.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/JugadorSmall'
 */
router.get('/small', jugadorController.getAllJugadoresSmall);

/**
 * @swagger
 * /jugadores/small/{id}:
 *   get:
 *     tags:
 *       - Jugadores
 *     summary: Obtener información pequeña de un jugador por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del jugador
 *     responses:
 *       200:
 *         description: Información básica del jugador.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/JugadorSmall'
 *       404:
 *         description: Jugador no encontrado
 */
router.get('/small/:id', jugadorController.getJugadorSmallById);




module.exports = router;
