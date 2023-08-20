// import "./propertyList.css";

// const PropertyList = () => {
  
//   return (
//     <div className="pList">
//       <div className="pListItem">
//         <img
//           src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/158793_at_York.JPG/330px-158793_at_York.JPG"
//           alt=""
//           className="pListImg"
//         />
//         <div className="pListTitles">
          
//           <h2>233 hotels</h2>
//         </div>
//       </div>
//       <div className="pListItem">
//         <img
//           src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Acela_old_saybrook_ct_summer2011.jpg/330px-Acela_old_saybrook_ct_summer2011.jpg"
//           alt=""
//           className="pListImg"
//         />
//         <div className="pListTitles">
         
//           <h2>31 hotels</h2>
//         </div>
//       </div>
//       <div className="pListItem">
//         <img
//           src ="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/ICE_3_Oberhaider-Wald-Tunnel.jpg/375px-ICE_3_Oberhaider-Wald-Tunnel.jpg"
//           alt=""
//           className="pListImg"
//         />
//         <div className="pListTitles">
          
//           <h2>23 trains</h2>
//         </div>
//       </div>
//       <div className="pListItem">
//         <img
//           src="https://www.railway-technology.com/wp-content/uploads/sites/13/2023/02/Image-1-Amtraks-Airo-Passenger-Train-1.jpeg"
//           alt=""
//           className="pListImg"
//         />
//         <div className="pListTitles">
          
//           <h2>31 trains</h2>
//         </div>
//       </div>
//       <div className="pListItem">
//         <img
//           src="https://ceylontoday.lk/wp-content/uploads/2022/03/23f551ce92298ad37dd8dd829166e62a.jpg"
//           alt=""
//           className="pListImg"
//         />
//         <div className="pListTitles">
          
//           <h2>33 trains</h2>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default PropertyList;


import useFetch from "../../hooks/useFetch";
import "./propertyList.css";

const PropertyList = () => {
  const { data, loading, error } = useFetch("/trains/countByType");

  const images = [
    "https://ceylontoday.lk/wp-content/uploads/2022/03/23f551ce92298ad37dd8dd829166e62a.jpg",
    "https://www.railway-technology.com/wp-content/uploads/sites/13/2023/02/Image-1-Amtraks-Airo-Passenger-Train-1.jpeg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/ICE_3_Oberhaider-Wald-Tunnel.jpg/375px-ICE_3_Oberhaider-Wald-Tunnel.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Acela_old_saybrook_ct_summer2011.jpg/330px-Acela_old_saybrook_ct_summer2011.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/158793_at_York.JPG/330px-158793_at_York.JPG",
  ];
  return (
    <div className="pList">
      {loading ? (
        "loading"
      ) : (
        <>
          {data &&
            images.map((img,i) => (
              <div className="pListItem" key={i}>
                <img
                  src={img}
                  alt=""
                  className="pListImg"
                />
                <div className="pListTitles">
                  <h1>{data[i]?.type}</h1>
                  <h2>{data[i]?.count} {data[i]?.type}</h2>
                </div>
              </div>
            ))}
        </>
      )}
    </div>
  );
};

export default PropertyList;