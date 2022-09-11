import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyCcofduT7NZUL82u2-gsgnwe23xsQsUBPU",
  authDomain: "justpark-21caa.firebaseapp.com",
  projectId: "justpark-21caa",
  storageBucket: "justpark-21caa.appspot.com",
  messagingSenderId: "573592814467",
  appId: "1:573592814467:web:5ba85e2f685d1bd73f6cb6",
  measurementId: "G-Z735LDP6FE"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);