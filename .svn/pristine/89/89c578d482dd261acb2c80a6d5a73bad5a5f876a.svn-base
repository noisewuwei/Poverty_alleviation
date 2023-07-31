//
//  TrueMessTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/29.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "TrueMessTableViewCell.h"

@implementation TrueMessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        
        _firsttimeLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-55, 11, 110, 20)];
        _firsttimeLab.layer.masksToBounds = YES;
        _firsttimeLab.layer.cornerRadius = 2;
        _firsttimeLab.textAlignment = NSTextAlignmentCenter;
        _firsttimeLab.textColor = [UIColor whiteColor];
        _firsttimeLab.font = [UIFont systemFontOfSize:10];
        _firsttimeLab.backgroundColor = [UIColor colorHexString:@"cccccc"];
        [self addSubview:_firsttimeLab];
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(14, 44, zScreenWidth-28, 185)];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 4;
        [self addSubview:backview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 21, 200, 15)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"扶贫干部下乡帮扶计划表";
        [backview addSubview:label];
        
        _secondtimeLab = [[UILabel alloc]initWithFrame:CGRectMake(16, label.frame.origin.y+15+9, 200, 15)];
        _secondtimeLab.textAlignment = NSTextAlignmentLeft;
        _secondtimeLab.textColor = [UIColor colorHexString:@"a6a6a6"];
        _secondtimeLab.font = [UIFont systemFontOfSize:12];
        [backview addSubview:_secondtimeLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(16, _secondtimeLab.frame.origin.y+15+10, zScreenWidth-16*2-14*2, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        [backview addSubview:line];
        
        _contentLab = [[UILabel alloc]initWithFrame:CGRectMake(16, line.frame.origin.y+1+15, zScreenWidth-16*2-14*2, 50)];
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = [UIColor colorHexString:@"888888"];
        _contentLab.font = [UIFont systemFontOfSize:14];
        [backview addSubview:_contentLab];
        
        
        _Btn = [[UIButton alloc] initWithFrame:CGRectMake(backview.frame.size.width/2-36, _contentLab.frame.origin.y+50+10, 72, 28)];
        _Btn.layer.masksToBounds = YES;
        _Btn.layer.cornerRadius = 4;
        [_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backview addSubview:_Btn];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
