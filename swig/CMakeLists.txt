find_package(CSharp REQUIRED)
include(${CSharp_USE_FILE})

find_package(wxWidgets REQUIRED)
include(${wxWidgets_USE_FILE})

find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_SWIG_FLAGS "-namespace" "org.vovkasm")

set_source_files_properties(wx.i PROPERTIES CPLUSPLUS ON)

SWIG_ADD_MODULE(wxsharpglue csharp wx.i)
SWIG_LINK_LIBRARIES(wxsharpglue ${wxWidgets_LIBRARIES})

set_target_properties(${SWIG_MODULE_wxsharpglue_REAL_NAME} PROPERTIES LINK_INTERFACE_LIBRARIES "")
set_property(TARGET ${SWIG_MODULE_wxsharpglue_REAL_NAME} PROPERTY NO_SONAME 1)

configure_file(
${CMAKE_CURRENT_SOURCE_DIR}/AssemblyInfo.cs.in
${CMAKE_CURRENT_BINARY_DIR}/AssemblyInfo.cs
@ONLY)

add_custom_command(
    OUTPUT ${LIBRARY_OUTPUT_PATH}/wx-sharp.dll
    COMMAND ${CMAKE_CSHARP_COMPILER} ARGS "/t:library" "/out:${LIBRARY_OUTPUT_PATH}/wx-sharp.dll" "*.cs"
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS "${swig_generated_file_fullname}" ${CMAKE_CURRENT_BINARY_DIR}/AssemblyInfo.cs
    COMMENT "Compile with CSharp *.cs"
    )

add_custom_target(WxSharp ALL
    DEPENDS ${LIBRARY_OUTPUT_PATH}/wx-sharp.dll
    COMMENT "building wx-sharp.dll"
    )
