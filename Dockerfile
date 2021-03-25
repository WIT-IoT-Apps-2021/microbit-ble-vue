
## build stage ##
FROM node:14-alpine as build-stage

# Define a working directory
WORKDIR /build

# Copy source files to container
COPY . .

# Install the required dependencies
RUN npm install

# Build the web app
RUN npm run build

## production stage ##
FROM nginx:stable-alpine as production

# Copy the build output to the default Nginx directory
COPY --from=build-stage /build/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]