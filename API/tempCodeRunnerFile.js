const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerJSDoc = require('swagger-jsdoc');
const usuarioRoutes = require('./routes/usuarioRoutes');
const jugadorRoutes = require('./routes/jugadorRoutes');


const app = express();
const port = 3000;


const options = {
  definition: {
      openapi: '3.0.0',
      info: {
          title: 'User API',
          version: '1.0.0',
          description: 'A simple Express User API',
      },
      servers: [
          {
              url: 'http://localhost:3000',
          },
      ],
  },
  apis: ['API/routes/**/*.js'], // Note the addition of 'API/' before 'routes/'
};


const swaggerSpec = swaggerJSDoc(options);

app.use(express.json());


app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));


app.use('/usuarios', usuarioRoutes);
app.use('/jugadores', jugadorRoutes);



app.get('/', (req, res) => res.send('Hello World!'));

app.listen(port, () => console.log(`Server listening on port ${port}!`));

module.exports = app;
