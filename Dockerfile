FROM node:20 AS base

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

FROM base AS build

WORKDIR /usr/src/app

COPY . .
COPY --from=base /usr/src/app/node_modules ./node_modules

RUN npm run build
RUN npm prune --prod

FROM node:20-alpine3.19 AS deploy

WORKDIR /usr/src/app

RUN npm i -g prisma

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/prisma ./prisma

ENV DATABASE_URL="file:./dev.db"
ENV API_BASE_URL="http://localhost:3333"

RUN npx prisma generate

EXPOSE 3333

CMD ["npm", "run", "start"]