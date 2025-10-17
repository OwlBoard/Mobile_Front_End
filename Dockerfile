# Stage 1: Build the Flutter web application
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files first (for dependency caching)
COPY pubspec.yaml pubspec.lock ./

# Get dependencies (this layer will be cached if pubspec files don't change)
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Generate JSON serialization code
RUN dart run build_runner build --delete-conflicting-outputs

# Build the web application
RUN flutter build web --release --web-renderer canvaskit

# Stage 2: Serve the application with nginx
FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
