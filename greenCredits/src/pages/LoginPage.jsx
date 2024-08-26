import React from 'react';

const LoginPage = () => {
  const handleLogin = (organization) => {
    console.log(`Logging in as ${organization}`);
    // Implement login logic here based on the organization
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-green-100">
      <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
        <h2 className="text-3xl font-bold text-center text-green-700 mb-6">
          Login to GreenCredits
        </h2>
        
        <div className="space-y-4">
          <button 
            onClick={() => handleLogin('Government Agency')}
            className="w-full bg-green-600 text-white py-2 px-4 rounded-lg hover:bg-green-700 transition duration-300"
          >
            Login as Government Agency
          </button>
          <button 
            onClick={() => handleLogin('Carbon Credit Issuer')}
            className="w-full bg-green-500 text-white py-2 px-4 rounded-lg hover:bg-green-600 transition duration-300"
          >
            Login as Carbon Credit Issuer
          </button>
          <button 
            onClick={() => handleLogin('Verifier')}
            className="w-full bg-green-400 text-white py-2 px-4 rounded-lg hover:bg-green-500 transition duration-300"
          >
            Login as Verifier
          </button>
          <button 
            onClick={() => handleLogin('Corporate Buyer')}
            className="w-full bg-green-500 text-white py-2 px-4 rounded-lg hover:bg-green-600 transition duration-300"
          >
            Login as Corporate Buyer
          </button>
          <button 
            onClick={() => handleLogin('Blockchain Operator')}
            className="w-full bg-green-600 text-white py-2 px-4 rounded-lg hover:bg-green-700 transition duration-300"
          >
            Login as Blockchain Operator
          </button>
          <button 
            onClick={() => handleLogin('Financial Institution')}
            className="w-full bg-green-700 text-white py-2 px-4 rounded-lg hover:bg-green-800 transition duration-300"
          >
            Login as Financial Institution
          </button>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
