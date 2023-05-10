import sys

for line in sys.stdin:
	keys = line.split()
	for palabra in keys:
		print(palabra, '\t', "1")
