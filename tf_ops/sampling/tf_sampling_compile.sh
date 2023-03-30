#/bin/bash
/usr/local/cuda-11.5/bin/nvcc tf_sampling_g.cu -o tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

TF_DIR=$(dirname $(python -c "import tensorflow as tf;print(tf.__file__)"))
# TF1.2
g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I $TF_DIR/include -I /usr/local/cuda-11.5/include -lcudart -L /usr/local/cuda-11.5/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.4
#g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I /home/condor/dir_249876/.conda/envs/tf/lib/python2.7/site-packages/tensorflow/include -I /usr/local/cuda-11.5/include -I/home/condor/dir_249876/.conda/envs/tf/lib/python2.7/site-packages/tensorflow/include/external/nsync/public -lcudart -L /usr/local/cuda-11.5/lib64/ -L/home/condor/dir_249876/.conda/envs/tf/lib/python2.7/site-packages/tensorflow/core -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
