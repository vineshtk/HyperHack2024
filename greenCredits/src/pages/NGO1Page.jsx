import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

const NGO1Page = () => {
  const [supply, setSupply] = useState("0");
  const [loading, setLoading] = useState(true);
  const [value, setValue] = useState("");
  const [recipient, setRecipient] = useState("Corporate1");

  useEffect(() => {
    const fetchSupply = async () => {
      try {
        const res = await fetch("/api/ngo1/allowance");
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


  const submitForm = (e) => {
    e.preventDefault();

    const allocation = {
      recipient,
      value,
    };

    const res = allocateToken(allocation);
    toast.success("Token Initialized");
    navigate("/government");
    console.log(res);
  };

  const allocateToken = async (allocation) => {
    const res = await fetch("/api/transfer", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(allocation),
    });
    return res;
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
        <h2 className="text-2xl font-bold text-center text-green-600 mb-6">
          NGO1 Actions
        </h2>

        <div className="mb-6 p-4 border rounded-lg bg-gray-50">
          <h1 className="text-2xl font-semibold text-center text-gray-800">
            Total Allocation: <span className="text-green-600">{supply}</span>
          </h1>
        </div>

        <div className="space-y-4">
          <section className="bg-white mb-20">
            <div className="container m-auto max-w-2xl py-2">
              <div className="bg-purple-100 px-6 py-8 mb-4 shadow-md rounded-md border m-4 md:m-0">
                <form onSubmit={submitForm}>
                  <h2 className="text-3xl text-purple-800 text-center font-semibold mb-6">
                    Transfer Token
                  </h2>

                  <div className="mb-4">
                    <label
                      htmlFor="type"
                      className="block text-gray-700 font-bold mb-2"
                    >
                      To
                    </label>
                    <select
                      id="spender"
                      name="spender"
                      className="border rounded w-full py-2 px-3"
                      required
                      value={recipient}
                      onChange={(e) => setRecipient(e.target.value)}
                    >
                      <option value="Corporate1">Corporate1</option>
                      <option value="Corporate2">Corporate2</option>
                    </select>
                  </div>

                  <div className="mb-4">
                    <label className="block text-gray-700 font-bold mb-2">
                      Value
                    </label>
                    <input
                      type="text"
                      id="value"
                      name="value"
                      className="border rounded w-full py-2 px-3 mb-2"
                      placeholder="eg. Green Token"
                      required
                      value={value}
                      onChange={(e) => setValue(e.target.value)}
                    />
                  </div>

                  <div>
                    <button
                      className="bg-purple-500 hover:bg-purple-600 my-10  text-white font-bold py-2 px-4 rounded-full w-full focus:outline-none focus:shadow-outline"
                      type="submit"
                    >
                      Transfer
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  );
};

export default NGO1Page;
