# cuda-learning
自学cuda的一些体会与心得，以及遇到的一些问题，欢迎感兴趣的同学一起交流
基础
==========
环境
------
# vs+cuda10.0
配置过程这里不再描述，[如何配置vs+cuda，开始自己的第一段gpu编程之旅] https://blog.csdn.net/m0_37870649/article/details/79327178 有详细的过程。
helloworld
-------
```c
#include "cuda_runtime.h"
#include "iostream"
__global__ void sayHelloWorld();

void main(void) {

	printf("HelloWorld! CPU \n");
	sayHelloWorld << <1, 6>> > ();   //调用GPU上执行的函数，调用GPU线程
	cudaDeviceReset();    //显式地释放和清空当前进程中与当前设备有关的所有资源，不加这句不会打印GPU中的输出语句"HelloWorld! GPU"
  system("pause");

}

__global__ void sayHelloWorld() {
	printf("HelloWorld! GPU \n");
}
```
# #include "cuda_runtime.h"
这是cuda的专有头文件，里面有常用到的两个cuda的函数，__global__和__device__。
对于__global__声明符，它所定义的函数是一个内核函数，即在设备（即GPU）上执行，但仅能通过主机调用。
对于__device_来说，它所定义的函数在设备上执行，也仅能通过设备调用。
一般来说，由此头文件，就可以定义一些简单的计算函数。其他头文件慢慢接触学习。用到什么学什么是一种很好的学习方法。
# __global__ void sayHelloWorld();
函数声明，函数可以不用声明，但必须放在主函数的前面。这是C语言的基础知识，cuda编程其实就是c语言编程，cuda也不过是C语言的一个扩展库。其基本的语法没有任何不同。
# cudaDeviceReset()
重置当前线程所关联过的当前设备的所有资源，可以相当于cudaFree()。
# cuda的内存分配
先来熟悉一下c语言的内存分配。
malloc(),calloc()这两个函数是分配新的内存区域。
realloc()，调整已分配好的内存区域。
free(),释放已分配好的内存区域。










