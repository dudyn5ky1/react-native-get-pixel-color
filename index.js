import {NativeModules, Platform} from 'react-native';

const rgb2hex = rgb => {
  return (rgb && rgb.length === 3) ? '#' +
      ('0' + parseInt(rgb[0], 10).toString(16)).slice(-2) +
      ('0' + parseInt(rgb[1], 10).toString(16)).slice(-2) +
      ('0' + parseInt(rgb[2], 10).toString(16)).slice(-2) : '';
};

const pixelColor = Platform.OS === 'ios' ? NativeModules.RNPixelColor : NativeModules.GetPixelColor;

export const setImage = (path) => new Promise((resolve, reject) => {
  pixelColor.init(path, (err, isSet) => {
    if (err) {
      return reject(err);
    }
    if (isSet) {
      resolve('Image sucessfully set');
    }
  });
});

export const pickColorAt = (x, y) => new Promise((resolve, reject) => {
  pixelColor.getRGB(x, y, (err, color) => {
    if (err) {
      return reject(err);
    }
    resolve(rgb2hex(color).toUpperCase());
  });
});

export default {
  setImage,
  pickColorAt,
};
