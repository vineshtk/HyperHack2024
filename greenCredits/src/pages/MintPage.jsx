import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

const MintPage = () => {
  const [amount, setAmount] = useState("");

  const navigate = useNavigate();
  const submitForm = (e) => {
    e.preventDefault();
    const newAmount = {
      amount,
    };
    const res = mintToken(newAmount);
    toast.success("Token Initialized");
    navigate("/government");
    console.log(res);
  };

  const mintToken = async (amount) => {
    const res = await fetch("/api/mint", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(amount),
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
                Mint Token
              </h2>

              <div className="mb-4">
                <label className="block text-gray-700 font-bold mb-2">
                  Token Amount
                </label>
                <input
                  type="text"
                  id="amount"
                  name="amount"
                  className="border rounded w-full py-2 px-3 mb-2"
                  placeholder="eg. 10000"
                  required
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                />
              </div>

              <div>
                <button
                  className="bg-purple-500 hover:bg-purple-600 my-10  text-white font-bold py-2 px-4 rounded-full w-full focus:outline-none focus:shadow-outline"
                  type="submit"
                >
                  Mint
                </button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </>
  );
};

export default MintPage;
