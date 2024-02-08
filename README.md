# react-pipeline-gitlab-jimbo

## Introducción

Este ejemplo tiene como objetivo probar lo citado a continuación:

- Uso de variables de entorno.
- Crear y despliegar una aplicación React en un contenedor de Nginx con variables de entorno que son inyectactas en tiempo de ejecución a través de un fichero `.env` para que pueda ser desplegada en distintos entornos.
- Desplegar en Nginx con la capacidad de especificar el puerto de escucha en tiempo de ejecución a través de variable de entorno.

## Variables de entorno

```bash
# Por defecto 5000
PORT=
REACT_APP_ENV_FILE_VAR_1=
REACT_APP_ENV_FILE_VAR_2=
REACT_APP_ENV_FILE_VAR_3=
```

## Desplegar para desarrollo

### Requisitos

Instalar los paquetes:

```bash
npm i
```

### Despliegue

```bash
npm run dev
```

## Docker

### Crear imagen

```bash
docker build \
  --build-arg GITLAB_CI_FILES_URL=${GITLAB_CI_FILES_URL} \
  --build-arg GITLAB_TOKEN=${GITLAB_TOKEN} \
  -t react-pipeline-gitlab-jimbo:latest .
```

### Desplegar contenedor

```bash
docker run --rm \
  --name react-pipeline-gitlab-jimbo \
  -p 80:5000 \
  --env-file $PWD/.env \
  react-pipeline-gitlab-jimbo:latest
```
