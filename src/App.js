import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h3 style={{ color: 'blue' }}>Se toman de forma estática durante el build</h3>


        <div>process.env.REACT_APP_SHELL: -{process.env.REACT_APP_SHELL}- ("export REACT_APP_SHELL=shell_value" en la terminal, se tiene en cuenta durante "npm run build")</div>
        <div>process.env.REACT_APP_SCRIPT: -{process.env.REACT_APP_SCRIPT}- (script en package.json)</div>
        <div>process.env.REACT_APP_ENV_FILE (.env): -{process.env.REACT_APP_ENV_FILE}- (se toma el env file en tiempo de build)</div>
        <div>VAR1: -{process.env.VAR1}- (no se ve porque no tiene el prejifo "REACT_APP_", sin js de env vars)</div>

        <h3 style={{ color: 'blue' }}>Se toman de forma dinámica durante el despliegue</h3>

        <div>process.env.REACT_APP_PROCESS_ENV_JS (process.env.js): -{process.env.REACT_APP_PROCESS_ENV_JS}- (no vale usar process.env... dentro del js)</div>
        <div>window._env_.REACT_APP_PUBLIC_REACT_ENV_JS (react.env.js - public): -{window._env_.REACT_APP_PUBLIC_REACT_ENV_JS}-</div>
        <div>window._env_.REACT_APP_PUBLIC_REACT_ENV_JS (react.env.js - public): -{window._env_.REACT_APP_PROCESS_ENV_JS}-</div>
        <div>window._env_.VAR1 (react.env.js - public): -{window._env_.VAR1}-</div>
        <div>window._env_.REACT_APP_ENV_FILE_1 (react.env.js - env file): -{window._env_.REACT_APP_ENV_FILE_1}-</div>
        <div>window._env_.REACT_APP_ENV_FILE_2 (react.env.js - env file): -{window._env_.REACT_APP_ENV_FILE_2}-</div>
        <div>window._env_.REACT_APP_ENV_FILE_3 (react.env.js - env file): -{window._env_.REACT_APP_ENV_FILE_3}-</div>

        <img src={logo} className="App-logo" alt="logo" />
      </header>
    </div>
  );
}

export default App;
