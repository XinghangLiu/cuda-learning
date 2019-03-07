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
