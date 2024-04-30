const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerJSDoc = require('swagger-jsdoc');
const usuarioRoutes = require('./routes/usuarioRoutes');
const articuloRoutes = require('./routes/articuloRoutes');
const logJuegoRoutes = require('./routes/logJuegoRoutes');
const transaccionesRoutes = require('./routes/transaccionesRoutes');
const inventarioRoutes = require('./routes/inventarioRoutes');

const app = express();
const port = 3000;


const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'Sample API',
    version: '1.0.0',
    description: 'A simple Express Sample API',
  },
  servers: [
    {
      url: 'http://localhost:3000',
    },
  ],
};


const options = {
  swaggerDefinition,

  apis: ['./routes/*.js'],
};


const swaggerSpec = swaggerJSDoc(options);

app.use(express.json());


app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));


app.use('/usuarios', usuarioRoutes);
app.use('/articulos', articuloRoutes);
app.use('/logJuego', logJuegoRoutes);
app.use('/transacciones', transaccionesRoutes);
app.use('/inventario', inventarioRoutes);



app.get('/', (req, res) => res.send('Hello World!'));

app.listen(port, () => console.log(`Server listening on port ${port}!`));

module.exports = app;
