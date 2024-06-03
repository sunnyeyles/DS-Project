import { useState, ChangeEvent } from 'react'
import { Textarea } from '@/components/ui/textarea'
import { Button } from './ui/button'
import { useAddNewMessageMutation } from '@/features/apiSlice'

export const PostMessageForm = () => {
  const [post, setPost] = useState<string>('')
  const [addMessage] = useAddNewMessageMutation()

  const handleSendMessage = async () => {
    try {
      console.log(post)
      addMessage({ message: post })
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
      <Button onClick={handleSendMessage} type="submit">
        post message
      </Button>{' '}
    </div>
  )
}
