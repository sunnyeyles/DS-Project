import { useState, ChangeEvent } from 'react'
import { Textarea } from '@/components/ui/textarea'
import { Button } from './ui/button'
import { getAllMessages } from '@/apis/getAllMessages'
import { sendPost } from '@/apis/sendPost'

export const PostMessageForm = () => {
  const [post, setPost] = useState<string>('')

  const handleGetMessages = async () => {
    try {
      // await getAllMessages()
      await sendPost({ postBody: post })
      console.log('Messages recieved')
    } catch (error) {
      console.error('Error getting messages:', error)
    }
  }

  const handlePostChange = (event: ChangeEvent<HTMLTextAreaElement>) => {
    setPost(event.target.value)
  }

  return (
    <div className="flex flex-col align-center items-center gap-4">
      <Textarea
        className="max-w-2xl"
        placeholder="Write something..."
        value={post}
        onChange={handlePostChange}
      />
      <Button onClick={handleGetMessages} type="submit">
        post message
      </Button>{' '}
    </div>
  )
}
