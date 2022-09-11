import { collection, addDoc } from "firebase/firestore";
import { db } from "./firebase.js";
try {
    const docRef = await addDoc(collection(db, "Parking"), {
        image: "https://cdn.pixabay.com/photo/2020/09/06/07/37/car-5548242_1280.jpg",
        name: "Thane AnandaPark"
    });
    console.log("Document written with ID: ", docRef.id);
} catch (e) {
    console.error("Error adding document: ", e);
}