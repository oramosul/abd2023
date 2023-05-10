import sys

palabra_actual = None
cnt = 1

for line in sys.stdin:
	palabra, contador = line.split('\t')
	if palabra == palabra_actual:
		cnt += 1
	else:
		if palabra_actual != None:
			print(palabra_actual, '\t', cnt)
		cnt = 1
		palabra_actual = palabra
