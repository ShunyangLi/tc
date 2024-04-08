add_library(src
        # graph folder
        graph/graph.h
        graph/graph.cpp
        tc/tc.cu
        tc/tc.cuh)


#include_directories(tc)
#include_directories(graph)
