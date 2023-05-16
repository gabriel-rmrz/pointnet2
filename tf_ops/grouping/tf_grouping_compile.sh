#/bin/bash
/usr/local/cuda-11.2/bin/nvcc tf_grouping_g.cu -o tf_grouping_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

TF_DIR=$(dirname $(python -c "import tensorflow as tf;print(tf.__file__)"))

# TF1.2
#g++ -std=c++17 tf_grouping.cpp tf_grouping_g.cu.o -o tf_grouping_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-11.2/include -lcudart -L /usr/local/cuda-11.2/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0 
# TF1.4
g++ -std=c++11 tf_grouping.cpp tf_grouping_g.cu.o -o tf_grouping_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-11.2/include -I $TF_DIR/include/external/nsync/public -lcudart -L /usr/local/cuda-11.2/lib64/ -L$TF_DIR -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0



# TF>1.4
#g++ -std=c++17 tf_grouping.cpp tf_grouping_g.cu.o -o tf_grouping_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-11.2/include -I $TF_DIR/include/external/nsync/public -lcudart -L /usr/local/cuda-11.2/lib64/ -L$TF_DIR -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX17_ABI=0


