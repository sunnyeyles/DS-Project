import { RouterComponent } from './components/utility-components/RouterComponent'
import { Provider } from 'react-redux'
import { store } from './features/store'
import { UseDispatch } from 'react-redux'

function App() {
  return (
    <div>
      <Provider store={store}>
        <RouterComponent />
      </Provider>
    </div>
  )
}

export default App
