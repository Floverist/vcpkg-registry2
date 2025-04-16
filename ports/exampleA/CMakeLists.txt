cmake_minimum_required(VERSION 3.10)

project(exampleA)

include(GNUInstallDirs)

# Find the fmt library
find_package(fmt CONFIG REQUIRED)

# Add your library
add_library(exampleA exampleA.cpp)

if (BUILD_SHARED_LIBS AND MSVC)
    target_compile_definitions(exampleA PRIVATE MYLIB_EXPORTS)
endif()

# Link your library to fmt
target_link_libraries(exampleA PRIVATE fmt::fmt)


# Add include directories
target_include_directories(exampleA PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>   # for headers when building
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>  # for client in install mode
)
# Install the library and its headers
install(TARGETS exampleA
        EXPORT exampleA_targets
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")

install(FILES exampleA.h DESTINATION include)


# Generate and install *-targets.cmake 
install(EXPORT exampleA_targets
        FILE exampleA-targets.cmake
        NAMESPACE exampleA::
        DESTINATION share/exampleA)

# Generate the config file in the current binary dir (this ensures it's not placed directly in source)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/exampleA-config.cmake"
"include(CMakeFindDependencyMacro)\n"
"find_dependency(fmt CONFIG REQUIRED)\n"
"include(\"\${CMAKE_CURRENT_LIST_DIR}/exampleA-targets.cmake\")\n"
)


# Install the generated config file
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/exampleA-config.cmake"
        DESTINATION share/exampleA)