import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    sourcemap: true,
    outDir: 'build',
  },
  server: {
    host: '0.0.0.0',
    strictPort: true,
    port: 8080,
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})

// export default defineConfig({
//   base: '/',
//   plugins: [react()],
//   build: {
//     outDir: 'build',
//   },
// })
