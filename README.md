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
## 这是cuda的专有头文件，里面有常用到的两个cuda的函数，__global__和__device__。
## 对于__global__声明符，它所定义的函数是一个内核函数，即在设备（即GPU）上执行，但仅能通过主机调用。
## 对于__device_来说，它所定义的函数在设备上执行，也仅能通过设备调用。
## 一般来说，由此头文件，就可以定义一些简单的计算函数。其他头文件慢慢接触学习。用到什么学什么是一种很好的学习方法。
# __global__ void sayHelloWorld();
函数声明，函数可以不用声明，但必须放在主函数的前面。这是C语言的基础知识，cuda编程其实就是c语言编程，cuda也不过是C语言的一个扩展库。其基本的语法没有任何不同。
# cudaDeviceReset()
重置当前线程所关联过的当前设备的所有资源，可以相当于cudaFree()。
# cuda的内存分配
先来熟悉一下c语言的内存分配。
所有程序必须预留足够的内存来储存程序使用的数据，有些是自动的，比如float x;或int plate[100];这些数据在程序离开该块时自动销毁，但有些函数可以动态分配更多的内存。
## malloc(),calloc()这两个函数是分配新的内存区域。malloc()函数会找到合适的空闲内存块，内存是匿名的，但它确实返回动态分配内存块的首字节地址，可以把该地址赋值给一个指针变量，并使用指针访问这块内存。malloc()的返回值通常定义为指向char的指针。类如以下代码，则可以用ptd[0],ptd[1]来访问。
``` c
double *ptd;
ptd=(double*) malloc(30*sizeof(double));
```

## realloc()，调整已分配好的内存区域。
## free(),释放已分配好的内存区域。
# 下面用两个数相加的例子来说明。
``` c
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "iostream"
 __global__ void addKernel(int *c, const int a, const int b)
{
	 *c = a + b;//将a+b的值保存在c的地址中。
}

int main()
{
	int c;
	int *dev_c;
	cudaMalloc((void **)&dev_c, sizeof(int));//在设备内分配一块内存，供int型的dev_c来使用。
	addKernel << <1, 3 >> > (dev_c,2, 4);//在主机上调用设备函数，将得到的值存在设备上。
	cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
    printf(" 2 + 4 = %d\n", c);
	cudaFree(dev_c);
	std::cin.get();

    return 0;
}
```
头文件不用介绍了。关键在于多了两个概念。
# 可以像调用c函数那样将参数传递给核函数。
# 当设备执行任何有用的操作时，都需要分配内存，例如将计算值返回给主机。
了解这些基本概念之后，可以关注函数cudaMalloc()
# 该函数的第一个参数是一个指针，指向于保存新分配地址内存的变量，第二个参数是分配内存的大小，返回类型为void*,但分配内存的指针不作为返回值。
# 事实上，设备指针有很多限制，
## 可以将cudaMalloc()分配的指针传递给设备上执行的函数
## 可以在设备代码上使用cudaMalloc()分配的指针进行内存读写操作
## 可以将cudaMalloc()分配的指针传递给主机上执行的函数
## 不能在主机代码使用中使用cudaMAlloc()分配的指针进行内存读写操作。
# 在主机中想访问设备上的内存，用到了函数cudaMemcpy();
## 该函数的最后一个参数设定了源指针是设备上的还是主机上的。

进阶，自行编写向量加法的cuda代码：
``` c








