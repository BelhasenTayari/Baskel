import "./single.scss";
import Sidebar from "../../components/sidebar/Sidebar";
import Navbar from "../../components/navbar/Navbar";
import Chart from "../../components/chart/Chart";
import List from "../../components/table/Table";
import { veloRows } from '../../datatablesource';
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { agencyRows } from "../../datatablesource";
const Singlev = () => {
  const { id } = useParams();
  console.log(id);
  const idNumber = Number(id);
console.log(idNumber);
  const [user, setUser] = useState({});
  const [ag, setAg] = useState({});

  const fetchData = async (id) => {
    try {
      const reqUrl = `http://localhost:3010/vehicule/${id}`;
      const response = await fetch(reqUrl);
      const data = await response.json();
      setUser(data.data);
    } catch (error) {
      console.error(error);
    }
  };
  console.log(user);
  useEffect(() => {
    fetchData(id);
  }, [id]);
  
  const fetchData2 = async (id) => {
    try {
      const reqUrl = `http://localhost:3010/agence/getAg/${id}`;
      const response = await fetch(reqUrl);
      const data = await response.json();
      setAg(data.data);
    } catch (error) {
      console.error(error);
    }
  };
  console.log(ag);
  useEffect(() => {
    fetchData2(user.id_agence);
  }, [id]);
  
  return (
    <div className="single">
      <Sidebar />
      <div className="singleContainer">
        <Navbar />
        <div className="top">
          <div className="left">
            <div className="editButton">Edit</div>
            <h1 className="title">Information</h1>
            <div className="item">
              <img
                src="https://cdn-icons-png.flaticon.com/512/3198/3198336.png"

                //{user.image}
                alt=""
                className="itemImg"
              />
              <div className="details">
                <h1 className="itemTitle">{user.nom}</h1>
                <div className="detailItem">
                  <span className="itemKey">Type:</span>
                  <span className="itemValue">{user.type}</span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Marque:</span>
                  <span className="itemValue">{user.marque}</span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Vitesse:</span>
                  <span className="itemValue">{user.speed}</span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Rate:</span>
                  <span className="itemValue">{user.rate}</span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Id velo:</span>
                  <span className="itemValue">{user.id}</span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Id agence:</span>
                  <span className="itemValue">{user.id_agence} </span>
                </div>
                <div className="detailItem">
                  <span className="itemKey">Description:</span>
                  <span className="itemValue">{user.description}</span>
                </div>
              </div>
            </div> 
          </div>
         
        </div>
        
      </div>
    </div>
  );
};

export default Singlev;
