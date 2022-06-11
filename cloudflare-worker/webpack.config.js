const path = require('path')

module.exports = {
  entry: {
    'serve-app': './src/serve-app.ts',
    'serve-api': './src/serve-api.ts',
  },
  output: {
    path: path.resolve(__dirname, '../dist/cloudflare-worker/'),
    filename: '[name].bundle.js',
  },
  devtool: 'cheap-module-source-map',
  mode: 'development',
  resolve: {
    extensions: ['.ts', '.tsx', '.js'],
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: 'ts-loader',
        options: {
          // transpileOnly is useful to skip typescript checks occasionally:
          // transpileOnly: true,
        },
      },
    ],
  },
}
