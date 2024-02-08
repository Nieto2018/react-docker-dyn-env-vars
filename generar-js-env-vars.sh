#!/bin/sh

echo "\033[34mLanzando script env.sh. El script creará un archivo js de variables de entorno para React\033[0m"


echo "Comprobando si existen variables con prefixo \033[34mREACT_APP_\033[0m"
REACT_VARS_LIST=$(env | grep REACT_APP_)

# Comprueba que la variable REACT_VARS_LIST no está vacía
if [ -z "$REACT_VARS_LIST" ]; then
  echo "\033[33mNo se han encontrado variables con prefixo REACT_APP_\033[0m"
else
  echo "Se han encontrado variables con prefixo REACT_APP_"

  # Comprueba si se ha especificado un nombre para el archivo de variables de entorno
  ENV_VARS_JS_FILENAME=$2
  if [ -z "$ENV_VARS_JS_FILENAME" ]; then
    ENV_VARS_JS_FILENAME="react.env.js"
  fi

  # Comprueba si se ha especificado una ruta para el archivo de variables de entorno a travéz de un parámetro
  # El valor del parámetro debe ser la ruta del proyecto dentro de Nginx
  NGINX_APP_PATH=$1
  if [ -z "$NGINX_APP_PATH" ]; then
    NGINX_APP_PATH=$(pwd)
  fi

  # Ruta relativa del archivo de variables de entorno dentro del directorio de la aplicación en Nginx
  ENV_VARS_JS_RELATIVE_DIR="/config"
  # Obtenemos la ruta absoluta del directorio del archivo de variables de entorno
  ENV_VARS_JS_ABS_DIR="$NGINX_APP_PATH$ENV_VARS_JS_RELATIVE_DIR"

  # Comprueba si el directorio existe
  if [ ! -d "$ENV_VARS_JS_ABS_DIR" ]; then
  # Crear directorio para el archivo de variables de entorno
    mkdir -p $ENV_VARS_JS_ABS_DIR
  fi

  # Ruta relativa con el nombre del archivo de variables de entorno dentro del directorio de la aplicación en Nginx
  ENV_VARS_JS_ABS_PATH="$ENV_VARS_JS_ABS_DIR/$ENV_VARS_JS_FILENAME"

  # Crea y registra las variables en el archivo de variables de entorno
  echo "window._env_ = {" > $ENV_VARS_JS_ABS_PATH
  echo "  ...window._env_," >> $ENV_VARS_JS_ABS_PATH
  for i in $REACT_VARS_LIST
  do
      key=$(echo $i | cut -d '=' -f 1)
      value=$(echo $i | cut -d '=' -f 2-)
      echo "  \"$key\":\"$value\"," >> $ENV_VARS_JS_ABS_PATH
  done

  echo "}" >> $ENV_VARS_JS_ABS_PATH

  # Imprime un mensaje de confirmación de color verde
  echo "\033[32mArchivo $ENV_VARS_JS_ABS_PATH creado\033[0m"

  ENV_VARS_JS_RELATIVE_PATH="$ENV_VARS_JS_RELATIVE_DIR/$ENV_VARS_JS_FILENAME"
  echo "El archivo \033[34m$ENV_VARS_JS_ABS_PATH\033[0m debe estar importado dentro del archivo \033[34mhtml\033[0m de la aplicación React, dentro de la sección \033[34m\"<html><head>...<head\/><html\/>\"\033[0m se la siguiente forma \033[34m\"<script src=\"$ENV_VARS_JS_RELATIVE_PATH\"></script>\"\033[0m."
fi

# Descomentar si quiere que se borre el archivo del script, liberaría espacio en la imagen de docker
# rm generar-js-env-vars.sh
