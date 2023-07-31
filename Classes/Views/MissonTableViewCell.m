//
//  MissonTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MissonTableViewCell.h"

@implementation MissonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(15, 5, zScreenWidth-30, 149)];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 4;
        backview.backgroundColor = [UIColor whiteColor];
        [self addSubview:backview];
        
        UIImageView *littleImg = [[UIImageView alloc]initWithFrame:CGRectMake(17, 22, 15, 15)];
        littleImg.contentMode = UIViewContentModeCenter;
        littleImg.image = [UIImage imageNamed:@"task_icon2"];
        [backview addSubview:littleImg];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(littleImg.frame.origin.x+15+10, 22, 200, 15)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14];
        [backview addSubview:_titleLab];
        
        _rightLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-17-50-17, 22, 50, 15)];
        _rightLab.textColor = [UIColor colorHexString:@"f36f0b"];
        _rightLab.font = [UIFont systemFontOfSize:14];
        _rightLab.textAlignment = NSTextAlignmentRight;
        [backview addSubview:_rightLab];
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(littleImg.frame.origin.x+15+10, 22+15+5, 200, 15)];
        _timeLab.textColor = [UIColor colorHexString:@"a6a6a6"];
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        [backview addSubview:_timeLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(17, _timeLab.frame.origin.y+15+10, zScreenWidth-30-34, 1)];
        line.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        [backview addSubview:line];
        
        _conLab = [[UILabel alloc]initWithFrame:CGRectMake(17, line.frame.origin.y, line.frame.size.width, 60)];
        _conLab.textAlignment = NSTextAlignmentLeft;
        _conLab.textColor = [UIColor colorHexString:@"888888"];
        _conLab.numberOfLines = 0;
        _conLab.font = [UIFont systemFontOfSize:14];
        [backview addSubview:_conLab];
        
        _Img = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-17-60-17, _conLab.frame.origin.y+50, 60, 15)];
        
        _Img.image = [UIImage imageNamed:@"未标题-2"];

        _Img.contentMode = UIViewContentModeCenter;
        [backview addSubview:_Img];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
