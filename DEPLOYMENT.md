# Chromecast Receiver Deployment Guide

This guide explains how to deploy the Chromecast receiver app to make it available for casting.

## Prerequisites

- A web server with HTTPS support (required for Chromecast)
- A domain name
- SSL certificate

## Deployment Options

### Option 1: GitHub Pages (Free)

1. **Create a GitHub repository** for your receiver app
2. **Upload the files** to the repository
3. **Enable GitHub Pages** in repository settings
4. **Set source** to "Deploy from a branch" and select "main"
5. **Your receiver will be available at**: `https://yourusername.github.io/repository-name/`

### Option 2: Netlify (Free)

1. **Create a Netlify account** at netlify.com
2. **Drag and drop** the receiver folder to Netlify
3. **Your receiver will be available at**: `https://random-name.netlify.app/`
4. **Custom domain** can be added in site settings

### Option 3: Vercel (Free)

1. **Create a Vercel account** at vercel.com
2. **Import your repository** or upload files
3. **Deploy** the receiver app
4. **Your receiver will be available at**: `https://your-app.vercel.app/`

### Option 4: Firebase Hosting (Free)

1. **Install Firebase CLI**: `npm install -g firebase-tools`
2. **Initialize Firebase**: `firebase init hosting`
3. **Set public directory** to current directory
4. **Deploy**: `firebase deploy`
5. **Your receiver will be available at**: `https://your-project.web.app/`

## Important Notes

### HTTPS Requirement
- **Chromecast requires HTTPS** for receiver apps
- **Local development** (localhost) works without HTTPS
- **Production deployment** must use HTTPS

### CORS Configuration
- **No special CORS setup** needed for basic functionality
- **Iframe embedding** may be restricted by some websites

### App Registration
- **For production use**, you may need to register your receiver app with Google
- **Default media receiver** works for most use cases
- **Custom receiver** requires Google Cast SDK registration

## Testing Your Deployment

1. **Deploy your receiver** using one of the methods above
2. **Note the HTTPS URL** of your deployed receiver
3. **Update the sender app** to use your receiver URL
4. **Test casting** from the sender app

## File Structure

```
receiver/
├── index.html          # Main receiver app
├── manifest.json       # App manifest
├── package.json        # Dependencies
└── DEPLOYMENT.md       # This guide
```

## Troubleshooting

### Common Issues

1. **"Receiver not found"**
   - Check that the receiver URL is accessible via HTTPS
   - Verify the URL is correct in the sender app

2. **"CORS error"**
   - Ensure the receiver is served over HTTPS
   - Check browser console for specific error messages

3. **"App not loading"**
   - Verify all files are uploaded correctly
   - Check that the web server is running

### Support

For issues with deployment, check:
- Browser developer console for errors
- Network tab for failed requests
- Chromecast device logs (if available)
