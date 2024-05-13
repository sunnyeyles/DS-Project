// importing mongoose here makes mongoose available globally
import mongoose from 'mongoose'
import { config } from 'dotenv'

config()

export const connectToDatabase = async () => {
  try {
    const dbUsername = process.env.DB_USERNAME
    const dbPassword = process.env.DB_PASSWORD
    await mongoose.connect(
      `mongodb+srv://${dbUsername}:${dbPassword}@cluster0.h2lihr4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`
    )
    console.log('database connected')
  } catch (error) {
    console.error('connection error:', error)
  }
}
