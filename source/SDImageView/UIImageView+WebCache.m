/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

@implementation UIImageView (WebCache)


- (void)setImageWithURL:(NSURL *)url
{
    NSString *down=[[NSUserDefaults standardUserDefaults]stringForKey:@"down"];
    if (!app.isEnableWifi) {
        if ([down boolValue]!=YES) {
            self.image=[UIImage imageNamed:@"infoDefault_bg.png"];
            self.contentMode=UIViewContentModeScaleToFill;
            return;
        }
    }
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    NSString *down=[[NSUserDefaults standardUserDefaults]stringForKey:@"down"];
    if (!app.isEnableWifi) {
        if ([down boolValue]!=YES) {
            self.image=[UIImage imageNamed:@"infoDefault_bg.png"];
            self.contentMode=UIViewContentModeScaleToFill;
            return;
        }
    }
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder isGood:(BOOL)isGood{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}


- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    /*
    NSString *down=[[NSUserDefaults standardUserDefaults]stringForKey:@"down"];
    if (!app.isEnableWifi) {
        if ([down boolValue]!=YES) {
            self.image=[UIImage imageNamed:@"infoDefault_bg.png"];
            self.contentMode=UIViewContentModeScaleToFill;
            return;
        }
        return;
    }
     */
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
}

@end
