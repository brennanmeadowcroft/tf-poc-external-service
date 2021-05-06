#! /bin/bash

echo "Attempting to build and deploy artifact to S3"
if [[ -n $VERSION ]]; then
  echo "Version $VERSION"

  mkdir -p build
  rm ./build/$APP_NAME.zip
  zip -r ./build/$APP_NAME.zip ./src/main.js ./node_modules
else
  echo "First parameter not supplied."
fi

