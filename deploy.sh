#!/bin/bash

# Chromecast Receiver Deployment Script
# This script helps deploy the receiver app to your VPS

set -e

echo "🚀 Chromecast Receiver Deployment Script"
echo "========================================"

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"

# Build the image
echo "🔨 Building Docker image..."
docker-compose -f docker-compose.prod.yml build

# Stop existing containers
echo "🛑 Stopping existing containers..."
docker-compose -f docker-compose.prod.yml down || true

# Start the service
echo "🚀 Starting Chromecast Receiver..."
docker-compose -f docker-compose.prod.yml up -d

# Wait for health check
echo "⏳ Waiting for service to be healthy..."
sleep 10

# Check if service is running
if docker-compose -f docker-compose.prod.yml ps | grep -q "Up"; then
    echo "✅ Chromecast Receiver is running successfully!"
    echo "🌐 Service should be available at: http://localhost:8081"
    echo "📊 Check logs with: docker-compose -f docker-compose.prod.yml logs -f"
else
    echo "❌ Service failed to start. Check logs with:"
    echo "   docker-compose -f docker-compose.prod.yml logs"
    exit 1
fi

echo ""
echo "🎉 Deployment completed successfully!"
echo ""
echo "Next steps:"
echo "1. Configure your domain in docker-compose.prod.yml"
echo "2. Set up SSL certificates"
echo "3. Update your sender app with the new receiver URL"
echo "4. Test casting from your sender app"
