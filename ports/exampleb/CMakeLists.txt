cmake_minimum_required(VERSION 3.10)

project(exampleb)

include(GNUInstallDirs)

# Find the fmt library
find_package(fmt CONFIG REQUIRED)

# Add your library
add_library(exampleb exampleb.cpp)

if (BUILD_SHARED_LIBS AND MSVC)
    target_compile_definitions(exampleb PRIVATE MYLIB_EXPORTS)
endif()

# Link your library to fmt
target_link_libraries(exampleb PRIVATE fmt::fmt)


# Add include directories
target_include_directories(exampleb PUBLIC 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>   # for headers when building
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>  # for client in install mode
)
# Install the library and its headers
install(TARGETS exampleb
        EXPORT exampleb_targets
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")

install(FILES exampleb.h DESTINATION include)


# Generate and install *-targets.cmake 
install(EXPORT exampleb_targets
        FILE exampleb-targets.cmake
        NAMESPACE exampleb::
        DESTINATION share/exampleb)

# Generate the config file in the current binary dir (this ensures it's not placed directly in source)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/exampleb-config.cmake"
"include(CMakeFindDependencyMacro)\n"
"find_dependency(fmt CONFIG REQUIRED)\n"
"include(\"\${CMAKE_CURRENT_LIST_DIR}/exampleb-targets.cmake\")\n"
)


# Install the generated config file
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/exampleb-config.cmake"
        DESTINATION share/exampleb)