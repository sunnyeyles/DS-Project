# Backend

Backend Service using Node.js, Express, and Mongoose

## Overview

This backend service provides endpoints to add new messages to a MongoDB database and retrieve all existing messages.

## Installation

1. **Clone the repository:**

   ```
   git clone <repository-url>
   cd ds_server
   ```

2. **Install the dependencies:**

   ```
   npm install
   ```

3. **Environment variables:**

   ```
   MONGO_INITDB_ROOT_USERNAME=username
   MONGO_INITDB_ROOT_PASSWORD=password

   ```

## Scripts

- `npm run build`: Transpiles TypeScript files to JavaScript (required before starting the server).
- `npm start`: Starts the server using the transpiled JavaScript files.
- `npm run dev`: Starts the server in development mode with TypeScript watch and nodemon for auto-reloading.
- `npm run lint`: Lints the project using ESLint.

## Dependencies

- Express: Fast, unopinionated, minimalist web framework for Node.js.
- Mongoose: MongoDB object modeling for Node.js, providing a straightforward schema-based solution to model your application data.
- cors: Middleware for enabling Cross-Origin Resource Sharing (CORS) in Express applications.
- dotenv: Loads environment variables from a .env file into process.env.
- concurrently: Runs multiple npm scripts concurrently.
- typescript: TypeScript is a typed superset of JavaScript that compiles to plain JavaScript.
- typescript-eslint: ESLint plugin for TypeScript.
