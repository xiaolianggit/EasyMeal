//
//  folderPath.m
//  EasyMeal
//
//  Created by Liang Xiao on 06/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "folderPath.h"


@implementation folderPath
+ (NSString*) restPicturePath{
	return [NSHomeDirectory() stringByAppendingPathComponent:@"restPicture"];
}

+ (NSString*) menuItemPicPath{
	return [NSHomeDirectory() stringByAppendingPathComponent:@"menuItemPic"];
}

+(NSString*) offlineDataPath{
	return [NSHomeDirectory() stringByAppendingPathComponent:@"offlineData"];
}
@end
