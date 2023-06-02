# jaijaoni

An application that helps you manage and pay your debt easier

## Setting up
### Prerequisite
- **.env** file 
Please make sure that you have file named **.env** at the root of the project 
 *Noted:* The file should be included in the zipped folder.
- Dart version
Jaijaoni is running on dart SDK version ```3.0.2 (stable)```. The major version change may affect the running process.
- Flutter version
Jaijaoni is running on Flutter sdk version ```3.10.2```. The major version change may affect the running process.
- Enable Developer mode (Windows only)
The building plugins requries symlink support. 
Please run ``` start ms-settings:developers``` in Adminstarator mode to open the setting.


### Running Jaijaoni
1. **Download dependencies**
    Download all dependencies via ```flutter pub get```
2. **Running Jaijaoni**
    Using ``` flutter run ``` to run the project 
    Noted: Please use the compatible devices so the experience of Jaijaoni is  smoothly optimized.
2.1 **Running on web**
    If you want to run on the website, Please use ```flutter run -d chrome --web-renderer html``` instread.

### Compatible devices
- Android (With Google play service) version **13** or later
- IOS version **15** or later
- PWA (on IOS version **16.4.1(a)** or later)

### Test Account
There is an account that already has mockup data prebuilt (And we're still using it in real life as well !)
```
email: sutichok46@gmail.com
password: 123456
```
**\* noted:** this account will be avaliable till the 31st of July 2023

**Release version**

The Release version can be found at our github repository (android only)

- [Github Repository: ThisTine/Jaijaoni](https://github.com/ThisTine/Jaijaoni/releases)
    
## List of dependencies
- Go_Router
- dynamic_color
- firebase_auth
- flutter_dotenv
- cloud_firestore
- River_pod
- qr_code_scanner
- qr_flutter
- google_sign_in 
- promptpay_qrcode_generate
- image_picker
- image_picker_for_web
- uuid
