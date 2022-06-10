## Getting Started


1. Install yarn
2. run `yarn` in the root
3. install terraform
4. create an auth0 account
5. create a tenant in auth0
6. create a machine to machine application in auth0
7. under apis grant all privileges
8. add client id secret and domain to the .env
9. make sure tf could settings set to local for execution mode
10. create google creds in https://console.cloud.google.com/apis/credentials
11. create oauth client id
12. add email and profile scopes to google app
13. add redirect uri https://pinpal-dev.eu.auth0.com/login/callback to google app 

tf state is in terraform cloud
you need to terraform login and have 

cloudflare

1. set up cloudflare accoutn 
2. https://blog.cloudflare.com/deploy-workers-using-terraform/