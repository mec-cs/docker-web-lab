FROM node:16-alpine as builder

WORKDIR "/app"

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# output of what we'll deal inside /app/build

FROM nginx
# mostly in dev env, comm betw devs -- to emphasize port map 80
# aws elastic beanstalk look expose inst, and map directly to that port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
