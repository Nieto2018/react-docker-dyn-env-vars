#!/bin/bash

# Este código busca configurar las variables de entorno para una aplicación React antes de construir la imagen de Docker.

# Primero, busca en los archivos JavaScript y JSX en el directorio src/ referencias a variables de entorno como process.env, 
# window._env_ o import.meta.env. Si encuentra alguna, significa que la aplicación está utilizando variables de entorno.

# Luego, si se encontraron referencias a variables de entorno, hace dos cosas:
# 1) Reemplaza todas las referencias a process.env e import.meta.env por window._env_. Esto hace que en lugar de leer las 
#    variables de entorno del sistema, las lea desde el archivo react.env.js que será generado después.
# 2) Busca los archivos index.html e index.htm, y antes de cerrar la etiqueta </head> agrega una línea para importar el archivo react.env.js 
#    generado previamente. Esto hace disponibles las variables de entorno para el código JavaScript a través de window._env_.

# De esta forma, configura la aplicación React para que en lugar de utilizar las variables de entorno del sistema (que no puede directamente), 
# las tome desde el archivo react.env.js que será generado con los valores deseados para cada entorno (desarrollo, producción, etc).

# Esto permite montar un contenedor de Docker con las variables de entorno configuradas, 
# para que la aplicación se ejecute correctamente en cada entorno.

# Buscar en archivos js/jsx en src/
found=false
for file in $(find src/ -name '*.js' -o -name '*.jsx'); do
  if grep -q -E 'window._env_|process.env.|import.meta.env.' "$file"; then
    found=true
    break
  fi  
done

if [ "$found" = true ]; then

  # Sustituye las llamadas a las variables de entorno ("process.env.", "import.meta.env.") por la
  # por la siguiente "window._env_.", para que se tomen las variables de entorno a partir del archivo
  # "env.js" generado en el último paso del Dockerfile
  find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec sed -i 's/process.env./window._env_./g; s/import.meta.env./window._env_./g' {} +

  # Buscar index.html/htm y añadir script
  for html in $(find . -name 'index.html' -o -name 'index.htm' | grep -v node_modules); do
    if ! grep -q '<script src="/config/react.env.js"></script>' "$html"; then
      sed -i -e 's|</head>|<script src="/config/react.env.js"></script>\n</head>|' "$html"
    fi
  done
  
fi