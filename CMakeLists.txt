cmake_minimum_required(VERSION 3.16)
project(bcd_arithm)

find_package(verilator)

add_executable(bcd_arithm bcd_sim.cpp)
verilate(bcd_arithm SOURCES bcd_add.sv)