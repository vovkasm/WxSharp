find_package(CSharp REQUIRED)
include(${CSharp_USE_FILE})

set(DEP)
set_source_files_properties(${LIBRARY_OUTPUT_PATH}/wx-sharp.dll PROPERTIES GENERATED 1)
file(TO_NATIVE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/sample.cs native_path_to_src)

add_custom_command(
    OUTPUT ${LIBRARY_OUTPUT_PATH}/sample.exe
    COMMAND ${CMAKE_CSHARP_COMPILER} ARGS "/r:${LIBRARY_OUTPUT_PATH}/wx-sharp.dll" "/out:${LIBRARY_OUTPUT_PATH}/sample.exe" ${native_path_to_src}
    COMMENT "Compile with CSharp *.cs"
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/sample.cs
    )

add_custom_target(WxSample ALL
    DEPENDS ${LIBRARY_OUTPUT_PATH}/sample.exe
    COMMENT "building sample"
    )
add_dependencies(WxSample WxSharp)
set(DEP ${DEP} ${LIBRARY_OUTPUT_PATH}/sample.exe)
