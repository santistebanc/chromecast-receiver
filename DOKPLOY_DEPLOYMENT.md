# Dokploy Deployment Guide for Chromecast Receiver

This guide explains how to deploy the Chromecast receiver app to your VPS using Dokploy.

## Prerequisites

- VPS with Dokploy installed
- Domain name pointing to your VPS
- SSL certificate (Let's Encrypt recommended)

## Deployment Steps

### 1. Prepare Your Repository

1. **Create a GitHub repository** for your receiver app
2. **Upload the receiver folder** to the repository
3. **Make sure all files are committed** and pushed to main branch

### 2. Configure Dokploy

1. **Login to your Dokploy dashboard**
2. **Create a new project** called "chromecast-receiver"
3. **Select "Docker Compose" as the deployment type**

### 3. Repository Configuration

**Repository URL:** `https://github.com/yourusername/chromecast-receiver.git`
**Branch:** `main`
**Path:** `receiver`

### 4. Environment Variables

Add these environment variables in Dokploy:

```
NODE_ENV=production
PORT=8081
```

### 5. Domain Configuration

**Primary Domain:** `your-domain.com`
**Additional Domains:** `www.your-domain.com` (optional)

### 6. SSL Configuration

- **Enable SSL:** Yes
- **Provider:** Let's Encrypt
- **Email:** your-email@example.com

### 7. Port Configuration

**Internal Port:** `8081`
**External Port:** `8081` (or use reverse proxy)

### 8. Deploy

1. **Click "Deploy"** in Dokploy
2. **Wait for the build** to complete
3. **Check the logs** for any errors

## Post-Deployment

### 1. Verify Deployment

Visit your domain to ensure the receiver is running:
- `https://your-domain.com` should show the receiver app
- Check that the page loads without errors

### 2. Update Sender App

Update your sender app to use the deployed receiver URL:

```javascript
// In your sender app, update the receiver URL
const receiverUrl = 'https://your-domain.com';
```

### 3. Test Casting

1. **Open your sender app** (local or deployed)
2. **Scan for devices** - your Chromecast should be found
3. **Cast a YouTube video** to test the connection

## Troubleshooting

### Common Issues

1. **"Receiver not found"**
   - Check that the domain is accessible via HTTPS
   - Verify SSL certificate is valid
   - Check Dokploy logs for errors

2. **"Build failed"**
   - Check that all files are in the repository
   - Verify Dockerfile syntax
   - Check build logs in Dokploy

3. **"App not loading"**
   - Check container logs in Dokploy
   - Verify port configuration
   - Check domain DNS settings

### Logs

**View logs in Dokploy:**
1. Go to your project
2. Click on the container
3. View "Logs" tab

**Common log locations:**
- Application logs: Container logs
- Nginx logs: `/var/log/nginx/` (if using reverse proxy)
- SSL logs: Let's Encrypt logs

### Health Checks

The container includes health checks that verify:
- Application is responding on port 8081
- HTTP requests return 200 status
- Container is running properly

## Configuration Files

### docker-compose.yml
- Defines the service configuration
- Sets up networking and ports
- Configures health checks
- Includes Traefik labels for reverse proxy

### Dockerfile
- Uses Node.js 18 Alpine for small size
- Installs only production dependencies
- Exposes port 8081
- Includes health check

### dokploy.yml
- Dokploy-specific configuration
- Defines deployment settings
- Sets up SSL and domains

## Security Considerations

1. **HTTPS Only** - Chromecast requires HTTPS
2. **CORS Headers** - Configure if needed
3. **Rate Limiting** - Consider adding rate limiting
4. **Firewall** - Ensure only necessary ports are open

## Monitoring

### Health Monitoring
- Dokploy provides built-in health monitoring
- Set up alerts for container failures
- Monitor resource usage

### Log Monitoring
- Set up log aggregation if needed
- Monitor error rates
- Track usage patterns

## Scaling

### Horizontal Scaling
- Deploy multiple instances behind a load balancer
- Use Dokploy's scaling features
- Configure sticky sessions if needed

### Vertical Scaling
- Increase container resources in Dokploy
- Monitor performance metrics
- Adjust based on usage

## Backup and Recovery

### Data Backup
- No persistent data to backup
- Configuration is in Git repository
- Environment variables in Dokploy

### Recovery
- Redeploy from Git repository
- Restore environment variables
- Verify SSL certificate renewal

## Support

For issues with Dokploy deployment:
1. Check Dokploy documentation
2. Review container logs
3. Verify network connectivity
4. Check SSL certificate status
