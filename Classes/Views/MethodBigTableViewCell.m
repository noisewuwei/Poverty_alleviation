//
//  MethodBigTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MethodBigTableViewCell.h"

@implementation MethodBigTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10, 0, zScreenWidth-20, 180)];
        back.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 4;
        [self addSubview:back];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, 20, 150, 15)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLab];
        
        _contentLab = [[UILabel alloc]initWithFrame:CGRectMake(17, 35, zScreenWidth-34, 150)];
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor blackColor];
        _contentLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [self addSubview:_contentLab];
        
//        _line = [[UIView alloc]initWithFrame:CGRectMake(17, 190, zScreenWidth-34, 1)];
//        _line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
//        [self addSubview:_line];
        
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(17, 200-10, 15, 15)];
        _img.contentMode = UIViewContentModeCenter;
        _img.image = [UIImage imageNamed:@"assist_icon5"];
        [self addSubview:_img];
        
        _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(17, 200+15+10-10, 15, 15)];
        _img1.contentMode = UIViewContentModeCenter;
        _img1.image = [UIImage imageNamed:@"assist_icon6"];
        [self addSubview:_img1];
        
        _peolab = [[UILabel alloc]initWithFrame:CGRectMake(50, _img.frame.origin.y, zScreenWidth-50-17, 15)];
        _peolab.textAlignment = NSTextAlignmentRight;
        _peolab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_peolab];
        
        _pholab = [[UILabel alloc]initWithFrame:CGRectMake(50, _img1.frame.origin.y, zScreenWidth-50-17, 15)];
        _pholab.textAlignment = NSTextAlignmentRight;
        _pholab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pholab];
        
        _callbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, _img1.frame.origin.y-2.5, zScreenWidth-50-17, 20)];
//        _callbtn.backgroundColor = [UIColor blackColor];
        [self addSubview:_callbtn];
        
//        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(17, 249, zScreenWidth-34, 1)];
//        lineview.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
//        [self addSubview:lineview];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
