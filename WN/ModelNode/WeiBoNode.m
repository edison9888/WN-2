//
//  WeiBoNode.m
//  WN
//
//  Created by 王尧 on 13-2-23.
//  Copyright (c) 2013年 BuildRun. All rights reserved.
//

#import "WeiBoNode.h"

@implementation WeiBoNode

- (void)dealloc
{
    self.createDate = nil;
    self.thumbImageUrl = nil;
    self.shareText = nil;
    self.source = nil;
    self.screen_name = nil;
    
    self.iconImageUrl = nil;
    self.reTweetWweiBoNode = nil;
    
    [super dealloc];
}

- (void)setSource:(NSString *)source
{
    NSArray *array = [source componentsSeparatedByString:@"</"];
    if (array.count == 2) {
        NSString *textLast = [array objectAtIndex:0];
        NSRange range = [textLast rangeOfString:@">"];
        NSString *sourceContent = [textLast substringFromIndex:range.location+1];
        if (_source && _source != source) {
            [_source release];
            _source = nil;
        }
        _source = [sourceContent retain];
    }
}


- (NSDate *)dateFromString:(NSString *)string {
    
    //Wed Mar 14 16:40:08 +0800 2012
    
    if (!string) return nil;
    struct tm tm;
    
    time_t t;
    
    string=[string substringFromIndex:4];
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%b %d %H:%M:%S %z %Y", &tm);
    
    tm.tm_isdst = -1;
    
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t];
    
}


- (void)setCreateDate:(NSString *)createDate
{
    NSDate *date = [self dateFromString:createDate];
    
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];    
    NSString * s = [dateFormatter stringFromDate:date];
    
    if (_createDate && _createDate != s) {
        [_createDate release];
        _createDate = nil;
    }
    
    _createDate = [s retain];
}



@end
