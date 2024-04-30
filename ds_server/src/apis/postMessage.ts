import { Request, Response } from 'express'
import { Message } from '../models/model.js'

// declare the function as asynchronous, this basically says, keep running lines of code even if the previous line has not yet finished executing(non blocking it's called)
export const postMessage = async (req: Request, res: Response) => {
  try {
    // the request.body is the data that is being sent from the frontend
    console.log(req.body)
    const { message } = req.body

    // this is creating a new entry in the database
    // the await keyword basically says - do not proceed executing code until this has finished(make the code blocking)
    const newMessage = await Message.create({ message })

    // send a response back to client including the newly created post
    res.status(201).json({
      success: true,
      message: 'Message created woo',
      data: newMessage,
    })
  } catch (error) {
    // log the error to the console
    console.error('Error:', error)
    // send an error message back to the client in case anything goes wrong
    res.status(500).json({ success: false, message: 'Internal server error' })
  }
}
