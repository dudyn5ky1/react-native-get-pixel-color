import { NativeModules, Platform } from 'react-native';

const rgb2hex = rgb => {
  return (rgb && rgb.length === 4) ? "#" +
    ("0" + parseInt(rgb[0], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) : "";
};

export const getHex = (path, options) => new Promise((resolve, reject) => {
  if (Platform.Os === 'ios') {
    NativeModules.GetPixelColor.getHex(path, options, (err, color) => {
      if (err) {
        return reject(err);
      }
      resolve(color);
    });
  } else {
    const { x, y } = options;
    NativeModules.GetPixelColor.getRGB(path, x, y, (err, color) => {
      if (err) {
        return reject(err);
      }
      resolve(rgb2hex(color));
    });
  }
});

export default {
  getHex,
};
