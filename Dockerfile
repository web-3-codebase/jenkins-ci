# Use a newer version of Node.js (e.g., Node 18)
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Build the application using Vite
RUN npm run build

# Use nginx to serve the built application
FROM nginx:1.21

# Copy the build output to the nginx root directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
