#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)


vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Floverist/exampleb
	REF "${VERSION}"
	SHA512 ad11e0082fb2d5e1cdfe357049f58cc1ea9dd379ffca2e36eb2361af583988e8df1e4f43e6de5fe39bed1c080ed1d71efa135fba7a1c01d63991f7fc86dffa67
    HEAD_REF main
)


#[[
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/Floverist/exampleb.git            # Git repository cloning URL
    REF f1d00369ac3f4ece9315bf19e350b00ea0d12058 # commit hash (pointing to a version tag)
)
]]


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