import sys
import re

for linea in sys.stdin:
    claves = linea.split()
    for palabra in claves:
        salida = re.sub(r'[\W_]+', '', palabra.lower())
        print(salida, "1")
