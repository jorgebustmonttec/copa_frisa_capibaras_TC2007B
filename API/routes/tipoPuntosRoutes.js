const express = require('express');
const router = express.Router();
const tipoPuntosController = require('../controllers/tipoPuntosController');

/**
 * @swagger
 * tags:
 *   name: TipoPuntos
 *   description: Todo sobre Tipos de Puntos
 *
 * components:
 *   schemas:
 *     TipoPunto:
 *       type: object
 *       required:
 *         - nombre
 *       properties:
 *         id_tipo:
 *           type: integer
 *           description: Identificador único del tipo de punto.
 *         nombre:
 *           type: string
 *           description: Nombre del tipo de punto.
 *       example:
 *         id_tipo: 1
 *         nombre: "Gol"
 */

/**
 * @swagger
 * /tipo_puntos:
 *   get:
 *     tags:
 *       - TipoPuntos
 *     summary: Obtener todos los tipos de puntos
 *     responses:
 *       200:
 *         description: Lista de todos los tipos de puntos
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/TipoPunto'
 *       500:
 *         description: Error al obtener los tipos de puntos
 */
router.get('/', tipoPuntosController.getAllTipoPuntos);

/**
 * @swagger
 * /tipo_puntos/{id}:
 *   get:
 *     tags:
 *       - TipoPuntos
 *     summary: Obtener un tipo de punto por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del tipo de punto
 *     responses:
 *       200:
 *         description: Información del tipo de punto
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/TipoPunto'
 *       404:
 *         description: Tipo de punto no encontrado
 *       500:
 *         description: Error al obtener el tipo de punto
 */
router.get('/:id', tipoPuntosController.getTipoPuntoById);

module.exports = router;
