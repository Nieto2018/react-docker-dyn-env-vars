import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h3 style={{ color: 'blue' }}>Se toman de forma estática durante el build</h3>


        <div>process.env.REACT_APP_SHELL: <b style={{ color: 'orange' }}>-{process.env.REACT_APP_SHELL}-</b> ("export REACT_APP_SHELL=shell_value" en la terminal, se tiene en cuenta durante "npm run build")</div>
        <div>process.env.REACT_APP_SCRIPT: <b style={{ color: 'orange' }}>-{process.env.REACT_APP_SCRIPT}-</b> (script en package.json)</div>
        <div>process.env.REACT_APP_ENV_FILE_PROCESS_ENV (.env): <b style={{ color: 'orange' }}>-{process.env.REACT_APP_ENV_FILE_PROCESS_ENV}-</b> (se toma el env file en tiempo de build)</div>
        {/* <div>process.env.REACT_APP_ENV_FILE_IMPORT_META_ENV (.env): <b style={{ color: 'orange' }}>-{import.meta.env.REACT_APP_ENV_FILE_IMPORT_META_ENV}-</b> (se toma el env file en tiempo de build)</div> */}
        <div>VAR1: <b style={{ color: 'orange' }}>-{process.env.VAR1}-</b> (no se ve porque no tiene el prejifo "REACT_APP_", sin js de env vars)</div>

        <h3 style={{ color: 'blue' }}>Se toman de forma dinámica durante el despliegue</h3>

        <div>window._env_.REACT_APP_PUBLIC_REACT_ENV_JS (react.env.js - public): <b style={{ color: 'orange' }}>-{window._env_.REACT_APP_PUBLIC_REACT_ENV_JS}-</b></div>
        <div>window._env_.REACT_APP_PROCESS_ENV_JS (process.env.js - public): <b style={{ color: 'orange' }}>-{window._env_.REACT_APP_PROCESS_ENV_JS}-</b></div>
        <div>window._env_.VAR1 (react.env.js - public): <b style={{ color: 'orange' }}>-{window._env_.VAR1}-</b></div>
        <div>window._env_.REACT_APP_ENV_FILE_1 (react.env.js - env file): <b style={{ color: 'orange' }}>-{window._env_.REACT_APP_ENV_FILE_1}-</b></div>
        <div>window._env_.REACT_APP_ENV_FILE_2 (react.env.js - env file): <b style={{ color: 'orange' }}>-{window._env_.REACT_APP_ENV_FILE_2}-</b></div>
        <div>window._env_.REACT_APP_ENV_FILE_3 (react.env.js - env file): <b style={{ color: 'orange' }}>-{window._env_.REACT_APP_ENV_FILE_3}-</b></div>

        <img src={logo} className="App-logo" alt="logo" />
      </header>
    </div>
  );
}

export default App;
