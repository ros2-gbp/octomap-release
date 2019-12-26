# COMPILER SETTINGS (default: Release)
# use "-DCMAKE_BUILD_TYPE=Debug" in cmake for a Debug-build
IF(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
   SET(CMAKE_BUILD_TYPE Release)
ENDIF(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)

MESSAGE ("\n")
MESSAGE (STATUS "${PROJECT_NAME} building as ${CMAKE_BUILD_TYPE}")

# OCTOMAP_OMP = enable OpenMP
# SET(OCTOMAP_OMP 1 CACHE BOOL "Enable/disable OpenMP")
# IF($ENV{OCTOMAP_OMP})
#   SET(OCTOMAP_OMP $ENV{OCTOMAP_OMP}) 
#   MESSAGE(STATUS "Found OCTOMAP_OMP=${OCTOMAP_OMP}")
# ENDIF($ENV{OCTOMAP_OMP})

# COMPILER FLAGS
IF (CMAKE_COMPILER_IS_GNUCC)
  SET (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-error ")
  SET (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wno-error ")
  SET (CMAKE_CXX_FLAGS_RELEASE "-O3 -funroll-loops -DNDEBUG") #sse3 disabled for compatibility
#  SET (CMAKE_CXX_FLAGS_RELEASE "-O3 -funroll-loops -DNDEBUG -msse3 -mssse3")
  SET (CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
  # Shared object compilation under 64bit (vtable)
  ADD_DEFINITIONS(-fPIC)  
  # IF(OCTOMAP_OMP)
  #   SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fopenmp")
  #   SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -fopenmp")
  # ENDIF(OCTOMAP_OMP)
ENDIF()

# Set full rpath http://www.paraview.org/Wiki/CMake_RPATH_handling
# (good to have and required with ROS)
set(CMAKE_SKIP_BUILD_RPATH  FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# no prefix needed for python modules
set(CMAKE_SHARED_MODULE_PREFIX "")