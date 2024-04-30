import express, { Express, Request, Response } from 'express'
import router from './routes/routes.js'
import { connectToDatabase } from './helpers/connectToDatabase.js'
import cors from 'cors'
import { corsOptions } from './config/corsOptions.js'
import { postMessage } from './apis/postMessage.js'
const app: Express = express()
const port = 3001

connectToDatabase()
app.use(express.json())
app.use(cors(corsOptions))

app.use('/api', router)

// START SERVER
app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`)
})
