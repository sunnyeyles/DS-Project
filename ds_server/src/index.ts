import express, { Express } from 'express'
import router from './routes/routes.js'
import { connectToDatabase } from './helpers/connectToDatabase.js'
import cors from 'cors'
import { corsOptions } from './config/corsOptions.js'
const app: Express = express()
const port = 3001
console.log('oi')
connectToDatabase()
app.use(cors(corsOptions))
app.use(express.json())
app.use(router)

// START SERVER
app.listen(port, () => {
  console.log(`Server is running at port ${port}`)
})
