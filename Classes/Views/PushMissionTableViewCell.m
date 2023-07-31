//
//  PushMissionTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PushMissionTableViewCell.h"

@implementation PushMissionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, 15, 38, 38)];
        //        _headImg.contentMode = UIViewContentModeCenter;
        [self addSubview:_headImg];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(50+38+10, 15, 100, 15)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLab];
        
        _jobLab = [[UILabel alloc]initWithFrame:CGRectMake(50+38+10, 15+15+5, 200, 15)];
        _jobLab.textAlignment = NSTextAlignmentLeft;
        _jobLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_jobLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 67, zScreenWidth, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        [self addSubview:line];
        
        
        
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews)
            {
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (self.selected) {
                        image.image=[UIImage imageNamed:@"task_icon1"];
                    }
                    else
                    {
                        image.image=[UIImage imageNamed:@"task_icon1un"];
                    }
                }
            }
        }
    }
    
    [super layoutSubviews];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews)
            {
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (!self.selected) {
                        image.image=[UIImage imageNamed:@"task_icon1un"];
                    }
                }
            }
        }
    }
    
}


@end
