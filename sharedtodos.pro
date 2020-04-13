# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.theprogers.shared_to_do
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "6D4B3C96BAFE202393EC9D6E55F7881D4DAD07A617114C61E6AF2E1C6D84E6D421FB11AE4242B37BEBCF88EB1188B8E5E39DDE8641515A0EBD9FB55E63F1DF8A8AAC0C4939817D54228D96E21F22276B2E88E250E03E8A2A72164F60C0091E68C727B2649F4A9E1ED5925FAD28123E03C0A6614D7DF75F95D9C783ECF0CDA732D9489907E809CCDA9ACE6093AD426E87F76076F2E6DB134A08A350E701EC45BEB259B50688134E56D6C12E91AD44BA4A652E4BDD4160E8FBAFC8867AE36D08666AFEF073195B9C4F230B4C34C3D87C0FCCFE89D74F94BCC2F91DF1E9B61EE6F57E09971F45682A7739D3972AC33361D71D3EBBF1B289A11D1A4A16C63F6AB1DFEE87F31B5593557317C3E7C84507833D778D25CAE50515885120D328B2A7F443E450989F62DB1E5920EFAE23E2B7B79E77F91FDF1DCCDFA664238797F623C7A1C04A5F0A4355ACB27068F35B767D4F02"
qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += \  #    resources.qrc # uncomment for publishing
    assets.qrc

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

FELGO_PLUGINS += firebase

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    android/google-services.json \
    qml/components/DrawerDelegate.qml \
    qml/components/SwipeOptionButton.qml \
    qml/components/TodoDelegate.qml \
    qml/pages/RegisterPage.qml \
    qml/pages/WelcomePage.qml \
    qml/style/Style.qml \
    qml/style/qmldir
