import random
with open("1.txt", "wb") as f:
    for x in range(10):
        f.write(bytearray(10))
        f.write(bytearray([ random.randint(0, 255) for i in range(10)]) )