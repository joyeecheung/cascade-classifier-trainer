## Training OpenCV cascade classifier

### Directory structure

```
.
├─ pos (positive samples database containing .jpg images)
│   └── ...
├─ positive (selected positive samples)
│   └── ...
├─ random (random images to generate negative samples with)
│   └── ...
├─ negative (generated negative samples)
│   └── ...
├─ classifier (directory to hold trained classifiers)
│   └── ...
├─ list_pos.py (script to generate data for vec files )
├─ get_negative.py (script to generate negative samples)
└─ lish.sh (script to drive the whole process)
```

### How to use it

1. Create the directory structure above
2. Put your positive samples(should be images with a fixed size) in `pos`
3. Put some images that doesn't contain your detection target under `random` (the size doesn't matter, but they shouldn't be too big, otherwise you will get a bunch of monotone images, which are pretty useless as negative samples)
4. Configure variables in `list.sh`
5. Run `bash list.sh`

### A word about the size of the vec file

From [Traincascade Error: Bad argument](http://answers.opencv.org/question/4368/), the size of the vec file should be `N >= numPos + numPos * (1 - minHitRate) * (numStages - 1) + S`, where `S` is a count of all the skipped samples from vec-file (for all stages). Here we do a simpler formula, the number of positive samples supplied for `opencv_traincascade` is `POS=N-S`, and `N`(the size of the vec file) is just the number of all positive samples you have.