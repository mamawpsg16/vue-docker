# Use an official Node.js LTS (Long Term Support) image as the base
FROM node:lts-alpine

# Set the working directory inside the container
WORKDIR /app

# Create a non-root user and group
# This user will own the files and run the application
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Change ownership of the working directory to the non-root user
# This is crucial for npm install to have write permissions in /app
RUN chown -R appuser:appgroup /app

# Copy package.json and package-lock.json first to leverage Docker cache
# This means npm install only runs if these files change
# Ensure these files are also owned by 'appuser'
COPY --chown=appuser:appgroup app/package*.json ./

# Switch to the non-root user before installing dependencies
# This ensures node_modules are owned by 'appuser'
USER appuser

# Install project dependencies
RUN npm install

# Copy the rest of your Vue application code from the app directory
# Ensure these files are also owned by 'appuser'
COPY --chown=appuser:appgroup app/ .

# Expose the port that Vite will run on
EXPOSE 5173

# Define the default command to run when the container starts
# Since we're now handling --host in vite.config.js, we can simplify this
CMD ["npm", "run", "dev"]