# Build stage
FROM node:18 AS build
WORKDIR /usr/share/app
COPY package*.json ./
COPY tsconfig*.json ./
COPY src ./src
RUN npm install
RUN npm run build

# Package stage
FROM node:18 AS package
WORKDIR /usr/share/app
COPY --from=build /usr/share/app/dist ./dist
COPY --from=build /usr/share/app/node_modules ./node_modules
RUN ls -l
EXPOSE 3000
ENTRYPOINT ["node","dist/main.js"]

