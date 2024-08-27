import { Link } from "react-router-dom";

const Navbar = () => {
  return (
    <>
      <div className="bg-opacity- text-green-950 grid grid-cols-1 md:grid-cols-2 p-3 shadow-md">
        <div className="flex items-center">
        <div className="flex justify-center md:justify-end items-center mt-2 md:mt-0 space-x-5 md:space-x-10">
          <Link to="/" className="ml-20">
            Home
          </Link>
        </div>
        </div>
      </div>
    </>
  );
};

export default Navbar;
