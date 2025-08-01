cmake_minimum_required(VERSION  3.10)
project(DemoCMAKE)
set(CMAKE_C_STANDARD 99)

include_directories(inc)
add_executable(demo_cmake src/main.c)

add_custom_target(run
    COMMAND $<TARGET_FILE:demo_cmake>
    DEPENDS demo_cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Running the app"
)
