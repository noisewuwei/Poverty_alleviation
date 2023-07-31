//
//  PostRequireViewController.h
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/24.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CallBackBlcok) (NSString *text);

@interface PostRequireViewController : BaseViewController

@property (nonatomic,copy)CallBackBlcok callBackBlock;

@property (nonatomic,strong) NSString *familyNo;
@property (nonatomic,strong) NSString *holderName;

@end
