import { Request, Response } from 'express'
import { Message } from '../models/model.js'

export const getAllMessages = async (req: Request, res: Response) => {
  try {
    const requestFromFrontend = req.body
    console.log(requestFromFrontend)
    const messages = await Message.find()
    if (!messages || messages.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: 'No messages found' })
    }
    console.log(messages)
    return res.status(200).json(messages)
  } catch (error) {
    console.error('Error:', error)
    return res
      .status(500)
      .json({ success: false, message: 'Internal server error' })
  }
}
