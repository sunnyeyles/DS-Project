import { Route, Routes, BrowserRouter } from 'react-router-dom'
import { Home } from '../Home'
import { Sparkles } from '../Sparkles'
export const RouterComponent = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Sparkles />} />
        <Route path="/home" element={<Home />} />
      </Routes>
    </BrowserRouter>
  )
}
