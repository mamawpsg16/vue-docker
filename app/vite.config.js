import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  server: {
    host: '0.0.0.0',  // Allow external connections
    port: 5173,       // Explicit port definition
    watch: {
      usePolling: true,
      interval: 1000    // Matches CHOKIDAR_INTERVAL
    },
    hmr: {
      port: 5173      // Ensure HMR uses same port
    }
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
})