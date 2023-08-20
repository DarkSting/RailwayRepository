import useFetch from "../../hooks/useFetch";
import "./featured.css";

const Featured = () => {
  const { data, loading, error } = useFetch(
    "/trains/countByCity?cities=matara,Jaffna,Kandy"
  );

  return (
    <div className="featured">
       {loading ? (
        "Loading please wait"
      ) : (
        <>
      <div className="featuredItem">
        <img
          src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-1.jpg"
          alt=""
          className="featuredImg"
        />
        <div className="featuredTitles">
          <h1>Kandy</h1>
          <h2>{data[0]} trains</h2>
        </div>
      </div>
      
      <div className="featuredItem">
        <img
          src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-3.jpg"
          alt=""
          className="featuredImg"
        />
        <div className="featuredTitles">
          <h1>Matara</h1>
          <h2>{data[1]} trains</h2>
        </div>
      </div>
      <div className="featuredItem">
        <img
          src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-2.jpg"
          alt=""
          className="featuredImg"
        />
        <div className="featuredTitles">
          <h1>Jaffna</h1>
          <h2>{data[2]} trains</h2>
        </div>
      </div>
      </>
      )}
    </div>
  );
};

export default Featured;