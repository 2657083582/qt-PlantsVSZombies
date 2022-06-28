cmake_minimum_required(VERSION 3.23)

project(planeVsZombie VERSION 0.1 LANGUAGES CXX)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
# set cxx 17 required
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
# add widgets package
find_package(Qt6 REQUIRED COMPONENTS Widgets)

qt_add_executable(appplaneVsZombie
    main.cpp
    plantarr.cpp    plantarr.h
    zombiearr.cpp   zombiearr.h
    resources.qrc
)

qt_add_qml_module(appplaneVsZombie
    URI planeVsZombie
    VERSION 1.0
    QML_FILES main.qml 
    MainMenu.qml
    RecordWindow.qml
    SettingWindow.qml
    BasicZombie.qml
    BucketheadZombie.qml
    ConeheadZombie.qml
    FlagZombie.qml
    PoleVaultingZombie.qml
    Cherrybomb.qml
    Pea.qml
    Peashooter.qml
    Potatomine.qml
    Sunflower.qml
    Wallnut.qml
    Card.qml
    GameWindow.qml
    Map.qml
    Mower.qml
    Shop.qml
    Shovel.qml
    SeedChooser.qml
    Sun.qml
    SelfSun.qml
    MowerCreator.qml
)

# auto add .h and .cpp for sources
set(GLOB sources CMAKE_CONFIGURE_DEPENDS *.h *.cpp )

set_target_properties(appplaneVsZombie PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appplaneVsZombie
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appplaneVsZombie
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Widgets)

target_sources(appplaneVsZombie PUBLIC ${sources})
