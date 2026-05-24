# Stage 1: build the Astro site
FROM node:22-alpine AS builder
WORKDIR /app

# Install deps with cache-friendly layer
COPY package*.json ./
RUN npm ci --no-audit --progress=false

# Copy the rest and build
COPY . .
RUN npm run build

# Stage 2: serve the static output with nginx
FROM nginx:alpine

# Replace default nginx site config with one tuned for static SPA fallback
RUN rm -f /usr/share/nginx/html/index.html /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
