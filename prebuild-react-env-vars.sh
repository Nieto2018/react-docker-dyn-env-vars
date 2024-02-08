#!/bin/bash

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