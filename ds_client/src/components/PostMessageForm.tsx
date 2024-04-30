import { useState } from 'react'
import { Textarea } from '@/components/ui/textarea'
import { Button } from './ui/button'
import { getPosts } from '@/apis/getPosts'
export const PostMessageForm = () => {
  const [setPost, post] = useState<string>('')

  return (
    <div className="flex flex-col align-center items-center gap-4">
      <Textarea className="max-w-2xl" placeholder="Write something..." />
      <Button onClick={getPosts}>post message</Button>
    </div>
  )
}
