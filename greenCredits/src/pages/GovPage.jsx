import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

const GovPage = () => {
  const [supply, setSupply] = useState("0");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchSupply = async () => {
      try {
        const res = await fetch("/api/totalsupply");
        const data = await res.json();
        setSupply(data.data);
      } catch (error) {
        console.log(error);
      } finally {
        setLoading(false);
      }
    };
    fetchSupply();
  }, []);

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
        <h2 className="text-2xl font-bold text-center text-green-600 mb-6">
          Government Actions
        </h2>

        <div className="mb-6 p-4 border rounded-lg bg-gray-50">
          <h1 className="text-2xl font-semibold text-center text-gray-800">
            Total Token Supply: <span className="text-green-600">{supply}</span>
          </h1>
        </div>

        <div className="space-y-4">
          <Link
            to="/government/initialize"
            className="w-full block bg-green-600 text-white py-2 px-4 rounded-lg text-center hover:bg-green-700 transition duration-300"
          >
            Initialize
          </Link>
          <Link
            to="/government/mint"
            className="w-full block bg-blue-600 text-white py-2 px-4 rounded-lg text-center hover:bg-blue-700 transition duration-300"
          >
            Mint
          </Link>
          <Link
            to="/government/allocate"
            className="w-full block bg-yellow-600 text-white py-2 px-4 rounded-lg text-center hover:bg-yellow-700 transition duration-300"
          >
            Allocate
          </Link>
        </div>
      </div>
    </div>
  );
};

export default GovPage;
