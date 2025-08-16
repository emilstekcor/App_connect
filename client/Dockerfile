FROM node:20-alpine
WORKDIR /app
COPY package.json tsconfig.json tsconfig.node.json vite.config.ts ./
RUN npm install
COPY src ./src
COPY public ./public
RUN npm run build
CMD ["npm", "run", "preview", "--", "--port", "5173"]
