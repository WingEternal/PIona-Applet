cmake_minimum_required(VERSION 3.16)

project(plasma5-applets-iona)
 
find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF5Plasma REQUIRED COMPONENTS
  Plasma
)

plasma_install_package(package com.github.wingeternal.iona)
