FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

FROM node:20-alpine AS runtime

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
COPY db.js ./
COPY server.js ./
COPY routes.js ./

EXPOSE 3000

USER node

CMD ["node", "server.js"]