echo 'Copying files...'

cp `find pos -name "*.jpg" | head -n 5000` positive

echo 'Generating negative samples...'
python get_negative.py -i random -o negative -w 100 --height 100 -n 6000

echo 'Generating positive data description...'
python list_pos.py -w 28 --height 28 -n 5000
echo 'Generating negative data description...'
find negative -name '*.jpg' > negative.dat

echo 'Creating samples'
opencv_createsamples -info positive.dat -vec vector.vec -num 5000 -w 28 -h 28

echo 'Recreate data folder'
rm -rf data
mkdir data  # empty folder

# opencv_traincascade -data data -vec vector.vec -bg negative.dat -numPos 5000 -numNeg 3000 -w 28 -h 28 -numStages 7