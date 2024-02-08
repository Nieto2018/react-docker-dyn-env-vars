#!/bin/sh

# Este script de shell tiene como propósito generar un archivo JavaScript con las variables de entorno que empiezan con el prefijo REACT_APP_.
# Toma como entrada las variables de entorno del sistema.
# Produce como salida un archivo JavaScript llamado react.env.js (o con el nombre especificado en un parámetro) que contiene 
# las variables de entorno mapeadas como propiedades de un objeto JavaScript.
# Primero, imprime un mensaje indicando que se está ejecutando el script.
# Luego, obtiene la lista de variables de entorno que empiezan con REACT_APP_ y la almacena en la variable REACT_VARS_LIST.
# Comprueba si REACT_VARS_LIST está vacía, en cuyo caso imprime un mensaje diciendo que no se encontraron variables.
# Si hay variables, imprime un mensaje confirmando que se encontraron variables con el prefijo.
# Luego, obtiene el nombre del archivo de salida de un parámetro o usa react.env.js por defecto.
# También obtiene la ruta base de la aplicación React de un parámetro o usa el directorio actual por defecto.
# Con la ruta base, construye la ruta absoluta del directorio donde se guardará el archivo de variables de entorno.
# Crea el directorio si no existe.
# Con la ruta del directorio y el nombre de archivo, construye la ruta absoluta del archivo de salida.
# Crea el archivo, escribe la declaración del objeto JavaScript y va iterando cada variable de entorno, extrayendo la 
# clave y el valor para escribirlos como propiedades del objeto.
# Finalmente imprime un mensaje de confirmación con la ruta del archivo generado y una instrucción de cómo importarlo en la aplicación React.
# De esta manera, el script automatiza la creación de un archivo de configuración con las variables de entorno disponibles para ser 
# usadas fácilmente en una aplicación React.

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
