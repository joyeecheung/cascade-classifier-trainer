import struct
import numpy as np

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("input_file", type=str)

args = parser.parse_args()

with open(args.input_file, 'rb') as file:
    magic, size = struct.unpack(">II", file.read(8))
    if magic != 2049:
        raise ValueError('Magic number mismatch, expected 2049,' +
                         ' got %d' % magic)

    labels = np.fromfile(file, dtype=np.int8)
