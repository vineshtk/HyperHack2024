import {
  createBrowserRouter,
  createRoutesFromElements,
  RouterProvider,
  Route,
} from "react-router-dom";
import MainLayout from "./layouts/MainLayout";
import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import GovPage from "./pages/GovPage";
import InitializePage from "./pages/InitializePage";
import MintPage from "./pages/MintPage";
import AllocatePage from "./pages/allocatePage";
import NGO1Page from "./pages/NGO1Page";
function App() {
  const router = createBrowserRouter(
    createRoutesFromElements(
      <>
      <Route index element={<HomePage />} />
        <Route path="/" element={<MainLayout />}>
          <Route path="/login" element={<LoginPage />} />
          <Route path="/government" element={<GovPage />} />
          <Route path="/government/initialize" element={<InitializePage />} />
          <Route path="/government/mint" element={<MintPage />} />
          <Route path="/government/allocate" element={<AllocatePage />} />
          <Route path="/ngo1" element={<NGO1Page />} />
        </Route>
      </>
    )
  );

  return (
    <>
      <RouterProvider router={router} />
    </>
  );
}

export default App;
