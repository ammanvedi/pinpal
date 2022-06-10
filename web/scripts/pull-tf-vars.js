const {join} = require('path')
const {writeFileSync} = require('fs')

const tfBasePath = join(__dirname, '..', '..', 'terraform', 'environment', process.env.ENV)

const getVarsFromTfVarsFile = () => {
    const tfVarsPath = join(tfBasePath, '.auto.tfvars.json')
    const tfVars = require(tfVarsPath)
    const varKeys = Object.keys(tfVars)
    return varKeys.map(key => {
        return `VITE_TF_${key.toUpperCase()}="${tfVars[key]}"`
    }).join('\n')

}

const getVarsFromTfOutput = () => {
    const tfOutPath = join(tfBasePath, '.out.json')
    const tfOut = require(tfOutPath)
    const keys = Object.keys(tfOut)
    return keys.map(key => {
        return `VITE_TF_OUT_${key.toUpperCase()}="${tfOut[key].value}"`
    }).join('\n')
}

writeFileSync('.env', [getVarsFromTfVarsFile(), getVarsFromTfOutput()].join('\n'))



