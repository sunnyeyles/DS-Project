import { Button } from './ui/button'

import { useNavigate } from 'react-router-dom'

export const Sparkles = () => {
  const navigate = useNavigate()
  const navigateToLogin = () => {
    navigate('/home')
  }
  return (
    <div className="h-screen w-full bg-black flex flex-col items-center justify-center overflow-hidden">
      <h1 className="md:text-7xl text-3xl lg:text-9xl font-bold text-center text-white relative z-20">
        Sa Pe Su
      </h1>
      <div className="w-[40rem] h-40 relative flex flex-col justify-center items-center">
        <div className="absolute inset-x-20 top-0 bg-gradient-to-r from-transparent via-indigo-500 to-transparent h-[2px] w-3/4 blur-sm" />
        <div className="absolute inset-x-20 top-0 bg-gradient-to-r from-transparent via-indigo-500 to-transparent h-px w-3/4" />
        <div className="absolute inset-x-60 top-0 bg-gradient-to-r from-transparent via-sky-500 to-transparent h-[5px] w-1/4 blur-sm" />
        <div className="absolute inset-x-60 top-0 bg-gradient-to-r from-transparent via-sky-500 to-transparent h-px w-1/4" />

        <div className="absolute bottom-5 z-10">
          <Button onClick={navigateToLogin}>Check that shit ouutt</Button>
        </div>

        <div className="absolute inset-0 w-full h-full bg-black [mask-image:radial-gradient(350px_200px_at_top,transparent_20%,white)]"></div>
      </div>
    </div>
  )
}
