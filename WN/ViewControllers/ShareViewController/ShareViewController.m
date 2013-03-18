//
//  ShareViewController.m
//  WN
//
//  Created by 王尧 on 13-2-20.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
{
    NSInteger lengthSina;   //新浪文本长度
}
@property (nonatomic, retain) FHShareManager *currentShareManager;

@property (nonatomic, retain) NSString *shareText;
@property (nonatomic, retain) NSString *shareImageUrl;
@property (nonatomic, retain) UIImage  *shareImage;

@end

@implementation ShareViewController

- (void)dealloc
{
    self.titleLabel = nil;
    self.shareImageView = nil;
    self.textInfoLabel = nil;
    self.textView = nil;
    self.currentShareManager = nil;
    
    self.shareText = nil;
    self.shareImageUrl = nil;
    self.shareImage = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.textView setDelegate:self];
}


/**
 ** @Desc   TODO:分享按钮
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)shareAction:(id)sender
{
    if (self.shareImage) {
        [self.shareButton setEnabled:NO];
        [self.currentShareManager shareMessage:self.shareText Image:self.shareImage];
    }
    
    if (self.shareImageUrl) {
        [self.shareButton setEnabled:NO];
//        [self.currentShareManager shareMessage:self.shareText ImageUrl:self.shareImageUrl];
        UIImage * tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImageUrl]]];
        [self.currentShareManager shareMessage:self.shareText Image:tempImage];
    }
}

- (void)didLogin
{
    if (self.shareImage) {
        [self.currentShareManager shareMessage:self.shareText Image:self.shareImage];
    }
    
    if (self.shareImageUrl) {
//        [self.currentShareManager shareMessage:self.shareText ImageUrl:self.shareImageUrl];
        UIImage * tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImageUrl]]];
        [self.currentShareManager shareMessage:self.shareText Image:tempImage];
    }
}

- (void)loginFailed:(NSString *)errorMsg
{
    [self.shareButton setEnabled:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登陆失败，请确认用户名与密码是否正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

/**
 ** @Desc   TODO:返回按钮
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 ** @Desc   TODO:打开分享界面
 ** @author 王尧
 ** @param  N/A
 ** @return N/A
 ** @since
 */
- (void)openShareViewAction:(FHShareManager *)shareManager shareTextInfo:(NSString *)shareInfo shareImageUrl:(NSString *)imageUrl shareImage:(UIImage *)image
{
    self.currentShareManager = shareManager;
    
    self.currentShareManager.delegate = self;
    
    self.shareText = shareInfo;
    self.shareImageUrl = imageUrl;
    self.shareImage = image;
    
    switch (shareManager.type) {
        case SINAWEIBO:
        {
            [self.titleLabel setText:@"新浪微博"];
        }
            break;
        case TCWEIBO:
        {
            [self.titleLabel setText:@"腾讯微博"];            
        }
            break;
        default:
            break;
    }
    
    self.textView.text = self.shareText;
    [self getUsedTextCount:[self.textView text]];
    [self.textInfoLabel setText:[NSString stringWithFormat:@"你还可以输入%d个字符",130-lengthSina]];
    if (self.shareImage) {
        self.shareImageView.image = self.shareImage;
    }
    
    if (self.shareImageUrl) {
        [self.shareImageView setImageWithURL:[NSURL URLWithString:self.shareImageUrl] placeholderImage:nil];
    }
}


#pragma mark
#pragma mark =======FHShareManagerDelegate=======
/**   函数名称 :shareFailed
 **   函数作用 :TODO:分享失败
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareFailed:(NSString *)errorMsg
{
    [self.shareButton setEnabled:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

/**   函数名称 :shareSuccess
 **   函数作用 :TODO:分享成功
 **   函数参数 :
 **   函数返回值:
 **/
-(void)shareSuccess
{
    [self.shareButton setEnabled:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
//计算已使用的字数
-(void)getUsedTextCount:(NSString *)text{
    NSInteger lengthCN = 0;
    NSInteger lengthEG = 0;
    
    NSString *content = text;
    for(int i=0;i<[content length];i++){
        NSRange range;
        range.length = 1;
        range.location = i;
        NSString *str = [content substringWithRange:range];
        
        const char *c = [str UTF8String];
        if(strlen(c) == 3){
            //NSLog(@"汉字");
            lengthCN++;
        }else{
            //NSLog(@"字符");
            lengthEG++;
        }
        
    }
    
    lengthSina = 0;
    lengthSina = lengthCN + lengthEG/2 + lengthEG%2;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self getUsedTextCount:[textView text]];
    [self.textInfoLabel setText:[NSString stringWithFormat:@"你还可以输入%d个字符",130-lengthSina]];
}

@end
