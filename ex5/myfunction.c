//Shira Taitelbaum 322207341
#include "stdlib.h"

#define min(a, b) (a < b ? a : b)
#define max(a, b) (a > b ? a : b)
#define multby9(x) (((x)<<3) + (x))
#define multbyminus1(x) ((x)*(-1))
#define calcIndex(x, y, z) ((x*y) + z)
#define nm   m*n
#define size (nm+nm+nm)
#define mMins2 (m - 2)
#define nMins2 (n - 2)
typedef struct {
    unsigned char red;
    unsigned char green;
    unsigned char blue;
} pixel;


void Blur_image(Image *image) {
    pixel *pixelsImg = malloc(size);
    pixel *charsImg = (pixel *) image->data;
    //copy charsImg to pixel pixelsImg
    memcpy(pixelsImg, charsImg, size);
    int i, j, sumRed, sumGreen, sumBlue;
    int firstPlace = 0;
    pixel current_pixel, *p1, *p2, *p3, *p4, *p5, *p6, *p7, *p8, *p9;
    for (i = 1; i <= mMins2; i++) {
        p1 = &pixelsImg[firstPlace];
        p2 = p1 + 1;
        p3 = p1 + 2;
        p4 = p1 + n;
        p5 = p4 + 1;
        p6 = p4 + 2;
        p7 = p4 + n;
        p8 = p7 + 1;
        p9 = p7 + 2;
        for (j = 1; j <= nMins2; j++) {
            //sum of the pixel and divide by kernel's weight
            sumRed = (p1->red + p2->red + p3->red + p4->red + p5->red + p6->red + p7->red +
                      p8->red + p9->red) / 9;
            sumGreen = (p1->green + p2->green + p3->green + p4->green + p5->green + p6->green +
                        p7->green + p8->green + p9->green) / 9;
            sumBlue = (p1->blue + p2->blue + p3->blue + p4->blue + p5->blue + p6->blue +
                       p7->blue + p8->blue + p9->blue) / 9;
            //truncate each pixel's color values to match the range [0,255]
            current_pixel.red = (unsigned char) (min(max(sumRed, 0), 255));
            current_pixel.green = (unsigned char) (min(max(sumGreen, 0), 255));
            current_pixel.blue = (unsigned char) (min(max(sumBlue, 0), 255));
            charsImg[calcIndex(i, n, j)] = current_pixel;
            //move to the next pixel
            p1 = p2;
            p2 = p3;
            ++p3;
            p4 = p5;
            p5 = p6;
            ++p6;
            p7 = p8;
            p8 = p9;
            ++p9;
        }
        firstPlace += n;
    }
    free(pixelsImg);
}

void sharpen_image(Image *image) {
    pixel *pixelsImg = malloc(size);
    pixel *charsImg = (pixel *) image->data;
    //copy charsImg to pixel pixelsImg
    memcpy(pixelsImg, charsImg, size);
    int i, j, sumRed, sumGreen, sumBlue;
    int firstPlace = 0;
    pixel current_pixel, *p1, *p2, *p3, *p4, *p5, *p6, *p7, *p8, *p9;
    for (i = 1; i <= mMins2; i++) {
        //the first 9 pixel
        p1 = &pixelsImg[firstPlace];
        p2 = p1 + 1;
        p3 = p1 + 2;
        p4 = p1 + n;
        p5 = p4 + 1;
        p6 = p4 + 2;
        p7 = p4 + n;
        p8 = p7 + 1;
        p9 = p7 + 2;
        for (j = 1; j <= nMins2; j++) {
            //sum of the pixel
            sumRed = multby9(p5->red) + multbyminus1(
                    p1->red + p2->red + p3->red + p4->red + p6->red + p7->red + p8->red + p9->red);
            sumGreen = multby9(p5->green) + multbyminus1(
                    p1->green + p2->green + p3->green + p4->green + p6->green + p7->green + p8->green + p9->green);
            sumBlue = multby9(p5->blue) + multbyminus1(
                    p1->blue + p2->blue + p3->blue + p4->blue + p6->blue + p7->blue + p8->blue + p9->blue);

            //truncate each pixel's color values to match the range [0,255]
            current_pixel.red = (unsigned char) (min(max(sumRed, 0), 255));
            current_pixel.green = (unsigned char) (min(max(sumGreen, 0), 255));
            current_pixel.blue = (unsigned char) (min(max(sumBlue, 0), 255));
            charsImg[calcIndex(i, n, j)] = current_pixel;
            //move to next pixel
            p1 = p2;
            p2 = p3;
            ++p3;
            p4 = p5;
            p5 = p6;
            ++p6;
            p7 = p8;
            p8 = p9;
            ++p9;
        }
        firstPlace += n;
    }
    free(pixelsImg);
}

