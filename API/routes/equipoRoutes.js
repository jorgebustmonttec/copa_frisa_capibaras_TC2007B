//equipoRoutes.js

const express = require('express');
const router = express.Router();
const equipoController = require('../controllers/equipoController');
const upload = require('../utils/upload')('escudos'); // Specify folder as 'escudos'


/**
 * @swagger
 * tags:
 *   name: Equipos
 *   description: Todo sobre Equipos
 *
 * components:
 *   schemas:
 *     Equipo:
 *       type: object
 *       required:
 *         - nombre_equipo
 *         - escuela
 *       properties:
 *         id_equipo:
 *           type: integer
 *           description: Identificador único del equipo.
 *         nombre_equipo:
 *           type: string
 *           description: Nombre del equipo.
 *         escuela:
 *           type: string
 *           description: Nombre de la escuela.
 *       example:
 *         id_equipo: 1
 *         nombre_equipo: Los Tigres de Juárez
 *         escuela: Primaria Benito Juárez
 */

/**
 * @swagger
 * /equipos:
 *   get:
 *     tags:
 *       - Equipos
 *     summary: Obtener todos los equipos
 *     responses:
 *       200:
 *         description: Lista de todos los equipos
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Equipo'
 *       500:
 *         description: Error al obtener los equipos
 */
router.get('/', equipoController.getAllEquipos);

/**
 * @swagger
 * /equipos/single/{id}:
 *   get:
 *     tags:
 *       - Equipos
 *     summary: Obtener información de un equipo por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Información del equipo
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Equipo'
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el equipo
 */
router.get('/single/:id', equipoController.getEquipoById);

/**
 * @swagger
 * /equipos/single/{id}/escudo:
 *   get:
 *     tags:
 *       - Equipos
 *     summary: Obtener el escudo de un equipo por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Escudo del equipo
 *         content:
 *           image/png:
 *             schema:
 *               type: string
 *               format: binary
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al obtener el escudo del equipo
 */
router.get('/single/:id/escudo', equipoController.getEquipoShieldById);
/**
 * @swagger
 * /equipos/create:
 *   post:
 *     tags:
 *       - Equipos
 *     summary: Crear un nuevo equipo
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               nombre_equipo:
 *                 type: string
 *               escuela:
 *                 type: string
 *             example:
 *               nombre_equipo: Los Tigres de Juárez
 *               escuela: Primaria Benito Juárez
 *     responses:
 *       201:
 *         description: Equipo creado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_equipo:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear el equipo
 */
router.post('/create', equipoController.createEquipo);

/**
 * @swagger
 * /equipos/create/{id}/escudo:
 *   post:
 *     tags:
 *       - Equipos
 *     summary: Agregar una imagen de escudo a un equipo
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               escudo:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Escudo del equipo actualizado exitosamente
 *       400:
 *         description: No se proporcionó ninguna imagen
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al actualizar el escudo del equipo
 */
router.post('/create/:id/escudo', upload.single('escudo'), equipoController.addEquipoImg);

/**
 * @swagger
 * /equipos/update/{id}:
 *   put:
 *     tags:
 *       - Equipos
 *     summary: Actualizar un equipo
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               nombre_equipo:
 *                 type: string
 *               escuela:
 *                 type: string
 *             example:
 *               nombre_equipo: Los Tigres de Juárez
 *               escuela: Primaria Benito Juárez
 *     responses:
 *       200:
 *         description: Equipo actualizado exitosamente
 *       400:
 *         description: Faltan campos obligatorios
 *       404:
 *         description: Equipo no encontrado
 *       500:
 *         description: Error al actualizar el equipo
 */
router.put('/update/:id', equipoController.updateEquipo);


module.exports = router;
