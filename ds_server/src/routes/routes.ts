import { postMessage } from '../apis/postMessage.js'
import { getAllMessages } from '../apis/getAllMessages.js'
import express, { Router } from 'express'
const router: Router = express.Router()

router.post('/api/post-message', postMessage)
router.get('/api/get-messages', getAllMessages)

export default router
