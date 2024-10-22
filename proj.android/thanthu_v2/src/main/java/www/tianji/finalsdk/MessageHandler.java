package www.tianji.finalsdk;

import android.os.Handler;
import android.os.Message;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;
import org.cocos2dx.lib.Cocos2dxHelper;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.cocos2dx.lua.AppActivity;

/* loaded from: classes.dex */
public class MessageHandler extends Handler {
    private static Integer messageIDCounter = 1;
    private static MessageHandler singleton = null;
    private AppActivity activity;
    private ConcurrentHashMap<Integer, CallInfo> callMap = new ConcurrentHashMap<>();

    public MessageHandler(AppActivity appActivity) {
        this.activity = appActivity;
        singleton = this;
        messageIDCounter = 1;
    }

    public static void msgFromLua(String str, String str2, int i) {
        System.out.println("msgFromLua: " + str + ", " + str2);
        singleton.receiveMsg(str, str2, i);
    }

    public void callbackToLua(final int i, final String str) {
        final CallInfo callInfo = this.callMap.get(Integer.valueOf(i));
        if (callInfo == null) {
            System.out.println("callbackToLua: no such msgID " + i);
            return;
        }
        System.out.println("callback: " + i + " " + callInfo.funcName);
        this.callMap.remove(Integer.valueOf(i));
        Cocos2dxHelper.runOnGLThread(new Runnable() { // from class: www.tianji.finalsdk.MessageHandler.1
            @Override // java.lang.Runnable
            public void run() {
                System.out.println("callbackToLua: " + i + " " + callInfo.funcName + ", " + str);
                Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callInfo.callbackId, str);
            }
        });
    }

    public ArrayList<CallInfo> getCallbackByName(String str) {
        ArrayList<CallInfo> arrayList = new ArrayList<>();
        for (CallInfo callInfo : this.callMap.values()) {
            if (callInfo.funcName.equals(str)) {
                arrayList.add(callInfo);
            }
        }
        return arrayList;
    }

    @Override // android.os.Handler
    public void handleMessage(Message message) {
        super.handleMessage(message);
        int intValue = ((Integer) message.obj).intValue();
        if (this.callMap.get(Integer.valueOf(intValue)) == null) {
            System.out.println("handleMessage: no such msgID " + intValue);
            return;
        }
        CallInfo callInfo = this.callMap.get(Integer.valueOf(intValue));
        System.out.println("handleMessage: " + intValue + " " + callInfo.funcName + ", " + callInfo.bundle);
        try {
            this.activity.getClass().getMethod(callInfo.funcName, CallInfo.class).invoke(this.activity, callInfo);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e2) {
            e2.printStackTrace();
        } catch (InvocationTargetException e3) {
            e3.printStackTrace();
        }
    }

    public void receiveMsg(String str, String str2, int i) {
//        idk
        activity.callNativeFunc();
//        CallInfo callInfo = new CallInfo();
//        callInfo.msgID = messageIDCounter.intValue();
//        messageIDCounter = Integer.valueOf(messageIDCounter.intValue() + 1);
//        callInfo.funcName = str;
//        callInfo.bundle = str2;
//        callInfo.callbackId = i;
//        this.callMap.put(Integer.valueOf(callInfo.msgID), callInfo);
//        Message message = new Message();
//        message.obj = Integer.valueOf(callInfo.msgID);
//        sendMessage(message);
    }

    public void removeCallback(int i) {
        this.callMap.remove(Integer.valueOf(i));
    }
}
