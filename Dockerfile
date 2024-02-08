# https://jimbo.gloval.es/pipeline_utils/gitlab-ci/-/blob/main/dockerfiles/pipeline/js/bullseye/dockerfile.proyectos-node-react
# Fecha de la última actualización de la plantilla: 28/06/2023

# Dockerfile multipasos (2 pasos)
# Paso(s) 1.X: Empaqueta la(s) aplicación(es) de frontent
# Paso 2: Construye la imagen con Nginx donde correrá la(s) aplicación(es) de frontend

# Paso 1.1 - Empaqueta la aplicación de frontent (<nombre_app>)
FROM node:lts-bullseye as build_client

# Indica el directorio del proyecto
WORKDIR /app/client

# Copia los ficheros con la lista de las dependencias del proyecto (package.json y package-lock.json)
COPY package*.json ./
# Instala los paquetes indicados en el archivo package-lock.json
RUN npm ci

# Copia todos los ficheros del proyecto (menos los indicados en el .gitignore)
COPY . .

# Sustituye las llamadas a las variables de entorno ("process.env.", "import.meta.env.") por la
# por la siguiente "window._env_.", para que se tomen las variables de entorno a partir del archivo
# "env.js" generado en el último paso del Dockerfile
RUN find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec sed -i 's/process.env./window._env_./g; s/import.meta.env./window._env_./g' {} +

# Empaquetamos el proyecto
RUN npm run build-app

# Paso 2: Construye la imagen con Nginx donde correrá la(s) aplicación(es) de frontend
FROM nginx:alpine

# Cambio horario
RUN apk add tzdata
ENV TZ 'Europe/Madrid'

# Copia los archivos empaquetados de los proyectos de frontend generado en el paso(s) 1(.X) del Dockerfile
ENV NGINX_APP_PATH /var/www/app/client/
WORKDIR $NGINX_APP_PATH

COPY --from=build_client /app/client/build $NGINX_APP_PATH

# Generar variables de entorno para la aplicación React
# COPY generar-js-env-vars.sh generar-js-env-vars.sh

RUN curl --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" "${GITLAB_CI_FILES_URL}/scripts%2Freact%2Fsh%2Fgenerar-js-env-vars.sh/raw" > generar-js-env-vars.sh \
  && chmod +x generar-js-env-vars.sh \
  && /bin/sh generar-js-env-vars.sh

# Puerto por defecto para la integración del pipeline de Gitlab con Kubernetes
# (Se tomará para sobreescribir el puerto de nginx en el archivo default.conf.template)
ENV PORT 5000
EXPOSE 5000

# El archivo default.conf.template, que es una plantilla, debe existir en el repositorio del proyecto
# URL plantilla: https://jimbo.gloval.es/pipeline_utils/gitlab-ci/-/wikis/Integrar-proyecto-Javascript-con-CI-CD-en-Gitlab#configurar-nginx-con-variables-de-entorno
ADD ./config/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template

# El comando sobreescribe la variable que hace referencia al puerto en la plantilla y el resultado se
# vuelca en el fichero /etc/nginx/conf.d/default.conf
CMD ["/bin/sh", "-c", "envsubst '${PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && /bin/sh generar-js-env-vars.sh $NGINX_APP_PATH && nginx -g 'daemon off;'"]