import { PostMessageForm } from './PostMessageForm'
import { PostItem } from './PostItem'

export const Home = () => {
  return (
    <div className="p-2">
      <h1 className="md:text-7xl text-3xl lg:text-7xl text-white text-center m-12">
        Share your deepest darkest secrets
      </h1>
      <PostMessageForm />
      <div className="flex flex-wrap gap-12 justify-center items-center">
        <PostItem />
        <PostItem />
        <PostItem />
        <PostItem />
        <PostItem />
        <PostItem />
        <PostItem />
      </div>
    </div>
  )
}
