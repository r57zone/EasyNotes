[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/EasyNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/EasyNotes/blob/master/README.RU.md) 
← Choose language | Выберите язык

# EasyNotes
![](https://user-images.githubusercontent.com/9499881/100446367-1cd14000-30c8-11eb-8e82-335f134a8c95.png)

Notes apps for Windows, iOS and Android, with direct local sync or web server sync. The server can be either a Windows application (you need to run it for synchronization) or your web server. View API can be [here](https://github.com/r57zone/EasyNotes/blob/master/API.md).

## Features
If you want to leave the old date when editing a note then on mobile phones you need to click on the date and on the PC hold down the "Shift" key when you click on the done button.


Apps have a dark theme and automatic switching to it in the dark time.


Full tablet support is also present.


Due to WebSQL disabling, we had to switch to local storage in mobile and web versions. Because of this there is a limit of 5 megabytes for notes, you can monitor the amount of available memory in the application settings. 


~~The Android version has a QR code scanner.~~ Removed since version 1.0.5.

## Setup
### Sync of the mobile apps via P2P
1. Reserve a permanent IP address for a computer with a Windows application. This is done in the settings of the Wi-Fi router in the "DHCP" section.
2. Reserve the permanent IP address of the mobile device and add it, if it is missing, in the Windows application settings. You can also open access to all IP addresses (not secure). Delete unnecessary IP addresses if necessary.
3. Check Windows Firewall to see if incoming connections are allowed on your network type (private) and allow if disabled.

### iOS
Open browser Safari on your mobile device and enter there "http://IP:735/webapp", where IP is the reserved permanent IP of your computer. Next you need to click "Share" -> "On the Home Screen". A shortcut to EasyNotes appears on the desktop.


To update, you need to synchronize, then go to the "Safari" settings and delete history and data, after which you can add the application again.

### Android
Install "EasyNotes.apk" and enter the reserved permanent IP of your computer. If your router assigns the following IP addresses: `192.168.0.0/15`, `192.168.0.100/115`, `192.168.1.0/15`, `192.168.1.100/115`, `192.168.2.0/15`, `192.168.3.0/15`, then you can just enable auto-search for IP addresses and the app will find your computer itself.

### Windows
For Windows, there are 2 applications, one is a server application that is a P2P sync hub and the other is a client application that syncs with a P2P or web server.

### Setup web sync
Follow the instructions described [here](https://github.com/r57zone/EasyNotes/tree/master/Source/Web).

## Screenshots
### Windows
[![](https://user-images.githubusercontent.com/9499881/189445412-0452a2c0-55c8-46ea-8cdf-95ea8e0cece0.PNG)](https://user-images.githubusercontent.com/9499881/54879005-a89fbd00-4e4d-11e9-8278-62a3f7b52955.PNG)
[![](https://user-images.githubusercontent.com/9499881/189445462-10f1fc9e-f213-48c3-b41e-fccfbdf371f6.PNG)](https://user-images.githubusercontent.com/9499881/93085231-4de3cc00-f6a6-11ea-824c-0496d8e7f4de.PNG)

### iOS
![](https://user-images.githubusercontent.com/9499881/54878988-66767b80-4e4d-11e9-941b-696836b3cb46.PNG)
![](https://user-images.githubusercontent.com/9499881/54878994-755d2e00-4e4d-11e9-9dfc-b3ff67bb55d6.PNG)
![Setup](https://user-images.githubusercontent.com/9499881/54852962-d2e76280-4d07-11e9-841a-06d50fafb3c4.gif)

### Android
[![](https://user-images.githubusercontent.com/9499881/93084929-de6ddc80-f6a5-11ea-9590-7ff4943664f6.png)](https://user-images.githubusercontent.com/9499881/93084738-8fc04280-f6a5-11ea-8c73-7f2ddee691b0.png)
[![](https://user-images.githubusercontent.com/9499881/93084927-ddd54600-f6a5-11ea-8e49-126cbf637e5e.png)](https://user-images.githubusercontent.com/9499881/93084733-8f27ac00-f6a5-11ea-8695-a38333d8e1b2.png)
[![](https://user-images.githubusercontent.com/9499881/93085075-1412c580-f6a6-11ea-91bd-e710b9cfa36a.png)](https://user-images.githubusercontent.com/9499881/93085001-f80f2400-f6a5-11ea-8f15-c05503f6b70a.png)
[![](https://user-images.githubusercontent.com/9499881/93085078-14ab5c00-f6a6-11ea-9657-239175a85f24.png)](https://user-images.githubusercontent.com/9499881/93084998-f7768d80-f6a5-11ea-8ed3-b75c1404bc77.png)

## Download
>Versions for Android 7.1+, iOS 9+ & Windows 7+ (with Internet Explorer 11 installed). 

**[Download](https://github.com/r57zone/EasyNotes/releases)**

## Feedback
`r57zone[at]gmail.com`