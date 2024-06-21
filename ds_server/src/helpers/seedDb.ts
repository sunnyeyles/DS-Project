import { Message } from '../models/model.js'

export const seedDatabase = async () => {
  try {
    const messages = [
      { message: 'Message 1' },
      { message: 'Message 2' },
      { message: 'Message 3' },
    ]

    await Message.insertMany(messages)

    console.log('database seeded! woop 🔌')
  } catch (error) {
    console.error(
      'error seeding database because its not fuckeenn connected or something who knows 💩, this is the error it gave us though have fun tryna decrypt that shit',
      error
    )
  }
}
