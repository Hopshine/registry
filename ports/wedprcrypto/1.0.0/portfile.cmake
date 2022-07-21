vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO WeBankBlockchain/WeDPR-Lab-Crypto
    REF 88e3e9c20ec324b506a67fd88f5240529a2c01ff
    SHA512 5f1ff9fecb97380e0ad6aebb904e5d045ed63e0cef96e1db7d1a1e69c1749578906d19f97fd0ae04ae79ca901d2371e69202e173a6f20d585ead473d7a1486ca
    HEAD_REF master
)

set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)

find_program(CARGO_BIN NAMES cargo REQUIRED PATHS "$ENV{USERPROFILE}\\.cargo\\bin")
message(STATUS "CARGO BIN: ${CARGO_BIN}")

vcpkg_cmake_configure(
    SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}"
    OPTIONS -DSOURCE_PATH=${SOURCE_PATH} -DCARGO_BIN=${CARGO_BIN}
)

vcpkg_cmake_build()
vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)