// import "./featuredProperties.css";

// const FeaturedProperties = () => {
//   return (
//     <div className="fp">
//       <div className="fpItem">
//         <img
//           src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-6.jpg"
//           alt=""
//           className="fpImg"
//         />
//         <span className="fpName">Apart Stare luxury train</span>
//         <span className="fpCity">Kandy</span>
//         <span className="fpPrice">Starting from $12</span>
//         <div className="fpRating">
//           <button>8.9</button>
//           <span>Excellent</span>
//         </div>
//       </div>
//       <div className="fpItem">
//         <img
//           src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-4.jpg"
//           alt=""
//           className="fpImg"
//         />
//         <span className="fpName">Comfort Suites train </span>
//         <span className="fpCity">Jaffna</span>
//         <span className="fpPrice">Starting from $14</span>
//         <div className="fpRating">
//           <button>9.3</button>
//           <span>Exceptional</span>
//         </div>
//       </div>
//       <div className="fpItem">
//         <img
//           src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-5.jpg"
//           alt=""
//           className="fpImg"
//         />
//         <span className="fpName">Four Season Train</span>
//         <span className="fpCity">Down South</span>
//         <span className="fpPrice">Starting from $9</span>
//         <div className="fpRating">
//           <button>8.8</button>
//           <span>Excellent</span>
//         </div>
//       </div>
//       <div className="fpItem">
//         <img
//           src="https://seatreservation.railway.gov.lk/mtktwebslr/gallery/gallery-2.jpg"
//           alt=""
//           className="fpImg"
//         />
//         <span className="fpName">Hilton Garden Train</span>
//         <span className="fpCity">Trincomele</span>
//         <span className="fpPrice">Starting from $10</span>
//         <div className="fpRating">
//           <button>8.9</button>
//           <span>Excellent</span>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default FeaturedProperties;
import useFetch from "../../hooks/useFetch";
import "./featuredProperties.css";

const FeaturedProperties = () => {
  const { data, loading, error } = useFetch("/trains?featured=true&limit=4");

  return (
    <div className="fp">
      {loading ? (
        "Loading"
      ) : (
        <>
          {data.map((item) => (
            <div className="fpItem" key={item._id}>
              <img
                src={item.photos[0]}
                alt=""
                className="fpImg"
              />
              <span className="fpName">{item.name}</span>
              <span className="fpCity">{item.departs}</span>
              <span className="fpPrice">Starting from ${item.cheapestPrice}</span>
              {item.rating && <div className="fpRating">
                <button>{item.rating}</button>
                <span>Excellent</span>
              </div>}
            </div>
          ))}
        </>
      )}
    </div>
  );
};

export default FeaturedProperties;