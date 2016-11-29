//
//  Filter.m
//  filter_improvise
//
//  Created by keyon on 2016/11/25.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "Filter.h"
#import <GPUImage/GPUImage.h>
@implementation Filter
//旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
//曝光
+ (GPUImageBrightnessFilter *)BrightnessFilterWith:(CGFloat)brightness
                                                      inSize:(CGSize)size
                                                   ifInitial:(BOOL)initial{
    GPUImageBrightnessFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageBrightnessFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.brightness = 0.5f;
    }else{
        passthroughFilter.brightness = brightness;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//对比度
+ (GPUImageContrastFilter *)ContrastFilterWith:(CGFloat)contrast
                                                  inSize:(CGSize)size
                                               ifInitial:(BOOL)initial{
    GPUImageContrastFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageContrastFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.contrast = -0.8f;
    }else{
        passthroughFilter.contrast = contrast;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//饱和度
+ (GPUImageSaturationFilter *)GPUImageSaturationFilterWith:(CGFloat)saturation
                                                    inSize:(CGSize)size
                                                 ifInitial:(BOOL)initial{
    GPUImageSaturationFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageSaturationFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.saturation = -1.0f;
    }else{
        passthroughFilter.saturation = saturation;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
    
}
//伽马线
+ (GPUImageGammaFilter *)GPUImageGammaFilterWith:(CGFloat)gamma
                                          inSize:(CGSize)size
                                       ifInitial:(BOOL)initial{
    GPUImageGammaFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageGammaFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.gamma = 1.0f;
    }else{
        passthroughFilter.gamma = gamma;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//反色
+ (GPUImageColorInvertFilter *)GPUImageColorInvertFilterWith:(CGSize)size
                                                   ifInitial:(BOOL)initial{
    GPUImageColorInvertFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageColorInvertFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
    }else{
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//怀旧
+ (GPUImageSepiaFilter *)GPUImageSepiaFilterWith:(CGFloat)intensity
                                          inSize:(CGSize)size
                                       ifInitial:(BOOL)initial{
    GPUImageSepiaFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageSepiaFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.intensity = 0.5f;
    }else{
        passthroughFilter.intensity = intensity;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//不透明度
+ (GPUImageOpacityFilter *)GPUImageOpacityFilterWith:(CGFloat)opacity
                                              inSize:(CGSize)size
                                           ifInitial:(BOOL)initial{
    GPUImageOpacityFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageOpacityFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.opacity = 0.5f;
    }else{
        passthroughFilter.opacity = opacity;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//提亮阴影
+ (GPUImageHighlightShadowFilter *)GPUImageHighlightShadowFilterWith:(CGFloat)shadows
                                                              inSize:(CGSize)size
                                                           ifInitial:(BOOL)initial{
    GPUImageHighlightShadowFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageHighlightShadowFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.shadows = 1.0f;
    }else{
        passthroughFilter.shadows = shadows;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//色度
+ (GPUImageHueFilter *)GPUImageHueFilterWith:(CGFloat)hue inSize:(CGSize)size ifInitial:(BOOL)initial{
    
    GPUImageHueFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageHueFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.hue = 100.0f;
    }else{
        passthroughFilter.hue = hue;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//像素色值亮度平均
+ (GPUImageAverageLuminanceThresholdFilter *)GPUImageAverageLuminanceThresholdFilterWith:(CGFloat)thresholdMultiplier inSize:(CGSize)size ifInitial:(BOOL)initial{
    GPUImageAverageLuminanceThresholdFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.thresholdMultiplier = - 100.0f;
    }else{
        passthroughFilter.thresholdMultiplier = thresholdMultiplier;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;
}
//十字
+ (GPUImageToonFilter *)GPUImageSketchFilterWith:(CGFloat)crosshairWidth inSize:(CGSize)size ifInitial:(BOOL)initial{
    GPUImageToonFilter * passthroughFilter;
    if (!passthroughFilter) {
        passthroughFilter = [[GPUImageToonFilter alloc] init];
    }
    //判断是否第一次加载用于渲染底部button背景图
    if (initial == YES) {
        passthroughFilter.threshold = 100.0f;
    }else{
        passthroughFilter.threshold = crosshairWidth;
    }
    //渲染区域
    [passthroughFilter forceProcessingAtSize:size];
    [passthroughFilter useNextFrameForImageCapture];
    return passthroughFilter;

}
+ (GPUImageFilter *)outputWith:(int)Active :(CGSize)size :(BOOL)initial :(CGFloat)parameter{
    GPUImageFilter * passthroughFilter;
    switch (Active) {
            //曝光
        case 0:
            passthroughFilter = [Filter BrightnessFilterWith:parameter inSize:size ifInitial:initial];
            break;
            //对比度
        case 1:
            passthroughFilter = [Filter ContrastFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 2:
            passthroughFilter = [Filter GPUImageSaturationFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 3:
            passthroughFilter = [Filter GPUImageGammaFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 4:
            passthroughFilter = [Filter GPUImageSepiaFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 5:
            passthroughFilter = [Filter GPUImageOpacityFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 6:
            passthroughFilter = [Filter GPUImageHighlightShadowFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 7:
            passthroughFilter = [Filter GPUImageHueFilterWith:parameter inSize:size ifInitial:initial];
            break;
        case 8:
            passthroughFilter = [Filter GPUImageSketchFilterWith:parameter inSize:size ifInitial:initial];
        default:
            break;
    }
    return passthroughFilter;
}
@end
