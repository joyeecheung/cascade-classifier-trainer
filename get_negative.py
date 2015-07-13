# import pdb
# pdb.set_trace()

from PIL import Image
from glob import glob
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", type=str, default="random")
parser.add_argument("-o", "--output", type=str, default="negative")
parser.add_argument("-w", "--width", type=int)
parser.add_argument("--height", type=int)
parser.add_argument("-e", "--extension", type=str, default="jpg")
parser.add_argument("-n", "--number", type=int)

args = parser.parse_args()

print 'Trying to generate', args.number, 'negative samples'

def main():
    src_imgs = glob(args.input + "/*.jpg")
    src_imgs.extend(glob(args.input + "/*.png"))

    count = 0
    w, h = args.width, args.height
    for src in src_imgs:
        im = Image.open(src).convert('1', dither=Image.NONE)
        W, H = im.size

        if W < w or H < h:
            im.save("%s/%d.%s" % (args.output, count, args.extension))
            count += 1
            continue

        for i in xrange(0, W/w):
            if count > args.number:
                break
            for j in xrange(0, H/h):
                if count > args.number:
                    break
                slice = im.crop((i * w, j * h, (i+1) * w, (j+1) * h))
                slice.save("%s/%d.%s" % (args.output, count, args.extension))
                count += 1

        if count % (args.number / 10) == 0:
            print 'Finished', count, "samples...."

    print 'Done.', count, 'samples generated.'


if __name__ == '__main__':
    main()
