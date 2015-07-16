NUM_POS=300  # number of positive samples you have
NUM_NEG=500  # number of negative samples you want to generate
POS_WIDTH=28  # width of positive samples
POS_HEIGHT=28 # height of posotive samples
NEG_WIDTH=80  # width of generated negative samples
NEG_HEIGHT=80  # height of generated negative samples
NUM_STAGES=10  # number of stages for training
S=10 # skipped samples

# we do a simple formula here...
# for a detailed formula,
# see http://answers.opencv.org/question/4368/
let "POS=NUM_POS-S"

echo "Copying ${NUM_POS} files..."
cp `find pos -name "*.jpg" | head -n $NUM_POS` positive

echo "Generating ${NUM_NEG} negative samples..."
python get_negative.py -i random -o negative -w $NEG_WIDTH --height $NEG_HEIGHT -n $NUM_NEG

echo "Generating positive data description..."
python list_pos.py -w $POS_WIDTH --height $POS_HEIGHT -n $NUM_POS
echo "Generating negative data description..."
find negative -name '*.jpg' > negative.dat

echo "Creating samples"
opencv_createsamples -info positive.dat -vec vector.vec -num $NUM_POS -w $POS_WIDTH -h $POS_HEIGHT

echo "Recreate classifier folder"
rm -rf classifier
mkdir classifier  # empty folder

opencv_traincascade -data classifier -vec vector.vec -bg negative.dat -numPos $POS -numNeg $NUM_NEG -w $POS_WIDTH -h $POS_HEIGHT -numStages $NUM_STAGES