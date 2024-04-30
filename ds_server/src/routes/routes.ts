import { postMessage } from '../apis/postMessage.js'
import { getAllMessages } from '../apis/getAllMessages.js'
import express, { Router, Request, Response } from 'express'
const router: Router = express.Router()

router.post('/post-message', postMessage)
router.get('/get-messages', getAllMessages)

export default router
