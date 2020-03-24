# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.theprogers.sharedtodo
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "95884288E5342B0324322800B1BCB523A6E5EAA6052CA07EFE7CD733241A1BD617AAD150D2B77D866D23605F507B0F828BE357A265F0154EAC566294BA39C7F615D685B6165649C8893E9C7216DC95CB843DC29C15F01D9F89650B662FD0BCFE76AB9DC2E2DC2A8F2C507E8CBD04000AF9B981517D4EED461EBC85C42F1753801D7A69C85DC55157C40AC5DFB2280EBF8A792710C0CD01FF2A6181FF085D7743C777E86DC511204E1C00C5D3405AEEC0DBB5FEE433644C4AC7A59B058239508EE53D2859C9836A40951F3BA8AA99F0E9AFF0F5E056228CB5C682A3B3CFE0237623179C53393C2C064E9C0B781DE96E07411CD1E28E6D3C95046D115110F7FAF96862908AA51216DCC206D1A3A320762A4CCEECEF587EF9C963B32B609895D78B332153EA2CF43A6AF48B20331C9413D432DC7C7D6650E156C3A9C33F20F6B48923D1887BEE5B08A4911B5561F1BD535E"
qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

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
