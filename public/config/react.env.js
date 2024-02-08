// Variables dentro de process.env no funcionan, ejemplo:
// process.env = {
//   ...window._env_,
//   "REACT_APP_PROCESS_ENV_JS": "value_react_app_process_env_js",
// }

window._env_ = {
  ...window._env_,
  REACT_APP_PUBLIC_REACT_ENV_JS: "value_react_app_public_react_env_js",
}