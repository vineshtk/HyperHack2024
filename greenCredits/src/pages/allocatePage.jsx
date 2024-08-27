import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

const AllocatePage = () => {
  const [value, setValue] = useState("");
  const [spender, setSpender] = useState("NGO1");

  const navigate = useNavigate();
  const submitForm = (e) => {
    e.preventDefault();

    const allocation = {
      spender,
      value,
    };

    const res = allocateToken(allocation);
    toast.success("Token Initialized");
    navigate("/government");
    console.log(res);
  };

  const allocateToken = async (allocation) => {
    const res = await fetch("/api/approve", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(allocation),
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
                <label
                  htmlFor="type"
                  className="block text-gray-700 font-bold mb-2"
                >
                  Spender
                </label>
                <select
                  id="spender"
                  name="spender"
                  className="border rounded w-full py-2 px-3"
                  required
                  value={spender}
                  onChange={(e) => setSpender(e.target.value)}
                >
                  <option value="NGO1">NGO1</option>
                  <option value="NGO2">NGO2</option>
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
                  Allocate
                </button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </>
  );
};

export default AllocatePage;
