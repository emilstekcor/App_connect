import { Routes, Route, Link } from 'react-router-dom';
import Login from './pages/Login';
import Home from './pages/Home';
import Room from './pages/Room';

export default function App() {
  return (
    <div>
      <nav>
        <Link to="/">Home</Link> | <Link to="/login">Login</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/rooms/:id" element={<Room />} />
      </Routes>
    </div>
  );
}
