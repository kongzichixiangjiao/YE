//
//  YYCDemo.c
//  YE
//
//  Created by 侯佳男 on 2017/8/31.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

#include "YYCDemo.h"

int c_sum(int a, int b) {
    return a + b;
}

/*
void c_swap(void *a, void *b) {
    void temp; // 不能定义为无类型
    temp = *a;
    *a = *b;  // 指针不能指向无类型
    *b = temp;
}
 */

void c_swap(void *vp1,void *vp2,int size){
    char buffer[size];/*注意此处gcc编译器是允许这样声明的，而我印象中VC编译器是不可以的。*/
    memcpy(buffer,vp1,size);
    memcpy(vp1,vp2,size);
    memcpy(vp2,buffer,size);
}

int c_sumAndMinus(int a, int b, int *minus) {
    *minus = a - b;
    return a+b;
}

char *upper(char *str) {
    char *dest = str;
    while (*str != '\0') {
        // 如果是小写字母
        if (*str >= 'a' && *str <= 'z') {
            // 变为大写字母。小写和大写字母的ASCII值有个固定的差值
            *str -= 'a' - 'A';
        }
        str++;
    }
    
    return dest;
}

void counting( int (*p)(int, int) , int a, int b) {
    
    int result = p(a, b);
    
    printf("计算结果为：%d\n", result);
    
}

void bit_operation (void) {
    unsigned int a = 60; /* 60 = 0011 1100;*/
    unsigned int b = 13; /* 13 = 0000 1101;*/
    int c = 0;
    c = a & b; /* 0000 1100 = 12;*/
    printf("c = a & b的值为 %d \n",c);
    c = a | b; /* 0011 1101 = 61;*/
    printf("c = a | b的值为 %d \n",c);
    c = a ^ b; /* 0011 0001 = 49 */
    printf("c = a ^ b的值为 %d \n",c);
    c = ~a; /* 1100 0011 = -61*/
    printf("c = ~a 的值为 %d \n",c);
    c = a << 2; /* 1111 0000 = 240 */
    printf("c = a << 2 的值为 %d \n",c);
    c = a >> 2; /* 0000 1111 = 15 */
    printf("c = a >> 2 的值为 %d \n",c);
    
}

void test() {
    bit_operation();
}



int sum(int a, int b) {
    return a + b;
}

void dc_main() {
    
    int (*pp)(int a, int b) = sum;
    int result = (*pp)(2, 5);
    printf("%d", result);
    
    counting(*pp, 2, 4);
    
    printf("c_main  \n");
    int c = c_sum(2, 3);
    printf("%d  \n", c);
    
    int a[2][3] = {{1, 2, 3}, {4, 5, 6}};
    printf("%p  \n", a);
    printf("%p  \n", a[0]);
    printf("%p  \n", &a[0][0]);
    
    char name[] = "yan\0g";
    
    char name2[] = {'a' + 'b'};
    
    printf("name = s%s \n", name);
    printf("name2 = %s \n", name2);
    printf("name length = %lu \n", strlen(name));
    printf("%lu \n", strlen("我"));
    
//    char b[2][10]={"jack","rose"};
    
    char b2[3][10]={
        
        {'j', 'a', 'c', 'k', '\0'},
        
        {'r', 'o', 's', 'e', '\0'}
        
    };
    
    printf("--%s-- \n",b2[1]);
    
    printf("--%c-- \n",b2[0][3]);
    
    
    
    int d = 3; // 定义变量d
    int *p;  // 定义指针p
    
    // 001
    p = &d; // 将p的指针指向d
    printf("%p\n", p); // 0x7fff57064780
    printf("%p\n", &d); // 0x7fff57064780
    
    // 002
    printf("%d\n", *p); // 3
    printf("%d\n", d); // 3
    
    int e = 4;
    int *pe;
    pe = &e;
    *pe = 5;
    printf("%d\n", e);
    
    pe = &d;
    printf("%d\n", e);
    printf("%d\n", *pe);
    
    char cc = '3';
    char dd = '5';
    
    int ee = 9;
    int ff = 8;

    printf("%d\n", ee);
    printf("%d\n", ff);
    c_swap(&ee, &ff, sizeof(int));
    printf("%d\n", ee);
    printf("%d\n", ff);
    
    printf("%c\n", cc);
    printf("%c\n", dd);
    c_swap(&cc, &dd, sizeof(char));
    printf("%c\n", cc);
    printf("%c\n", dd);
    
    int minus = 0;
    int sum = c_sumAndMinus(ee, ff, &minus);
    printf("%d \n", sum);
    printf("%d  \n", minus);
    
    int array[] = {1, 2, 3, 4, 5};
    int *pArray;
    pArray = &array[0];
    *pArray = 10;
    printf("%d \n", array[0]);
    
    for (int i = 0; i<5; i++) {
        printf("%d \n", array[i]);
    }
    
    printf("----------------\n");
    
    char *s = "12";
    printf("%s \n", s);
    printf("%lu \n", strlen(s));
    
    printf("----------------\n");
    
    char s1[50] = "124";
    char s2[] = "123";
    
    char *s3 = "love";
//    strcat(s1, s3); // 拼接
//    strcpy(s1, s2); // s2复制到说s1
    int z = strcmp(s1, s2); // 相等时0 是s1 > s2是1 s1 < s2是-1
    printf("%d", z);
    printf("%s \n", s1);
    printf("%s \n", s2);
    printf("%s \n", s3);
    
    char d2[20] = "GoldenGlobal";
    char* s5 = "View";
    strcat(d2,s5);
    printf("%s \n",d2);
    
    printf("----------------\n");
    
    char strA[] = "love";
    char *dest = upper(strA);
    printf("%s \n", dest);
    
    test();
    
}






























































