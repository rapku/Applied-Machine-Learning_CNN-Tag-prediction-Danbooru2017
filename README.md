# Applied-Machine-Learning_CNN-Tag-prediction-Danbooru2017

Dataset: [Danbooru2017](https://www.gwern.net/Danbooru2018), a large collection of anime illustrations from varying artists hosted on Image Booru platforms. A subset from the SFW dataset was used due to consistent sizing of images (512x512 px), the safe-for-work nature of the images chosen, as well as constraints in acquiring the complete Danbooru2017 dataset of 1.9 TB.

Aim: Imagebooru sites allow users to place relevant, and sometimes very specific, tags for pictures (Ex. Tags such as '1girl' or 'eyebrows_visible_through_hair' for an image). Using a convolutional neural network trained on anime illustrations, and their respective community-provided tags, the project aims to get the CNN to predict if an image contains the following tags:
* 1girl
* long_hair
* blush
* smile
* short_hair

### Training dataset: 
1,500 images for each individual tag (Only includes 1 tag of the 5), 2,000 images with 2 or more of the 5 selected tags, and 500 images with 0/5 tags chosen as negative examples

### Model: 
Convolutional neural network - both sigmoid and ReLu were used in the last layer. Predictions were based on maximizing Matthews Correlation coefficient or using the average of predicted values as the cutoff.

### Results:
* Sigmoid-based CNN performed better in predicting tag combinations in an image
* short_hair and long_hair: CNN sometimes misidentifies long bands of color as hair (ex. scarves)
* CNN seems to be detecting the additional padding added in some images to standardize image sizes
* Due to crowdsourced nature of tagging, some errors in predictions were due to the tag not being added to the image despite clear presence. Namely, some images with characters smiling did not have the 'smile' tag in the metadata provided in the dataset, while the CNN correctly predicts the 'smile' tag for the image.
