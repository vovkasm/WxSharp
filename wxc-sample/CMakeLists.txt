find_package(wxWidgets REQUIRED)
include(${wxWidgets_USE_FILE})

include_directories(../wxc/src/include)

add_executable(wxc-sample sample.cpp)
target_link_libraries(wxc-sample wx-c ${wxWidgets_LIBRARIES})
