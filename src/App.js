import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">

        <div>process.env.REACT_APP_ENV_FILE_VAR_1 (react.env.js - env file): <b style={{ color: 'orange' }}>- {process.env.REACT_APP_ENV_FILE_VAR_1} -</b></div>
        <div>process.env.REACT_APP_ENV_FILE_VAR_2 (react.env.js - env file): <b style={{ color: 'orange' }}>- {process.env.REACT_APP_ENV_FILE_VAR_2} -</b></div>
        <div>process.env.REACT_APP_ENV_FILE_VAR_3 (react.env.js - env file): <b style={{ color: 'orange' }}>- {process.env.REACT_APP_ENV_FILE_VAR_3} -</b></div>

        <img src={logo} className="App-logo" alt="logo" />
      </header>
    </div>
  );
}

export default App;
