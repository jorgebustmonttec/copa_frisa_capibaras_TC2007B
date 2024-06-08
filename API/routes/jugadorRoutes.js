//jugadorRoutes.js

const express = require('express');
const router = express.Router();
const jugadorController = require('../controllers/jugadorController');

/**
* @swagger
* tags:
*   name: Jugadores
*   description: Todo sobre Jugadores
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
*           description: Nombre de usuario.
*         display_name:
*           type: string
*           description: Nombre para mostrar del usuario.
*         correo:
*           type: string
*           description: Correo electrónico del usuario.
*         password:
*           type: string
*           description: Contraseña del usuario.
*         fecha_nac:
*           type: string
*           format: date
*           description: Fecha de nacimiento del jugador.
*         CURP:
*           type: string
*           description: CURP del jugador.
*         domicilio:
*           type: string
*           description: Dirección del jugador.
*         telefono:
*           type: string
*           description: Número de teléfono del jugador.
*         nombre:
*           type: string
*           description: Nombre del jugador.
*         apellido_p:
*           type: string
*           description: Apellido paterno del jugador.
*         apellido_m:
*           type: string
*           description: Apellido materno del jugador.
*         num_imss:
*           type: string
*           description: Número de IMSS del jugador.
*         id_equipo:
*           type: integer
*           description: ID del equipo al que pertenece el jugador.
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
* /jugadores/crear:
*   post:
*     tags:
*       - Jugadores
*     summary: Crear una nueva cuenta de jugador
*     requestBody:
*       required: true
*       content:
*         application/json:
*           schema:
*             $ref: '#/components/schemas/Jugador'
*     responses:
*       201:
*         description: Cuenta de jugador creada exitosamente
*       400:
*         description: Solicitud incorrecta
*       500:
*         description: Error del servidor
*/
router.post('/crear', jugadorController.createJugador);


/**
 * @swagger
 * tags:
 *   name: Jugadores
 *   description: Todo sobre Jugadores
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
*       500:
*         description: Error al obtener los jugadores
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
 *       500:
 *         description: Error al obtener el jugador
 */
router.get('/small/:id', jugadorController.getJugadorSmallById);

/**
 * @swagger
 * /jugadores/add-to-equipo:
 *   post:
 *     tags:
 *       - Jugadores
 *     summary: Agregar un jugador a un equipo
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_jugador:
 *                 type: integer
 *               id_equipo:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Jugador agregado al equipo exitosamente
 *       404:
 *         description: Jugador no encontrado
 *       500:
 *         description: Error del servidor
 */
router.post('/add-to-equipo', jugadorController.addJugadorToEquipo);

/**
 * @swagger
 * /jugadores/remove-from-equipo:
 *   post:
 *     tags:
 *       - Jugadores
 *     summary: Remover un jugador de un equipo
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               id_jugador:
 *                 type: integer
 *     responses:
 *       200:
*         description: Jugador removido del equipo exitosamente
*       404:
*         description: Jugador no encontrado
*       500:
*         description: Error del servidor
 */
router.post('/remove-from-equipo', jugadorController.removeJugadorFromEquipo);

module.exports = router;
