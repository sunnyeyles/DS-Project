import { Request, Response } from 'express'

import { Message } from '../models/model.js'

export const getAllMessages = async (req: Request, res: Response) => {
  console.log('ok')
  try {
    const messages = await Message.find()
    if (!messages) {
      res.status(404).json({ success: false, message: 'No messages found' })
    }
    console.log(messages)
    res.status(201).json(messages)
  } catch (error) {
    console.error('Error:', error)
    return res
      .status(500)
      .json({ success: false, message: 'Internal server error' })
  }
}
