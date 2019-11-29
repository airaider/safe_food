import axios from "axios";

export default axios.create({
  //baseURL: "http://70.12.108.96:8080",
  baseURL: "http://localhost:8080",
  //withCredentials: true,
  headers: {
    "Content-type": "application/json"
  }
}); 
