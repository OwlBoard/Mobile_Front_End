# Mobile Frontend - Docker Setup

## Overview
This Flutter web application is containerized using Docker for easy deployment and consistent environments across different machines.

## Features
✅ **Dependency Caching**: Flutter dependencies are cached in Docker layers - they only re-download when `pubspec.yaml` changes  
✅ **Multi-stage Build**: Separate build and runtime stages for smaller final image  
✅ **Production Optimized**: Uses nginx to serve the static files efficiently  
✅ **Health Checks**: Built-in health monitoring  
✅ **Fast Rebuilds**: Only changed layers are rebuilt

## Prerequisites
- Docker Desktop installed
- Docker Compose installed (usually comes with Docker Desktop)

## Quick Start

### 1. Build the Docker Image
```bash
docker-compose build
```

**Note**: First build will take 5-10 minutes as it downloads Flutter SDK and dependencies. Subsequent builds are much faster (30-60 seconds) because dependencies are cached.

### 2. Run the Container
```bash
docker-compose up -d
```

### 3. Access the Application
Open your browser and navigate to:
```
http://localhost:3000
```

### 4. Stop the Container
```bash
docker-compose down
```

## Docker Commands

### View Logs
```bash
docker-compose logs -f mobile_frontend
```

### Rebuild After Code Changes
```bash
docker-compose up -d --build
```

### Check Container Status
```bash
docker-compose ps
```

### Access Container Shell
```bash
docker exec -it mobile_frontend sh
```

## How Dependency Caching Works

The Dockerfile uses a multi-stage build with smart layer caching:

1. **Copy `pubspec.yaml` and `pubspec.lock` first**
   - These files are copied before the rest of the code
   - `flutter pub get` runs with just these files
   
2. **Docker caches this layer**
   - If `pubspec.yaml` doesn't change, Docker reuses the cached layer
   - Dependencies are NOT re-downloaded on rebuild
   
3. **Copy rest of code**
   - Application code is copied after dependencies
   - Changes to your code don't invalidate the dependency cache

4. **Build and serve**
   - Flutter builds the web app
   - Nginx serves the static files in production

## File Structure
```
Mobile_Front_End/
├── Dockerfile              # Multi-stage build configuration
├── docker-compose.yml      # Service orchestration
├── nginx.conf             # Nginx web server configuration
├── .dockerignore          # Files to exclude from Docker build
└── pubspec.yaml           # Flutter dependencies (cached layer)
```

## Environment Configuration

To connect to different backend services, update the API URLs in your Flutter app before building:

```dart
// lib/config/api_config.dart
class ApiConfig {
  static const String userServiceUrl = 'http://user_service:5000';
  static const String commentsServiceUrl = 'http://comments_service:8001';
}
```

## Integration with Other Services

To run the mobile frontend alongside other services (User Service, Comments Service), create a main `docker-compose.yml` in the parent directory:

```yaml
version: '3.8'

services:
  mobile_frontend:
    build: ./Mobile_Front_End
    ports:
      - "3000:80"
    depends_on:
      - user_service
      - comments_service
    networks:
      - app-network

  user_service:
    build: ./User_Service
    ports:
      - "5000:5000"
    networks:
      - app-network

  comments_service:
    build: ./Comments_Service
    ports:
      - "8001:8001"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

## Troubleshooting

### Build fails with "Flutter SDK not found"
- The Dockerfile uses the official Flutter Docker image
- Ensure you have a stable internet connection for the first build

### Changes not reflected after rebuild
```bash
# Force rebuild without cache
docker-compose build --no-cache
docker-compose up -d
```

### Port 3000 already in use
Change the port in `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Use port 8080 instead
```

### Container exits immediately
Check logs:
```bash
docker-compose logs mobile_frontend
```

## Performance Tips

1. **Keep `pubspec.yaml` stable** - Only change dependencies when needed
2. **Use `.dockerignore`** - Excludes unnecessary files from build context
3. **Enable BuildKit** for faster builds:
   ```bash
   # Windows PowerShell
   $env:DOCKER_BUILDKIT=1
   docker-compose build
   ```

## Production Deployment

For production, consider:
- Using a specific Flutter version tag instead of `:stable`
- Setting up HTTPS with SSL certificates
- Implementing proper error pages
- Adding monitoring and logging
- Using environment-specific builds

## License
See main project LICENSE file.
