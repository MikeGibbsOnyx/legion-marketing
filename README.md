# Onyx Legion Marketing Site

Static marketing site for onyxlegion.ai. The app lives at app.onyxlegion.ai.

## Structure

```
marketing-site/
├── index.html          # Landing page
├── pricing.html        # Pricing page
├── about.html          # About page
├── blog/
│   ├── index.html      # Blog listing
│   └── introducing-onyx-legion.html
├── assets/
│   ├── OnyxMark.png    # Logo (copy from /assets)
│   ├── favicon.ico     # Favicon (copy from /assets)
│   └── og-image.png    # Social share image (create)
├── Dockerfile
├── nginx.conf
└── README.md
```

## Setup

### 1. Copy Assets

From the main project's `/assets` folder, copy to `marketing-site/assets/`:
- `OnyxMark.png`
- `favicon.ico`
- `LegionLogoDarkBG.png` (optional, for hero)

Create:
- `og-image.png` (1200x630 for social sharing)

### 2. Deploy to Cloud Run

```bash
cd marketing-site

# Build and deploy
gcloud run deploy onyx-legion-web \
  --source . \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080
```

### 3. Configure DNS (Cloudflare)

**For onyxlegion.ai (marketing site):**
```
Type: CNAME
Name: @
Target: ghs.googlehosted.com
Proxy: DNS only (gray cloud)
```

**For app.onyxlegion.ai (the app):**
```
Type: CNAME
Name: app
Target: ghs.googlehosted.com
Proxy: DNS only (gray cloud)
```

### 4. Map Custom Domains in Cloud Run

```bash
# Marketing site
gcloud run domain-mappings create \
  --service onyx-legion-web \
  --domain onyxlegion.ai \
  --region us-central1

# App (existing deployment)
gcloud run domain-mappings create \
  --service onyx-legion \
  --domain app.onyxlegion.ai \
  --region us-central1
```

### 5. Update App References

In the main app, update any hardcoded URLs:
- OAuth redirect URIs → app.onyxlegion.ai
- Stripe success/cancel URLs → app.onyxlegion.ai
- CORS allowed origins → add app.onyxlegion.ai

## Local Development

```bash
# Simple Python server
cd marketing-site
python -m http.server 8000

# Or use npx
npx serve .
```

## Content Updates

- **Blog posts:** Add new .html files to `/blog/` and update `/blog/index.html`
- **Pricing changes:** Edit `pricing.html`
- **New pages:** Create .html file, add to nav in all pages

## TODO

- [ ] Copy assets from main project
- [ ] Create og-image.png for social sharing
- [ ] Add app screenshot to landing page
- [ ] Deploy to Cloud Run
- [ ] Configure DNS
- [ ] Update OAuth redirect URIs
- [ ] Update Stripe URLs
- [ ] Test end-to-end