void blur_and_filter(Image *image) {
    pixel *pixelsImg = malloc(size);
    pixel *charsImg = (pixel *) image->data;
    //copy charsImg to pixel pixelsImg
    memcpy(pixelsImg, charsImg, size);
    int i, j, min_intensity, max_intensity, sum, sumRed, sumGreen, sumBlue;
    int firstPlace = 0;
    pixel current_pixel, *p1, *p2, *p3, *p4, *p5, *p6, *p7, *p8, *p9, *min_pixel, *max_pixel;
    for (i = 1; i <= mMins2; i++) {
        p1 = &pixelsImg[firstPlace];
        p2 = p1 + 1;
        p3 = p1 + 2;
        p4 = p1 + n;
        p5 = p4 + 1;
        p6 = p4 + 2;
        p7 = p4 + n;
        p8 = p7 + 1;
        p9 = p7 + 2;
        for (j = 1; j <= nMins2; j++) {
            //\min and max pixel
            sum = p1->red + p1->green + p1->blue;
            min_intensity = sum;
            max_intensity = sum;
            min_pixel = p1;
            max_pixel = p1;

            sum = p2->red + p2->green + p2->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p2;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p2;
            }

            sum = p3->red + p3->green + p3->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p3;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p3;
            }

            sum = p4->red + p4->green + p4->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p4;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p4;
            }

            sum = p5->red + p5->green + p5->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p5;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p5;
            }

            sum = p6->red + p6->green + p6->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p6;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p6;
            }

            sum = p7->red + p7->green + p7->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p7;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p7;
            }

            sum = p8->red + p8->green + p8->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p8;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p8;
            }

            sum = p9->red + p9->green + p9->blue;
            if (sum <= min_intensity) {
                min_intensity = sum;
                min_pixel = p9;
            } else if (sum > max_intensity) {
                max_intensity = sum;
                max_pixel = p9;
            }

            //sum of the pixel and divide by kernel's weight
            sumRed = (p1->red + p2->red + p3->red + p4->red + p5->red + p6->red + p7->red + p8->red + p9->red
                      - min_pixel->red - max_pixel->red) / 7;
            sumGreen = (p1->green + p2->green + p3->green + p4->green +
                        p5->green + p6->green + p7->green + p8->green + p9->green -
                        min_pixel->green - max_pixel->green) / 7;
            sumBlue = (p1->blue + p2->blue + p3->blue + p4->blue +
                       p5->blue + p6->blue + p7->blue + p8->blue + p9->blue - min_pixel->blue -
                       max_pixel->blue) / 7;

            //truncate each pixel's color values to match the range [0,255]
            current_pixel.red = (unsigned char) (min(max(sumRed, 0), 255));
            current_pixel.green = (unsigned char) (min(max(sumGreen, 0), 255));
            current_pixel.blue = (unsigned char) (min(max(sumBlue, 0), 255));
            charsImg[calcIndex(i, n, j)] = current_pixel;
            //move to next pixel
            p1 = p2;
            p2 = p3;
            ++p3;
            p4 = p5;
            p5 = p6;
            ++p6;
            p7 = p8;
            p8 = p9;
            ++p9;
        }
        firstPlace += n;
    }
    free(pixelsImg);
}


void myfunction(Image *image, char *srcImgpName, char *blurRsltImgName, char *sharpRsltImgName,
                char *filteredBlurRsltImgName, char *filteredSharpRsltImgName, char flag) {

    if (flag == '1') {
        //blur image
        Blur_image(image);

        //write result image to file
        writeBMP(image, srcImgpName, blurRsltImgName);

        //sharpen the resulting image
        sharpen_image(image);

        //write result image to file
        writeBMP(image, srcImgpName, sharpRsltImgName);
    } else {
        //apply extermum filtered kernel to blur image
        blur_and_filter(image);

        //write result image to file
        writeBMP(image, srcImgpName, filteredBlurRsltImgName);

        //sharpen the resulting image
        sharpen_image(image);

        //write result image to file
        writeBMP(image, srcImgpName, filteredSharpRsltImgName);
    }
}