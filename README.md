# Triangle counting on gpu sample code

## Compile
```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . && make
cd ..
```

## Run
```bash
./build/tc --graph data/ucidata-zachary/out.ucidata-zachary --gpu 0
```
