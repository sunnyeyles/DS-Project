import { MongoClient } from 'mongodb'
import mongoose from 'mongoose'

export const connectToDatabase = async () => {
  try {
    const DB_DATABASE = process.env.MONGO_INITDB_DATABASE
    const DB_HOST = process.env.DATABASE_HOST
    const DB_PORT = process.env.DATABASE_PORT
    const DB_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME
    const DB_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD

    const URI = `mongodb://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}`

    const client = new MongoClient(URI)
    await client.connect()

    await mongoose.connect(URI, {
      dbName: DB_DATABASE,
    })

    console.log('database connected! 🔌')
  } catch (error) {
    console.error('connection error 💩:', error)
  }
}
