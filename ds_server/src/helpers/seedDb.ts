import mongoose from 'mongoose'
import { Message } from '../models/model.js'

export const seedDatabase = async () => {
  try {
    const messages = [
      { message: 'Message 1' },
      { message: 'Message 2' },
      { message: 'Message 3' },
    ]

    await Message.insertMany(messages)

    console.log('Database seeded successfully')
  } catch (error) {
    console.error('Error seeding database:', error)
  }
}
