import { useState } from 'react'
import './App.css'
import {useAuth0} from "@auth0/auth0-react";


function App() {
  const [count, setCount] = useState(0)
  const { user, isAuthenticated, loginWithRedirect, logout, isLoading, error } = useAuth0();

  console.log(error)

  if(isLoading) {
    return <div>isloading</div>
  }

  console.log(isAuthenticated, user)

  return (
    <div className="App">
      {isAuthenticated && user && (
          <div>
            <img src={user.picture} alt={user.name} />
            <h2>{user.name}</h2>
            <p>{user.email}</p>
          </div>
      )}
      <button onClick={() => logout({ returnTo: window.location.origin })}>
        Log Out
      </button>
      <button onClick={() => loginWithRedirect()}>Log In</button>
    </div>
  )
}

export default App
