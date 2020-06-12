import struct
def float_to_hex(f):
    return format(struct.unpack('<I', struct.pack('<f', f))[0], 'x')

def convert_file(fname):
    with open(fname + ".txt") as f:
        lines = f.read().splitlines()
        #https://stackoverflow.com/questions/35024779/python-reading-integers-from-a-file
        #https://stackoverflow.com/questions/23624212/how-to-convert-a-float-into-hex/23624284#23624284
        #https://stackoverflow.com/questions/16414559/how-to-use-hex-without-0x-in-python/16414603
        #https://www.geeksforgeeks.org/print-lists-in-python-4-different-ways/
        #https://stackoverflow.com/questions/36571560/directing-print-output-to-a-txt-file-in-python-3
        print (*[float_to_hex(float(i)) for i in lines], sep='\n', file=open(fname+"_converted.txt", "w"))
path = "D:/Logic 2/assignment 2/Logic 2 ANN Assignment Help Material -20200413T094012Z-001/Logic 2 ANN Assignment Help Material/Weight Files/"
convert_file(path+"weights1")
convert_file(path+"weights2")
convert_file(path+"weights3")