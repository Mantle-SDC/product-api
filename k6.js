const http = require('k6/http');
const { sleep } = require('k6');

export const options = {
  vus: 800,
  duration: '10s',
};

export default function () {
  http.get('http://localhost:3000/products/102/styles');
  sleep(1);
}
