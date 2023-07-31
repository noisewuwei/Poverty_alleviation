//
//  MethodFirstHeaderView.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MethodFirstHeaderView.h"
#import "JXButton.h"

@implementation MethodFirstHeaderView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
    
    
}

- (void)createSubviews{
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, 39, zScreenWidth, 250-39)];
    _backview.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backview];
    
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(17, 9.5, 200, 20)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor colorHexString:@"888888"];
    _label.font = [UIFont systemFontOfSize:16];
    _label.text = @"一对一帮扶指导";
    [self addSubview:_label];
    
    NSArray *arr = @[@"就业指导",@"教育",@"医疗",@"产业帮扶"];
    
    UIImage *image1 = [UIImage imageNamed:@"assist_icon1"];
    UIImage *image2 = [UIImage imageNamed:@"assist_icon2"];
    UIImage *image3 = [UIImage imageNamed:@"assist_icon3"];
    UIImage *image4 = [UIImage imageNamed:@"assist_icon4"];
    
    NSArray *arr1 = @[image1,image2,image3,image4];
    
    NSMutableArray *btnMutableArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<4; i++) {
        _Btn = [[JXButton alloc]initWithFrame:CGRectMake(20+(20+(zScreenWidth-100)/4)*i, 0, (zScreenWidth-100)/4, 72)];
        [_Btn setTitle:arr[i] forState:UIControlStateNormal];
        _Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Btn setTitleColor:[UIColor colorHexString:@"fdba44"] forState:UIControlStateSelected];
        [_Btn setImage:arr1[i] forState:UIControlStateNormal];
        [_Btn setImage:arr1[i] forState:UIControlStateSelected];
        _Btn.layer.borderColor= [[UIColor colorHexString:@"e1e1e1"]CGColor];
        
        _Btn.selected = NO;
        _Btn.tag = 100+i;
        
        
        [btnMutableArray addObject:_Btn];
        
        
        [self addSubview:_Btn];
    }
    
    ((UIButton *)[btnMutableArray objectAtIndex:0]).selected=YES;
    
    _headimg = [[UIImageView alloc] initWithFrame:CGRectMake(17, 73, zScreenWidth-34, 70)];
    _headimg.layer.masksToBounds = YES;
    _headimg.layer.cornerRadius = 4;
    _headimg.image = [UIImage imageNamed:@"assist_banner1"];
    [_backview addSubview:_headimg];
    
    _typelab = [[UILabel alloc]initWithFrame:CGRectMake(17, 73+70+10, 150, 20)];
    _typelab.textColor = [UIColor colorHexString:@"fdba44"];
    _typelab.textAlignment = NSTextAlignmentLeft;
    _typelab.font = [UIFont systemFontOfSize:15];
    [_backview addSubview:_typelab];
    
    _titlab = [[UILabel alloc]initWithFrame:CGRectMake(0, _typelab.frame.origin.y+20+10, zScreenWidth, 20)];
    _titlab.textColor = [UIColor blackColor];
    _titlab.textAlignment = NSTextAlignmentCenter;
    _titlab.font = [UIFont systemFontOfSize:13];
    [_backview addSubview:_titlab];
    
    _backview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 39)];
    _backview1.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
    _backview1.hidden = YES;
    [self addSubview:_backview1];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(17, 9.5, 200, 20)];
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.textColor = [UIColor colorHexString:@"888888"];
    _label1.font = [UIFont systemFontOfSize:16];
    _label1.text = @"帮扶对象基本情况介绍";
    _label1.hidden = YES;
    [self addSubview:_label1];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
