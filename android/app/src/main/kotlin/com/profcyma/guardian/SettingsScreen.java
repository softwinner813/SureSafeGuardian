//package com.profcyma.guardian;
//
//import android.content.ComponentName;
//import android.content.Intent;
//
//public class SettingsScreen
//{
//
//    protected static void _showSettingScreen(String intentStr)
//    {
//        try
//        {
//            Intent intent = new Intent(intentStr);
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            Reference.getAppContext().startActivity(intent);
//        }
//        catch (Exception e) {Reference.showToast(e.toString(), true);}
//    }
//
//    public static void showSettingScreen()
//    {
//        _showSettingScreen("android.settings.SETTINGS");
//    }
//
//    public static void showAPNScreen()
//    {
//        _showSettingScreen("android.settings.APN_SETTINGS");
//    }
//
//    public static void showLocationScreen()
//    {
//        _showSettingScreen("android.settings.LOCATION_SOURCE_SETTINGS");
//    }
//
//    public static void showSecurityScreen()
//    {
//        _showSettingScreen("android.settings.SECURITY_SETTINGS");
//    }
//
//    public static void showWifiScreen()
//    {
//        _showSettingScreen("android.settings.WIFI_SETTINGS");
//    }
//
//    public static void showBluetoothScreen()
//    {
//        _showSettingScreen("android.settings.BLUETOOTH_SETTINGS");
//    }
//
//    public static void showDateScreen()
//    {
//        _showSettingScreen("android.settings.DATE_SETTINGS");
//    }
//
//    public static void showSoundScreen()
//    {
//        _showSettingScreen("android.settings.SOUND_SETTINGS");
//    }
//
//    public static void showDisplayScreen()
//    {
//        _showSettingScreen("android.settings.DISPLAY_SETTINGS");
//    }
//
//    public static void showApplicationScreen()
//    {
//        _showSettingScreen("android.settings.APPLICATION_SETTINGS");
//    }
//
//    public static void showNetworkSettingScreen()
//    {
//        showDataRoamingScreen();
//    }
//
//    public static void showNetworkOperatorScreen()
//    {
//        if(Reference.getSystemOptions().VERSION_SDK_INT > 15)
//        {
//            _showSettingScreen("android.settings.NETWORK_OPERATOR_SETTINGS");
//        }
//        else
//        {
//            Intent intent=new Intent(android.provider.Settings.ACTION_SETTINGS);
//            intent.setClassName("com.android.phone", "com.android.phone.NetworkSetting");
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            Reference.getAppContext().startActivity(intent);
//        }
//    }
//
//    public static void showDataRoamingScreen()
//    {
//        if(Reference.getSystemOptions().VERSION_SDK_INT > 15)
//        {
//            _showSettingScreen("android.settings.DATA_ROAMING_SETTINGS");
//        }
//        else
//        {
//            Intent intent=new Intent(Settings.ACTION_DATA_ROAMING_SETTINGS);
//            ComponentName cName = new ComponentName("com.android.phone","com.android.phone.Settings");
//            intent.setComponent(cName);
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            Reference.getAppContext().startActivity(intent);
//        }
//    }
//
//    public static void showDataMobileScreen()
//    {
//        if(Reference.getSystemOptions().VERSION_SDK_INT > 15)
//        {
//            Intent intent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);//android.provider.Settings.ACTION_SETTINGS //Intent.ACTION_MAIN
//            intent.setClassName("com.android.settings", "com.android.settings.Settings$DataUsageSummaryActivity");
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            Reference.getAppContext().startActivity(intent);
//        }
//        else
//        {
//            showDataRoamingScreen();
//        }
//    }
//
//    public static void showNotificationScreen()
//    {
//        _showSettingScreen("android.settings.NOTIFICATION_SETTINGS");
//    }
//
//    public static void showBatterySaverScreen()
//    {
//        _showSettingScreen("android.settings.BATTERY_SAVER_SETTINGS");
//    }
//
//    public static void showNfcScreen()
//    {
//        _showSettingScreen("android.settings.NFC_SETTINGS");
//    }
//
//    public static void showInternalStorageScreen()
//    {
//        _showSettingScreen("android.settings.INTERNAL_STORAGE_SETTINGS");
//    }
//
//    public static void showDictionarySettingScreen()
//    {
//        _showSettingScreen("android.settings.USER_DICTIONARY_SETTINGS");
//    }
//
//    public static void showManageApplicationsScreen()
//    {
//        _showSettingScreen("android.settings.MANAGE_APPLICATIONS_SETTINGS");
//    }
//
//    public static void showManageAllApplicationsScreen()
//    {
//        _showSettingScreen("android.settings.MANAGE_ALL_APPLICATIONS_SETTINGS");
//    }
//
//    public static void showMemoryCardScreen()
//    {
//        _showSettingScreen("android.settings.MEMORY_CARD_SETTINGS");
//    }
//
//    public static void showAirPlaneScreen()
//    {
//        if(Reference.getSystemOptions().VERSION_SDK_INT > 16)
//        {
//            if(Reference.getSystemOptions().BRAND.equalsIgnoreCase("Lenovo"))
//            {
//                showSettingScreen();
//            }
//            else
//            {
//                _showSettingScreen("android.settings.WIRELESS_SETTINGS");
//            }
//        }
//        else
//        {
//            _showSettingScreen("android.settings.AIRPLANE_MODE_SETTINGS");
//        }
//    }
//
//    public static void showWirelessScreen()
//    {
//        _showSettingScreen("android.settings.WIRELESS_SETTINGS");
//    }
//
//    public static void showWifiScreenSafe()
//    {
//        try
//        {
//            Intent intent = new Intent(Intent.ACTION_MAIN, null);
//            intent.addCategory(Intent.CATEGORY_LAUNCHER);
//            ComponentName cn = new ComponentName("com.android.settings", "com.android.settings.wifi.WifiSettings");
//            intent.setComponent(cn);
//            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            Reference.getAppContext().startActivity(intent);
//        }
//        catch (Exception e)
//        {}
//    }
//}