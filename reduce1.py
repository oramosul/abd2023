import sys

palabra = None
cnt = 1

for linea in sys.stdin:
    palabra_nueva, contador = linea.split(' ')
    if (palabra_nueva == palabra):
        cnt += 1
    else:
        if (palabra != None):
            print(palabra, cnt)
        cnt = 1
        palabra = palabra_nueva
