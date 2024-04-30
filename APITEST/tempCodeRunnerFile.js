const usuarioRoutes = require('./routes/usuarioRoutes');
const articuloRoutes = require('./routes/articuloRoutes');

const app = express();
const port = 3000;


const swaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'API KND',
    version: '1.0.0',
    description: 'API para la pagina web de Sorteos Tec desarrollada por el equipo KND',
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
