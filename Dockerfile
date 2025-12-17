# ---------- BUILD ----------
FROM node:20-alpine AS build

WORKDIR /app

# Lepsze cache warstw
COPY package*.json ./
# Jeśli używasz pnpm/yarn – zmień odpowiednio
RUN npm ci

COPY . .
RUN npm run build


# ---------- RUNTIME ----------
FROM nginx:1.27-alpine

# Podmień domyślną konfigurację serwera
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Skopiuj zbudowaną apkę (Vite -> dist)
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

# Healthcheck (opcjonalnie)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ > /dev/null || exit 1
