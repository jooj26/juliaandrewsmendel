# CMS Setup Plan for Julia Andrews Mendel Portfolio

This document outlines the plan to add a content management system so Julia can update her website independently.

## Recommended Solution: Decap CMS

Decap CMS (formerly Netlify CMS) is a free, open-source Git-based CMS that adds a user-friendly admin interface to static sites.

### Why Decap CMS?

- No database required (works with existing static files)
- User-friendly visual editor
- Free and open-source
- Works with self-hosted sites on Digital Ocean
- Git-based version control (can roll back changes)
- Secure authentication via GitHub/GitLab OAuth

## Implementation Steps

### Step 1: Set Up Git Repository

1. Initialize git repo locally (done)
2. Create a GitHub or GitLab repository
3. Push the site code to the remote repository

### Step 2: Create Admin Interface

Create the following files:

```
admin/
├── index.html    # Admin page entry point
└── config.yml    # CMS configuration
```

**admin/index.html:**
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Content Manager</title>
  <script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
</head>
<body>
  <script src="https://unpkg.com/decap-cms@^3.0.0/dist/decap-cms.js"></script>
</body>
</html>
```

**admin/config.yml:**
```yaml
backend:
  name: github
  repo: your-username/juliaandrewsmendel
  branch: main

media_folder: "images"
public_folder: "/images"

collections:
  - name: "pages"
    label: "Pages"
    files:
      - label: "CV"
        name: "cv"
        file: "cv.html"
        fields:
          - { label: "Body", name: "body", widget: "code", default_language: "html" }

      - label: "Contact"
        name: "contact"
        file: "contact.html"
        fields:
          - { label: "Body", name: "body", widget: "code", default_language: "html" }
```

### Step 3: Set Up Authentication

**Option A: GitHub OAuth (Recommended for self-hosting)**

1. Create a GitHub OAuth App:
   - Go to GitHub > Settings > Developer settings > OAuth Apps
   - Set callback URL to your site

2. Set up an OAuth proxy (required for self-hosting):
   - Deploy a small OAuth handler (e.g., using Netlify's external OAuth client)
   - Or use a service like `https://github.com/vencax/netlify-cms-github-oauth-provider`

**Option B: Netlify Identity (Simpler but requires Netlify)**

1. Deploy site to Netlify (can proxy to Digital Ocean)
2. Enable Netlify Identity in dashboard
3. Invite Julia via email

### Step 4: Deploy and Configure

1. Add the admin files to the repository
2. Configure OAuth credentials
3. Deploy to Digital Ocean
4. Test login at `yoursite.com/admin`

## Security Notes

- `/admin` page shows a login screen to unauthenticated users
- Only authorized GitHub/GitLab users can access the CMS
- All changes are tracked in git history
- Can easily roll back unwanted changes

## Alternative: Simpler Image-Only Updates

If Julia primarily needs to update images, a simpler approach:

1. Set up SFTP access to the droplet
2. Use a visual SFTP client (Cyberduck, FileZilla)
3. She drags new images into the `images/` folder
4. Run resize script via SSH or set up auto-processing

## Next Steps

1. [x] Create GitHub repository
2. [x] Push existing code
3. [x] Create admin/ folder with config
4. [ ] Set up GitHub OAuth App (or use Netlify Identity)
5. [ ] Deploy to Netlify or set up OAuth proxy for self-hosting
6. [ ] Test the admin interface
7. [ ] Train Julia on using the CMS

## Resources

- [Decap CMS Documentation](https://decapcms.org/docs/)
- [GitHub OAuth Setup](https://docs.github.com/en/developers/apps/building-oauth-apps)
- [Self-hosting Guide](https://decapcms.org/docs/external-oauth-clients/)
