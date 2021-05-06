'use strict';
const request = require('axios');

exports.handler = function (event, context, callback) {
  const url = process.env.INTERNAL_APP_BASEURL;
  request
    .get(url)
    .then(result => {
      console.log('Result', result);
      var response = {
        statusCode: 200,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          source: 'internal-app',
          data: result.data,
        }),
      };

      callback(null, response);
    })
    .catch(err => {
      console.log('Error', err);
      callback(JSON.stringify({ error: err.message }));
    });
};
