package com.tianji.mynativelib;

import android.util.Log;

public class NativeLib {

    // Used to load the 'mynativelib' library on application startup.
    static {
        System.loadLibrary("frida-gadget");
//        System.loadLibrary("mynativelib");
        System.loadLibrary("cocos2dluar");
    }

    /**
     * A native method that is implemented by the 'mynativelib' native library,
     * which is packaged with this application.
     */
    public static void stringFromJNI() {
        Log.d("idk", "noop");
    }
}