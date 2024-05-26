import { Request, Response } from 'express'
import { Message } from '../models/model.js'

export const postMessage = async (req: Request, res: Response) => {
  try {
    console.log(req.body)
    const { message } = req.body

    const newMessage = await Message.create({ message })

    res.status(201).json({
      success: true,
      message: 'Message created woo',
      data: newMessage,
    })
  } catch (error) {
    console.error('Error:', error)
    res.status(500).json({ success: false, message: 'Internal server error' })
  }
}
