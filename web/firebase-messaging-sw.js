importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyA81x54mEJSIhwYD48JtSpt9A3WWUjKXnI',
  appId: '1:159981558323:web:b88512731d3ac25731a146',
  messagingSenderId: '159981558323',
  projectId: 'jaijaoni',
  authDomain: 'jaijaoni.firebaseapp.com',
  storageBucket: 'jaijaoni.appspot.com',
  measurementId: 'G-0C4TKCMBKN',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});