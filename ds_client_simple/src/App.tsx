import './App.css'
import { Header } from './ui/header'
import { headerText } from './constants'
import { Body } from './ui/body'
function App() {
  return (
    <>
      <Header headerText={headerText} />
      <Body />
    </>
  )
}

export default App
