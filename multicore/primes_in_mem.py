#!/usr/bin/env python3

from random import randint

primes=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251]

l = []
for i in range(0, 256):
    val = randint(0, 255)
    while val in primes:
        val = randint(0, 255)
    l.append(val)

for prime in primes:
    i = randint(0, 255)
    while l[i] in primes:
        i = randint(0, 255)
    l[i] = prime

for i in range(0,256,4): 
    s = f"{{mem[{i}], mem[{i+1}], mem[{i+2}], mem[{i+3}]}} <= {{8'd{l[i]}, 8'd{l[i+1]}, 8'd{l[i+2]}, 8'd{l[i+3]}}};"
    print(s)
