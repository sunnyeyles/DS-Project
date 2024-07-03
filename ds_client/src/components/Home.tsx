import { PostMessageForm } from './PostMessageForm'
import { PostItem } from './PostItem'
import { useGetAllMessagesQuery } from '../features/apiSlice'
import { IMessageTypes } from '@/types/mainTypes'

export const Home = () => {
  const { data } = useGetAllMessagesQuery()
  // console.log(data)

  return (
    <div className="p-2">
      <h1 className="md:text-7xl text-3xl lg:text-7xl text-white text-center m-12">
        Post something, it's anonymous
      </h1>
      <PostMessageForm />
      <div className="flex flex-wrap gap-12 justify-center items-center">
        {data &&
          data
            .slice()
            .reverse()
            .map((item: IMessageTypes, index: number) => (
              <PostItem
                key={index.toString()}
                message={item.message}
                // createdAt={item.createdAt}
              />
            ))}
      </div>
    </div>
  )
}
