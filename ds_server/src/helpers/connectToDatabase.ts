import mongoose from 'mongoose'
import dotenv from 'dotenv'
dotenv.config()
export const connectToDatabase = async () => {
  const DB_USER = process.env.MONGO_INITDB_ROOT_USERNAME
  const DB_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD
  const uri = `mongodb+srv://${DB_USER}:${DB_PASSWORD}@sapesu.tmdndf1.mongodb.net/`

  try {
    await mongoose.connect(uri)

    console.log('database connected! 🔌')
  } catch (error) {
    console.error('connection error 💩:', error)
  }
}
