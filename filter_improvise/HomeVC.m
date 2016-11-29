//
//  HomeVC.m
//  filter_improvise
//
//  Created by keyon on 2016/11/24.
//  Copyright © 2016年 keyon. All rights reserved.
//

#import "HomeVC.h"
#import "keyon.h"
#import "OperationVC.h"
#import "MiddleVC.h"
#import "ScrollControl.h"
#import <objc/runtime.h>
#import "Filter.h"
#import "HeaderBar.h"
#import "SliderView.h"
@interface HomeVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    MiddleVC *middle;
    NSMutableArray *btnAarr;
    SliderView *sliderBar;
    ScrollControl *scroll;
    UIImage *image_current;
    UIImage *original;
    UIImage *temp_image;
    NSInteger Active;
    NSMutableArray *value_arr_current;
    NSArray *value_arr_original;
    NSArray *deploy;
}
@end

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
    if (sliderBar != nil) {
        Active = 0;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //基元图片
    original = [UIImage new];
    image_current = [UIImage new];
    //初始化slider的value
    //
    deploy = [NSArray new];
    value_arr_original = [NSArray new];
    deploy = @[@[[NSString stringWithFormat:@"%d",-1],@1],//曝光
               @[[NSString stringWithFormat:@"%d",-1],@1],//对比度
               @[[NSString stringWithFormat:@"%d",-1],@1],//饱和度
               @[[NSString stringWithFormat:@"%d",0],@1],//伽马线
               @[[NSString stringWithFormat:@"%d",-1],@1],//怀旧
               @[[NSString stringWithFormat:@"%d",0],@1],//不透明度
               @[[NSString stringWithFormat:@"%d",0],@1],//提高阴影
               @[[NSString stringWithFormat:@"%d",-100],@100],//色度
               @[[NSString stringWithFormat:@"%d",0],@1],//十字
               ];
    //
    value_arr_original = @[@0,
                           @1,
                           @1,
                           @1,
                           @0,
                           @1,
                           @0,
                           @0,
                           @0];
    
    
    value_arr_current = [[NSMutableArray alloc] init];
    [value_arr_current addObjectsFromArray:value_arr_original];
    //
    btnAarr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = UIColorFromRGB(0x000000, 1);
    //header
    HeaderBar *header = [[HeaderBar alloc] initWithFrame:CGRectMake(0, 0, GWID, 64)];
    [header.leftButton addTarget:self action:@selector(selectImageFromAlbum) forControlEvents:UIControlEventTouchUpInside];
    [header.clockwise addTarget:self action:@selector(clockwise) forControlEvents:UIControlEventTouchUpInside];
    [header.anticlockwise addTarget:self action:@selector(anticlockwise) forControlEvents:UIControlEventTouchUpInside];
    [header.reast addTarget:self action:@selector(reast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];
    //middle
    middle = [[MiddleVC alloc] init];
    [self.view addSubview:middle.view];
    
    //
    [self scrollControl_to_show];
    //点击事件
    for (UIButton *btn in [scroll subviews]) {
        [btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)selectImageFromAlbum{
    [self getImageFromIpc];
}
- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.allowsEditing = YES;

    ipc.navigationBar.translucent = NO;
    ipc.navigationBar.barTintColor = UIColorFromRGB(0x000000, 1);
    ipc.navigationBar.tintColor = UIColorFromRGB(0xfd9426, 1);
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
    NSData *imageData;
    // 判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        // 返回为png图像。
        imageData = UIImagePNGRepresentation(image);
    }else {
        // 返回为JPEG图像
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    UIImage *image_new = [UIImage imageWithData:imageData];
    middle.imageView.image = image_new;
    image_current = image_new;
    original = image_new;
    middle.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self ReBackGround:image_new withArr:btnAarr];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [value_arr_current removeAllObjects];
    [value_arr_current addObjectsFromArray:value_arr_original];
    //btn添加背景
    [self startLoadData:YES];
}
- (void)touch :(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    if (middle.imageView.image == nil) {
        [KVController showMessage:@"请添加图片" btn:nil];
    }else{
        image_current = middle.imageView.image;
        Active = sender.tag;
        float value_current = [[value_arr_current objectAtIndex:sender.tag] floatValue];
        [self sliderControl_to_show];
        sliderBar.slider.value = value_current;
        [self.view addSubview:sliderBar];
    }
}
- (void)ReBackGround :(UIImage *)img withArr:(NSMutableArray *)arr{
    for (int i = 0; i < [arr count]; i ++) {
        [(UIButton *)[arr objectAtIndex:i] setBackgroundImage:img forState:UIControlStateNormal];
    }
}
- (void)valueChanged :(UISlider *)sender{
    NSLog(@"%lf",sender.value);
    if (middle.imageView.image != nil) {
         [self startLoadData:NO];
    }
}

//申明滤镜类型
- (GPUImageFilter *)getGPUImageFilter :(CGSize)size :(BOOL)initial :(CGFloat)parameter{
    GPUImageFilter * passthroughFilter;
    int act = [[NSString stringWithFormat:@"%ld",Active] intValue];
    passthroughFilter = [Filter outputWith:act :size :initial :parameter];
    return passthroughFilter;
}
- (void)startLoadData:(BOOL)initial{
    //获取数据源
    GPUImagePicture *stillImageSource;
    if (!stillImageSource) {
        stillImageSource = [[GPUImagePicture alloc]initWithImage:image_current];
    }
    CGSize size = middle.imageView.image.size;
    CGFloat parameter = sliderBar.slider.value;
    
    if (initial == YES) {
        for (int i = 0; i < [scroll.subviews count]; i ++) {
            if ([scroll.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)scroll.subviews[i];
                Active = btn.tag;
                GPUImageFilter * passthroughFilter =  [self getGPUImageFilter:size :YES :parameter];
                //添加滤镜
                [stillImageSource addTarget:passthroughFilter];
                //开始渲染
                [stillImageSource processImage];
                //获取渲染后的图片
                UIImage *newIMage = [passthroughFilter imageByFilteringImage:image_current];
                [btn setBackgroundImage:newIMage forState:UIControlStateNormal];
            }
        }
        Active = 0;
    }else{
        //申明滤镜类型
        GPUImageFilter * passthroughFilter =  [self getGPUImageFilter:size :NO :parameter];
        
        NSString *value_new = [NSString stringWithFormat:@"%f",sliderBar.slider.value];
        [value_arr_current setObject:value_new atIndexedSubscript:Active];
        //添加滤镜
        [stillImageSource addTarget:passthroughFilter];
        //开始渲染
        [stillImageSource processImage];
        //获取渲染后的图片
        UIImage *newIMage = [passthroughFilter imageByFilteringImage:image_current];
        //react
        initial == NO ? middle.imageView.image = newIMage : nil;
    }
}
//逆时针
- (void)anticlockwise{
    if (middle.imageView.image != nil) {
        UIImage *newImage = [Filter image:middle.imageView.image rotation:UIImageOrientationLeft];
        middle.imageView.image = newImage;
        //路由
        image_current = newImage;
    }else{
        [KVController showMessage:@"请添加图片" btn:nil];
    }
}
//顺时针
- (void)clockwise{
    if (middle.imageView.image != nil) {
        UIImage *newImage = [Filter image:middle.imageView.image rotation:UIImageOrientationRight];
        middle.imageView.image = newImage;
        //路由
        image_current = newImage;
    }else{
        [KVController showMessage:@"请添加图片" btn:nil];
    }
}
- (void)reast{
    if (middle.imageView.image == nil) {
        [KVController showMessage:@"请添加图片" btn:nil];
    }else{
        middle.imageView.image = original;
        image_current = original;
        [value_arr_current removeAllObjects];
        [value_arr_current addObjectsFromArray:value_arr_original];
        [sliderBar removeFromSuperview];
    }
}
- (void)sliderControl_to_show{
    if (!sliderBar) {
        sliderBar = [[SliderView alloc] initWithFrame:CGRectMake(0, GHIT - 60, GWID, 60)];
    }
    NSArray *arr_data = deploy[Active];
    sliderBar.slider.value = [value_arr_current[Active] floatValue];
    sliderBar.slider.minimumValue = [[NSString stringWithFormat:@"%@",arr_data[0]] floatValue];
    sliderBar.slider.maximumValue = [[NSString stringWithFormat:@"%@",arr_data[1]] floatValue];;

    [sliderBar.save addTarget:self action:@selector(save_temp) forControlEvents:UIControlEventTouchUpInside];
    [sliderBar.cancel addTarget:self action:@selector(sliderControl_to_hide) forControlEvents:UIControlEventTouchUpInside];
    [sliderBar.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sliderBar];
}
- (void)save_temp{
    image_current = middle.imageView.image;
    [self sliderControl_to_hide];
}
- (void)sliderControl_to_hide{
    middle.imageView.image = image_current;
    [sliderBar removeFromSuperview];
}
- (void)scrollControl_to_show{
    if (!scroll) {
        scroll = [[ScrollControl alloc] initWithFrame:CGRectMake(0, GHIT - 60, GWID, 60)];
    }
    [self.view addSubview:scroll];
}
- (void)scrollControl_to_hide{
    [scroll removeFromSuperview];
}
@end
