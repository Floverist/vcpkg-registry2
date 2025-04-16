#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

#[[
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/vcpkg-docs
    REF "${VERSION}"
    SHA512 4202125968a01219deeee14b81e1d476dab18d968425ba36d640816b0b3db6168f8ccf4120ba20526e9930c8c7294e64d43900ad2aef9d5f28175210d0c3a417
    HEAD_REF cmake-sample-lib
)
]]

set(SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "hello-world" CONFIG_PATH "share/hello-world")
vcpkg_cmake_config_fixup(PACKAGE_NAME "exampleb" CONFIG_PATH "share/exampleb")
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)