# Docker Setup for Chromecast Receiver

This directory contains all the necessary files to deploy the Chromecast receiver app using Docker and Dokploy.

## Files Overview

### Core Files
- `Dockerfile` - Basic Node.js container
- `Dockerfile.nginx` - Nginx-optimized container (recommended)
- `docker-compose.yml` - Development setup
- `docker-compose.prod.yml` - Production setup
- `nginx.conf` - Nginx configuration
- `dokploy.yml` - Dokploy-specific configuration

### Configuration Files
- `.dockerignore` - Files to exclude from Docker build
- `deploy.sh` - Deployment script for VPS
- `DOKPLOY_DEPLOYMENT.md` - Detailed Dokploy deployment guide

## Quick Start

### Option 1: Using Dokploy (Recommended)

1. **Upload this folder** to your GitHub repository
2. **Create a new project** in Dokploy
3. **Select "Docker Compose"** as deployment type
4. **Use `docker-compose.prod.yml`** as the compose file
5. **Configure your domain** and SSL
6. **Deploy!**

### Option 2: Manual Docker Deployment

1. **SSH into your VPS**
2. **Clone your repository**
3. **Navigate to the receiver folder**
4. **Run the deployment script:**
   ```bash
   ./deploy.sh
   ```

### Option 3: Manual Docker Commands

```bash
# Build the image
docker-compose -f docker-compose.prod.yml build

# Start the service
docker-compose -f docker-compose.prod.yml up -d

# Check status
docker-compose -f docker-compose.prod.yml ps

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

## Configuration

### Environment Variables
- `NODE_ENV=production`
- `PORT=8081`

### Ports
- **Internal:** 8081
- **External:** 8081 (or configure reverse proxy)

### Domains
Update the domain in `docker-compose.prod.yml`:
```yaml
- "traefik.http.routers.chromecast-receiver.rule=Host(`your-domain.com`)"
```

## Features

### Health Checks
- Built-in health check endpoint: `/health`
- Docker health check every 30 seconds
- Automatic restart on failure

### Security
- CORS headers for Chromecast compatibility
- Security headers (X-Frame-Options, etc.)
- HTTPS support via Let's Encrypt

### Performance
- Nginx for static file serving
- Gzip compression
- Cache headers for static assets
- Optimized Docker image size

## Monitoring

### Logs
```bash
# View all logs
docker-compose -f docker-compose.prod.yml logs

# Follow logs in real-time
docker-compose -f docker-compose.prod.yml logs -f

# View logs for specific service
docker-compose -f docker-compose.prod.yml logs chromecast-receiver
```

### Health Status
```bash
# Check container health
docker ps

# Test health endpoint
curl http://localhost:8081/health
```

## Troubleshooting

### Common Issues

1. **Container won't start**
   - Check logs: `docker-compose logs`
   - Verify port 8081 is available
   - Check Docker daemon is running

2. **Health check fails**
   - Verify nginx is running inside container
   - Check if port 8081 is accessible
   - Review nginx configuration

3. **Domain not accessible**
   - Check DNS settings
   - Verify SSL certificate
   - Check firewall rules

### Debug Commands

```bash
# Enter container shell
docker exec -it chromecast-receiver-prod sh

# Check nginx status
docker exec chromecast-receiver-prod nginx -t

# View nginx logs
docker exec chromecast-receiver-prod cat /var/log/nginx/access.log
```

## Scaling

### Horizontal Scaling
```bash
# Scale to 3 instances
docker-compose -f docker-compose.prod.yml up -d --scale chromecast-receiver=3
```

### Load Balancer
Use Traefik labels for automatic load balancing:
```yaml
labels:
  - "traefik.http.services.chromecast-receiver.loadbalancer.server.port=8081"
```

## Backup and Recovery

### Backup
- No persistent data to backup
- Configuration is in Git repository
- Docker images can be saved: `docker save chromecast-receiver > backup.tar`

### Recovery
- Redeploy from Git repository
- Restore Docker images: `docker load < backup.tar`
- Restart services: `docker-compose up -d`

## Support

For issues:
1. Check container logs
2. Verify configuration files
3. Test health endpoints
4. Review Docker and nginx documentation
