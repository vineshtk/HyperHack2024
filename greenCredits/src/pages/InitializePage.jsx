import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

const InitializePage = () => {
  const [name, setName] = useState("");
  const [symbol, setSymbol] = useState("");
  const [decimal, setDecimal] = useState("1");

  const navigate = useNavigate();
  const submitForm = (e) => {
    e.preventDefault();

    const newToken = {
      name,
      symbol,
      decimal,
    };

    const res = initializeToken(newToken);
    toast.success("Token Initialized");
    navigate("/government");
    console.log(res);
  };

  const initializeToken = async (token) => {
    const res = await fetch("/api/init", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(token),
    });
    return res;
  };

  return (
    <>
      <section className="bg-white mb-20">
        <div className="container m-auto max-w-2xl py-2">
          <div className="bg-purple-100 px-6 py-8 mb-4 shadow-md rounded-md border m-4 md:m-0">
            <form onSubmit={submitForm}>
              <h2 className="text-3xl text-purple-800 text-center font-semibold mb-6">
                Initialize Token Contract
              </h2>

              <div className="mb-4">
                <label className="block text-gray-700 font-bold mb-2">
                  Token Name
                </label>
                <input
                  type="text"
                  id="name"
                  name="name"
                  className="border rounded w-full py-2 px-3 mb-2"
                  placeholder="eg. Green Token"
                  required
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                />
              </div>

              <div className="mb-4">
                <label className="block text-gray-700 font-bold mb-2">
                  Token Symbol
                </label>
                <input
                  type="text"
                  id="symbol"
                  name="symbol"
                  className="border rounded w-full py-2 px-3 mb-2"
                  placeholder="eg. GT"
                  required
                  value={symbol}
                  onChange={(e) => setSymbol(e.target.value)}
                />
              </div>

              <div className="mb-4">
                <label
                  htmlFor="type"
                  className="block text-gray-700 font-bold mb-2"
                >
                  Decimals
                </label>
                <select
                  id="decimal"
                  name="decimal"
                  className="border rounded w-full py-2 px-3"
                  required
                  value={decimal}
                  onChange={(e) => setDecimal(e.target.value)}
                >
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                </select>
              </div>

              <div>
                <button
                  className="bg-purple-500 hover:bg-purple-600 my-10  text-white font-bold py-2 px-4 rounded-full w-full focus:outline-none focus:shadow-outline"
                  type="submit"
                >
                  Initialize
                </button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </>
  );
};

export default InitializePage;
