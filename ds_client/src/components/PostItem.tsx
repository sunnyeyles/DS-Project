import { IMessageTypes } from '@/types/mainTypes'

export const PostItem = ({ message, createdAt }: IMessageTypes) => {
  return (
    <div className="flex flex-col gap-4 bg-slate-800 border w-80 h-80 rounded-md p-10">
      <h3 className="text-slate-300 text-md italic">Anonymous-</h3>
      <p className="text-slate-600">{message}</p>
      <p>{createdAt}</p>
    </div>
  )
}
