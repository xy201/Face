//
//  ViewController.m
//  Face
//
//  Created by xuyou on 2016/12/6.
//  Copyright © 2016年 xuyou. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}
@property (weak, nonatomic) IBOutlet UIImageView *upImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePickerController = [[UIImagePickerController alloc]init];
    //4 设置代理
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
}



- (IBAction)upButton:(UIButton *)sender {

//    [self selectImageFromCamera];
    [self selectImageFromAlbum];
//    if([s])
}

#pragma mark-- 调用相册 相机 上传照片

- (void)selectImageFromCamera{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型(拍照、录像...)字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    //视频上传质量
    /*
     UIImagePickerControllerQualityTypeHigh = 0,       // highest quality
     UIImagePickerControllerQualityTypeMedium = 1,     // medium quality, suitable for transmission via Wi-Fi
     UIImagePickerControllerQualityTypeLow = 2,         // lowest quality, suitable for tranmission via cellular network
     UIImagePickerControllerQualityType640x480 NS_ENUM_AVAILABLE_IOS(4_0) = 3,    // VGA quality
     UIImagePickerControllerQualityTypeIFrame1280x720 NS_ENUM_AVAILABLE_IOS(5_0) = 4,
     UIImagePickerControllerQualityTypeIFrame960x540 NS_ENUM_AVAILABLE_IOS(5_0) = 5,
     */
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //设置摄像头模式（拍照，录制视频） 为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum{
    NSLog(@"相册");
    //3
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //5
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选择图片时
//废弃了
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);

}
#pragma mark --<UIImagePickerControllerDelegate>
//获取图片后的操作
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"info: %@",info);
    
//    self.upImageView.image = info[UIImagePickerControllerEditedImage];
    //销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //设置图片
    self.upImageView.image = info[UIImagePickerControllerOriginalImage];
    /*
     NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        self.upImageView.image = info[UIImagePickerControllerEditedImage];
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(self.upImageView.image, 1.0);
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(self.upImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
        //上传图片
        [self uploadImageWithData:fileData];
    }else {
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        //播放视频
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
        [self presentViewController:moviePlayer animated:YES completion:^{
            [moviePlayer.moviePlayer play];
        }];
        //播放
        [moviePlayer.moviePlayer play];
    }
     */
}

#pragma mark 图片保存完毕的回调
- (void) image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"112");
}
- (void) uploadImageWithData:(NSData *)data{
    NSLog(@"115");
}


//
#pragma mark - 相册文件选取相关
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
