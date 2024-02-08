# react-pipeline-gitlab-jimbo

```bash
docker run --rm \
  --name nginx-react \
  -v $PWD/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  -v $PWD/build/:/var/www/app/client/ \
  -p 80:80 \
  nginx:alpine
```

# Con front.env.js montado

```bash
docker run --rm \
  --name nginx-react \
  -v $PWD/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  -v $PWD/build/:/var/www/app/client/ \
  -v $PWD/front.env.js:/var/www/app/client/config/front.env.js \
  -p 80:80 \
  nginx:alpine
```

# Con env file

```bash
docker run --rm \
  --name nginx-react \
  -v $PWD/nginx/default.conf:/etc/nginx/conf.d/default.conf \
  -v $PWD/build/:/var/www/app/client/ \
  -env-file $PWD/.env \
  -p 80:80 \
  nginx:alpine
```

```bash
docker run --rm \
  --name envs \
  -p 80:5000 \
  --env-file $PWD/.env \
  envs-react
```

```bash
docker run --rm -it \
  --env-file $PWD/.env \
  -v $PWD/:/app/client/ \
  -w /app/client \
  node:lts-bullseye bash
```

```bash
docker run --rm -it \
  --env-file $PWD/.env \
  -v $PWD/env.sh:/app/client/env.sh \
  -w /app/client \
  node:lts-bullseye bash
```
