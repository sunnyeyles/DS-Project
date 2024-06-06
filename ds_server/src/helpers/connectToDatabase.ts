import { MongoClient } from 'mongodb'
import mongoose from 'mongoose'
import { config } from 'dotenv'

config()

export const connectToDatabase = async () => {
  try {
    const DB_DATABASE = process.env.MONGO_INITDB_DATABASE
    const DB_HOST = process.env.DATABASE_HOST
    const DB_PORT = process.env.DATABASE_PORT
    const DB_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME
    const DB_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD
    const DB_COLLECTION = process.env.DATABASE_COLLECTION

    const URI = `mongodb://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}`

    const client = new MongoClient(URI)

    const db = client.db(DB_DATABASE)

    const collection = db.collection(DB_COLLECTION)

    // const connectionString = 'mongodb://mongo:27017'
    // await mongoose.connect(
    //   `mongodb+srv://${dbUsername}:${dbPassword}@cluster0.h2lihr4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`
    // )
    await mongoose.connect(URI)
    console.log('database connected')
  } catch (error) {
    console.error('connection error:', error)
  }
}
