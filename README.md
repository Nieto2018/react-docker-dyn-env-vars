# react-docker-dyn-env-vars

## Introducción

Este ejemplo tiene como objetivo probar lo citado a continuación:

- Uso de variables de entorno.
- Crear y despliegar una aplicación React en un contenedor de Nginx con variables de entorno que son inyectactas en tiempo de ejecución a través de un fichero `.env` para que pueda ser desplegada en distintos entornos.
- Desplegar en Nginx con la capacidad de especificar el puerto de escucha en tiempo de ejecución a través de variable de entorno.

## Variables de entorno

```bash
# Por defecto 5000 (si no se especifica un puerto hay que dejarlo comentado o provocará un error de Nginx al desplegar el contenedor en Docker)
# PORT=

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
docker build -t react-docker-dyn-env-vars:latest .
```

### Desplegar contenedor

```bash
docker run --rm \
  --name react-docker-dyn-env-vars \
  -p 80:5000 \
  --env-file $PWD/.env \
  react-docker-dyn-env-vars:latest
```
