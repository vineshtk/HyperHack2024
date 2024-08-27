import React from 'react';
import { Link } from 'react-router-dom';

const LoginPage = () => {
  return (
    <div className="flex items-center justify-center min-h-screen bg-green-100">
      <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
        <h2 className="text-3xl font-bold text-center text-green-700 mb-6">
          Login to GreenCredits
        </h2>
        
        <div className="space-y-4">
          <Link 
            to="/government"
            className="w-full block bg-green-600 text-white py-2 px-4 rounded-lg text-center hover:bg-green-700 transition duration-300"
          >
            Login as Government Agency
          </Link>
          <Link 
            to="/ngo1"
            className="w-full block bg-green-500 text-white py-2 px-4 rounded-lg text-center hover:bg-green-600 transition duration-300"
          >
            Login as NGO_1
          </Link>
          <Link 
           to="/ngo2"
            className="w-full block bg-green-400 text-white py-2 px-4 rounded-lg text-center hover:bg-green-500 transition duration-300"
          >
            Login as NGO_2
          </Link>
          <Link 
            to="/corporate_1"
            className="w-full block bg-green-500 text-white py-2 px-4 rounded-lg text-center hover:bg-green-600 transition duration-300"
          >
            Login as Corporate_1
          </Link>
          <Link 
            to="/corporate_2"
            className="w-full block bg-green-600 text-white py-2 px-4 rounded-lg text-center hover:bg-green-700 transition duration-300"
          >
            Login as Corporate_2
          </Link>
      
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
