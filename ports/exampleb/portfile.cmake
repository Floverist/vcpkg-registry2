#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Floverist/exampleb
	#REF "${VERSION}"
	#SHA512 1de733a89cc204ef78c52304e92116562fe32f02ae642b9d51b5a34e01d898a14854ac2c88312626d8fa75764bbd1b1f77a66845a66bb79528c5e7d991e6ae67
    HEAD_REF main
)


#set(SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "hello-world" CONFIG_PATH "share/exampleb")
vcpkg_cmake_config_fixup(PACKAGE_NAME "exampleb" CONFIG_PATH "share/exampleb")
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)