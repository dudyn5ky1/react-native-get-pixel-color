# react-native-get-pixel-color

[![npm version](https://img.shields.io/npm/v/react-native-get-pixel-color.svg)](https://www.npmjs.com/package/react-native-get-pixel-color)
[![npm](https://img.shields.io/npm/dt/react-native-get-pixel-color.svg)](https://www.npmjs.com/package/react-native-get-pixel-color)

## Description
Get HEX color value from image in React Native. Works both for iOS and Android.

## Getting started

`$ npm install react-native-get-pixel-color --save`

or

`$ yarn add react-native-get-pixel-color`

## Important note
For iOS you should pass the path to the file, however for Android you should pass base64 string of the image. In the near future both implementations would be unified to both use only one of these options.

## Usage (iOS)
```javascript
import GetPixelColor from 'react-native-get-pixel-color';

GetPixelColor.getHex(pathToFile, {
  x: x,
  y: y,
})
  .then(hex => {
    // HEX color value returned
  })
  .catch(err => {
    // Handle errors
  });
```

## Usage (Android)
```javascript
import GetPixelColor from 'react-native-get-pixel-color';

GetPixelColor.getHex(base64, {
  x: x,
  y: y,
})
  .then(hex => {
    // HEX color value returned
  })
  .catch(err => {
    // Handle errors
  });
```

## Disclaimer

At this moment iOS implementation of this module is forked from https://github.com/crispipear/react-native-pixel-color.
