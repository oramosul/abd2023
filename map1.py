import sys

for linea in sys.stdin:
    claves = linea.split()
    for palabra in claves:
        print(palabra, "1")
