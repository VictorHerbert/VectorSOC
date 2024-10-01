from itertools import batched

offset = input()
print(offset)

while True:
    try:    
        bytes = input().split()
        for word in batched(bytes, 4):
            print(''.join(reversed(word)))
    except EOFError:
        break