cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

if(NOT TARGET score_lib_base)
  include("${SCORE_SOURCE_DIR}/cmake/ScoreExternalAddon.cmake")
endif()

project(score_addon_audiooracle LANGUAGES CXX)

# General initialization
score_common_setup()

# Creation of the library
add_library(score_addon_audiooracle
        AudioOracle/AudioOracleFactory.cpp
        AudioOracle/AudioOracleFactory.hpp

        score_addon_audiooracle.hpp
        score_addon_audiooracle.cpp
)

# Link
target_link_libraries(score_addon_audiooracle PUBLIC score_lib_process score_plugin_media)

# Target-specific options
setup_score_plugin(score_addon_audiooracle)
