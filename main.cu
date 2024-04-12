#include <iostream>
#include <argparse/argparse.hpp>

#include "graph/graph.h"
#include "tc/tc.cuh"

#include <loguru.hpp>
//#define LOGURU_WITH_STREAMS 1


int main(int argc, char* argv[]) {
    loguru::init(argc, argv);
    LOG_F(INFO, "Hello from main.cpp!");
    LOG_F(INFO, "main function about to end!");

    argparse::ArgumentParser parser("triangle counting");

    parser.add_argument("--gpu")
            .help("GPU Device ID (must be a positive integer)")
            .default_value(0)
            .action([](const std::string &value) { return std::stoi(value); });

    parser.add_argument("--graph")
            .help("Graph file path")
            .default_value("/")
            .action([](const std::string &value) { return value; });

    try {
        parser.parse_args(argc, argv);
    } catch (const std::exception& err) {
        std::cout << parser << std::endl;
        exit(EXIT_FAILURE);
    }

    auto device_count = 0;
    auto device_id = 0;

    cudaGetDeviceCount(&device_count);
    if (device_count == 0) {
        std::cerr << "error: no gpu device found" << std::endl;
        exit(EXIT_FAILURE);
    }

    if (parser.is_used("--gpu")) {
        device_id = parser.get<int>("--gpu");
        if (device_id >= device_count) {
            std::cerr << "error: invalid gpu device id" << std::endl;
            exit(EXIT_FAILURE);
        }
        cudaSetDevice(device_id);
    }

    if (parser.is_used("--graph")) {
        auto dataset = parser.get<std::string>("--graph");
        auto g = Graph(dataset);

        // then aglorithm
        tc(&g);
    }

}
