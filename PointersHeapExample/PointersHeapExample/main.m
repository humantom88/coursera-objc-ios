//
//  main.m
//  PointersHeapExample
//
//  Created by Tom Belov on 05/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

int* a = NULL;

void swapItOut(int c) {
    printf("swapItOut: a is now %p and points to %d\n", a, (*a));
    a = (&c);
    printf("swapItOut: a is now %p and points to %d\n", a, (*a));
}

void swapItOut2(int c) {
    printf("swapItOut: a is now %p and points to %d\n", a, (*a));
    (*a) = c;
    printf("swapItOut: a is now %p and points to %d\n", a, (*a));
}

void dontSwapItOut(int c) {
    printf("dontSwapItOut: c is now %d\n", c);
}

int main(int argc, const char * argv[]) {
    
    // Dangerous scenario (using stack)
    //    int b = 5;
    //
    //    a = (&b);
    //    printf("main: a is now %p and points to %d\n", a, (*a));
    //    swapItOut(10);
    //    printf("main: a is now %p and points to %d\n", a, (*a));
    //    dontSwapItOut(20);
    //    printf("main: a is now %p and points to %d\n", a, (*a));
    
    // Safe scenario (using heap)
    int b = 5;
    
    a = malloc(sizeof(int));
    printf("main: a is now %p and points to %d\n", a, (*a));
    (*a) = b;
    printf("main: a is now %p and points to %d\n", a, (*a));
    swapItOut2(10);
    printf("main: a is now %p and points to %d\n", a, (*a));
    dontSwapItOut(20);
    printf("main: a is now %p and points to %d\n", a, (*a));
    free(a);
    
    
    // Example to not warmup your room by your processor
    do {
        a = malloc(sizeof(int));
        free(a); // if remove this - processor will die ))) joke
    } while (a != NULL);
    
    return 0;
}
