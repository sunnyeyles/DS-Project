import express, { Express } from 'express'
import router from './routes/routes.js'
import { connectToDatabase } from './helpers/connectToDatabase.js'
// cors isn't being used, this might result in some errors later, might have to check it out
import cors from 'cors'
import { corsOptions } from './config/corsOptions.js'
import { seedDatabase } from './helpers/seedDb.js'
const app: Express = express()
const port = 3001

setTimeout(() => {
  connectToDatabase()
  seedDatabase()
}, 20000)

// app.use(cors(corsOptions))
app.use(express.json())
app.use(router)

// START SERVER
app.listen(port, () => {
  console.log(`Server is running at port ${port}`)
})
