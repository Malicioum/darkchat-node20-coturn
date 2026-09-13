# DarkChat Node.js 20 + Coturn

Custom Pterodactyl image based on:

    ghcr.io/parkervcp/yolks:nodejs_20

It adds Coturn while keeping the Node.js 20 environment.

## 1. Create the GitHub repository

Create a repository named:

    darkchat-node20-coturn

Upload the contents of this archive to the repository, preserving:

    Dockerfile
    turnserver.conf.example
    pterodactyl-startup.txt
    .github/workflows/docker.yml

Push to the `main` branch.

## 2. GitHub Actions

Go to:

    GitHub repository -> Actions

The "Build Docker Image" workflow should run automatically.

When it succeeds, the image will be:

    ghcr.io/YOUR_GITHUB_USERNAME/darkchat-node20-coturn:latest

IMPORTANT:
GitHub packages can be private by default. If Pterodactyl cannot pull the image,
open the package on GitHub and set its visibility to Public, or configure Docker
registry authentication on your Wings host.

## 3. Pterodactyl image

Replace:

    ghcr.io/parkervcp/yolks:nodejs_20

with:

    ghcr.io/YOUR_GITHUB_USERNAME/darkchat-node20-coturn:latest

## 4. Coturn configuration

Copy:

    turnserver.conf.example

to the root of the Pterodactyl server and rename it:

    turnserver.conf

Replace:

    CHANGE_ME_WITH_A_LONG_RANDOM_SECRET

with a strong random secret.

Example generation on Linux:

    openssl rand -hex 32

If the Pterodactyl container is behind NAT, also configure:

    external-ip=YOUR_PUBLIC_IP

The relay port range in this example is:

    50000-50100 UDP

Adapt `min-port` and `max-port` to your allocated ports.

## 5. Startup command

Use the content of:

    pterodactyl-startup.txt

It starts Coturn in the background, then runs your existing Node.js startup logic.

## 6. Quick verification

In the Pterodactyl console, after boot:

    turnserver --version

and:

    ps aux | grep turnserver

You should see Coturn running alongside Node.js.

## Notes

- Coturn is not installed through npm.
- Node.js will later handle signaling / WebSocket / temporary TURN credentials.
- WebRTC in the browser handles audio, video and screen sharing.
- Coturn relays WebRTC traffic when direct peer-to-peer connectivity fails.
