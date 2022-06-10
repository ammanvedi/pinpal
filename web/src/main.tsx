import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
import { Auth0Provider } from "@auth0/auth0-react";

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
      <Auth0Provider
          domain={import.meta.env.VITE_TF_AUTH0_DOMAIN}
          clientId={import.meta.env.VITE_TF_OUT_AUTH0_WEB_CLIENT_ID}
          redirectUri={window.location.origin}>
          <App />
      </Auth0Provider>
  </React.StrictMode>
)