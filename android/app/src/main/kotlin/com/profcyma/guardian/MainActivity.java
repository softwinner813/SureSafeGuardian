package com.profcyma.guardian;

import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.net.sip.SipProfile;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.os.PowerManager;
import android.provider.ContactsContract;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;

import java.text.ParseException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.rxjava3.annotations.NonNull;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.Observer;
import io.reactivex.rxjava3.disposables.Disposable;

import static android.net.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED;
import static android.net.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED;
import static android.net.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED;


public class MainActivity extends FlutterActivity {


    BackgroundService backgroundService;

    Boolean mBound;
    private static final String CHANNEL = "com.tarazgroup";


    ServiceConnection serviceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder binder) {
            backgroundService = ((BackgroundService.LocalBinder)binder).getService();
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            backgroundService = null;
        }
    };

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);



        new MethodChannel(this.getFlutterEngine().getDartExecutor().getBinaryMessenger(), "methods").setMethodCallHandler((call, result) -> {
            switch(call.method){

                case "loginSIP":
                    dialogOverlay();
                    String username = call.argument("username");
                    String password = call.argument("password");
                    String serverURI = call.argument("serverURI");
                    AuthDetail.getInstance().setUsername(username);
                    AuthDetail.getInstance().setPassword(password);
                    backgroundService.loginSIP(AuthDetail.getInstance().getUsername(), AuthDetail.getInstance().getPassword(), serverURI==null?ServerConnectionDetails.getInstance().serverDomain:serverURI, result);
                    break;

                case "makeSIPCall":
                    System.out.printf("USERNAME: %s", call.argument("callerUsername").toString());
                    initiateAudioCallActivity(call.argument("callerUsername"));
                    break;

                case "endSIPCall":
                    backgroundService.endCall(result);
                    break;


                case "makeSIPVideoCall":
                    System.out.printf("USERNAME: %s", call.argument("callerUsername").toString());
                    initiateVideoCallActivity(call.argument("callerUsername"));
                    break;


                case "sendChat":
                    String chatMessage = call.argument("message");
                    String chatUsername = call.argument("username");
                    backgroundService.sendMessage(chatUsername, chatMessage, result);
                    break;


                case "resetAccount":
                    backgroundService.endSession(result);
                    break;


                case  "getCallHistory":
                    backgroundService.fetchCallHistory(result);
                    break;

                default:
                    Log.d("INVALID_METHOD", "Specify a valid method call!");
                    break;

            }
        });

        checkBackgroundDataRestricted();
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Intent intent = new Intent();
            String packageName = getPackageName();
            PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);
            if (!pm.isIgnoringBatteryOptimizations(packageName)) {
                intent.setAction(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
                intent.setData(Uri.parse("package:" + packageName));
                startActivity(intent);
            }
        }

    }

    public void checkBackgroundDataRestricted() {
        ConnectivityManager connMgr = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            switch (connMgr.getRestrictBackgroundStatus()) {
                case RESTRICT_BACKGROUND_STATUS_ENABLED: {
                    if(!Settings.canDrawOverlays(getContext() )){
                        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
                        AlertDialog alertDialog = dialogBuilder
                                .setTitle("Data Saver detected ")
                                .setCancelable(false)
                                .setMessage("You need to disable data saver mode  or add this app as an exception to data saver for appropriate working")
                                .setPositiveButton("Proceed", (dialog, which) -> {
                                    if(Build.VERSION.SDK_INT > 15)
                                    {
                                        Intent intent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);//android.provider.Settings.ACTION_SETTINGS //Intent.ACTION_MAIN
                                        intent.setClassName("com.android.settings", "com.android.settings.Settings$DataUsageSummaryActivity");
                                        //intent.setClassName("com.android.settings", Settings.ACTION_IGNORE_BACKGROUND_DATA_RESTRICTIONS_SETTINGS);
                                        intent.setData(Uri.parse("package:" + getPackageName()));
                                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                        startActivity(intent);
                                    }
                                    else
                                    {
                                        showDataRoamingScreen();
                                    }
                                }).setNegativeButton("Cancel",(dialog, which)->{finish();}).create();
                        alertDialog.show();
                    }

                }
                case RESTRICT_BACKGROUND_STATUS_WHITELISTED:
                case RESTRICT_BACKGROUND_STATUS_DISABLED:
                    // Data Saver is disabled or the app is whitelisted

            }
        }

    }

    public  void showDataRoamingScreen()
    {
        if(Build.VERSION.SDK_INT > 15)
        {
            //_showSettingScreen("android.settings.DATA_ROAMING_SETTINGS");
        }
        else
        {
            Intent intent=new Intent(Settings.ACTION_DATA_ROAMING_SETTINGS);
            ComponentName cName = new ComponentName("com.android.phone","com.android.phone.Settings");
            intent.setComponent(cName);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        }
    }

    void callFlutter(){
        MethodChannel methodChannel=new MethodChannel(this.getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.invokeMethod("I say hello every minute!!","");
    }

    void dialogOverlay(){
        Intent bgServiceIntent = new Intent(this, BackgroundService.class);
//        bgServiceIntent.putExtra(Constants.getInstance().signedInUserId,"");
//        bgServiceIntent.putExtra(Constants.getInstance().passwordId,"");
//        startService(bgServiceIntent);
        mBound = bindService(bgServiceIntent, serviceConnection, Context.BIND_AUTO_CREATE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if(!Settings.canDrawOverlays(getContext() )){
                AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
                AlertDialog alertDialog = dialogBuilder
                        .setTitle("Permission Required")
                        .setCancelable(false)
                        .setMessage("You need to enable the \"Display over other apps\" permission for \"background running\" continue")
                        .setPositiveButton("Proceed", (dialog, which) -> {
                            RequestPermission();
                        }).setNegativeButton("Cancel",(dialog, which)->{stopService(bgServiceIntent);finish();}).create();
                alertDialog.show();
            }
        }
    }

    void initiateVideoCallActivity(String callerUserName){
        try {
            SipProfile profile = new SipProfile.Builder(callerUserName, new ServerConnectionDetails().serverDomain).build();
            Intent videoCallActivityIntent = new Intent(this, VideoCallActivity.class);
            videoCallActivityIntent.putExtra(Constants.getInstance().callerUsernameId, callerUserName);
            startActivity(videoCallActivityIntent);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    void initiateAudioCallActivity(String callerUserName){
        try {
            SipProfile profile = new SipProfile.Builder(callerUserName, new ServerConnectionDetails().serverDomain).build();
            Intent audioCallActivityIntent = new Intent(this, AudioCallerActivity.class);
            audioCallActivityIntent.putExtra(Constants.getInstance().callerUsernameId, callerUserName);
            startActivity(audioCallActivityIntent);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    private void launchContactActivity() {
        Intent intent = new Intent(Intent.ACTION_INSERT);
        intent.setType(ContactsContract.Contacts.CONTENT_TYPE);
        startActivityForResult(intent,0);
    }


    public static int ACTION_MANAGE_OVERLAY_PERMISSION_REQUEST_CODE= 2323;

    private void RequestPermission() {
        // Check if Android M or higher
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            // Show alert dialog to the user saying a separate permission is needed
            // Launch the settings activity if the user prefers
            Intent myIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
            startActivity(myIntent);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == ACTION_MANAGE_OVERLAY_PERMISSION_REQUEST_CODE) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!Settings.canDrawOverlays(getContext())) {
                    PermissionDenied();
                }
                else
                {
                    // Permission Granted-System will work
                }

            }
        }
    }

    private void PermissionDenied() {
        RequestPermission();
    }


    @Override
    protected void onResume() {
        super.onResume();
        Intent bgServiceIntent = new Intent(this,
                BackgroundService.class);
        mBound = bindService(bgServiceIntent, serviceConnection, Context.BIND_AUTO_CREATE);
    }

    @Override
    protected void onPause() {
        super.onPause();
        System.out.println("Activity paused");
        if(mBound) {
            unbindService(serviceConnection);
            mBound = false;
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        if(mBound) {
            unbindService(serviceConnection);
            mBound = false;
        }
    }


}