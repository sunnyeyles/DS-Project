import { PostMessageForm } from './PostMessageForm'
import { ModeToggle } from './ThemeToggleButton'
import { Button } from './ui/button'
export const Home = () => {
  return (
    <div className="">
      <ModeToggle />
      <PostMessageForm />
      <h1 className="dark:text-white">hello</h1>
      <Button>hello</Button>
    </div>
  )
}
