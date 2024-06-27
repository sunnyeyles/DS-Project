import mongoose from 'mongoose'
import dotenv from 'dotenv'
dotenv.config()
export const connectToDatabase = async () => {
  const DB_USER = process.env.MONGO_INITDB_ROOT_USERNAME
  const DB_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD
  const uri = `mongodb+srv://${DB_USER}:${DB_PASSWORD}@sapesu.tmdndf1.mongodb.net/`

  try {
    // const DB_DATABASE = process.env.MONGO_INITDB_DATABASE
    // const DB_HOST = process.env.DATABASE_HOST
    // const DB_PORT = process.env.DATABASE_PORT
    // const DB_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME
    // const DB_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD
    // const URI = `mongodb://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}`
    // const client = new MongoClient(URI)
    // await client.connect()
    // await mongoose.connect(URI, {
    //   dbName: DB_DATABASE,
    // })

    await mongoose.connect(uri)

    console.log('database connected! 🔌')
  } catch (error) {
    console.error('connection error 💩:', error)
  }
}
