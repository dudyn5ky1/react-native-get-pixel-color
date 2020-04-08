package com.reactlibrary;

import android.net.Uri;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.util.Base64;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableNativeArray;

import java.io.File;

public class GetPixelColorModule extends ReactContextBaseJavaModule {
    private final ReactApplicationContext reactContext;

    public GetPixelColorModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "GetPixelColor";
    }

    @ReactMethod
    public void getRGB(String encodedImage, int x, int y, Callback callback) {
      try {
        final byte[] decodedString = Base64.decode(encodedImage, Base64.DEFAULT);
        final Bitmap bitmap = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        final int pixel = bitmap.getPixel(x, y);

        final int red = Color.red(pixel);
        final int green = Color.green(pixel);
        final int blue = Color.blue(pixel);

        final WritableArray result = new WritableNativeArray();
        result.pushInt(red);
        result.pushInt(green);
        result.pushInt(blue);

        callback.invoke(null, result);
      } catch (Exception e) {
        callback.invoke(e.getMessage());
      }
    }
}
