#/bin/bash

/usr/local/cuda-9.0/bin/nvcc tf_sampling_g.cu -o tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

TF_DIR=$(dirname $(python -c "import tensorflow as tf;print(tf.__file__)"))
#TF_DIR=/lustrehome/garamire/miniconda3/envs/tf1/lib/python3.7/site-packages/tensorflow_core/
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
echo $TF_LIB

# TF1.2
g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-9.0/include -lcudart -L /usr/local/cuda-9.0/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.4
#g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I $TF_LIB/include -I /usr/local/cuda-9.0/include -I $TF_INC/include/external/nsync/public -lcudart -L /usr/local/cuda-9.0/lib64/ -L $TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF>1.4
#g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-9.0/include -I $TF_DIR/include/external/nsync/public -lcudart -L /usr/local/cuda-9.0/lib64/ -L $TF_DIR -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

