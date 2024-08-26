import React from "react";
import gcbg from "../assets/GreenCredits.jpeg";
import { Link } from "react-router-dom";

const Hero = () => {
  return (
    <div
      className="flex items-center justify-center h-screen bg-center"
      style={{
        backgroundImage: `url(${gcbg})`,
        backgroundSize: '100%', 
        backgroundRepeat: 'no-repeat',
      }}
    >
      <div className="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg text-center">
        <h1 className="text-3xl font-bold text-green-600">
          Welcome to GreenCredits
        </h1>
        <p className="mt-4 text-gray-700">
          Trading carbon credits securely and transparently with blockchain technology.
        </p>
        <div className="mt-6">
          <Link to={"/login"} className="bg-green-600 text-white font-semibold py-2 px-4 rounded hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500">
            Login
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Hero;
