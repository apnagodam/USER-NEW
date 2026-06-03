// Node.js script to get FCM V1 access token
// First install: npm install googleapis

const { GoogleAuth } = require('googleapis');

async function getAccessToken() {
  const auth = new GoogleAuth({
    keyFile: 'path/to/your/service-account-key.json', // Replace with your service account key path
    scopes: ['https://www.googleapis.com/auth/firebase.messaging']
  });

  try {
    const accessToken = await auth.getAccessToken();
    console.log('Access Token:', accessToken);
    return accessToken;
  } catch (error) {
    console.error('Error getting access token:', error);
  }
}

getAccessToken();