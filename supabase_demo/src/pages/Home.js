import supabase from "../supabase"
import { useEffect,useState } from "react"

const Home = () => {
  const [camin, setCamin] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      let { data: Camin, error } = await supabase
        .from('Camin')
        .select('*');

      if (error) {
        setError(error);
      } else {
        setCamin(Camin);
      }
    };


    fetchData();
  }, []); s

  return (
    <div className="page home">
      <h2>Home</h2>
      {error && <p>Error fetching data: {error.message}</p>}
      <ul>
        {camin.map((item, index) => (
          <li key={index}>{JSON.stringify(item)}</li>
        ))}
      </ul>
    </div>
  );
};

export default Home;