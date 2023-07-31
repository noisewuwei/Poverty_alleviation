//
//  RequireTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/4/24.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "RequireTableViewCell.h"

@implementation RequireTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorHexString:@"EFEFEF"];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 100, 15)];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [self addSubview:_title];
        
        _status = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-16-100, 10, 100, 15)];
        _status.textAlignment = NSTextAlignmentRight;
        _status.textColor = [UIColor colorHexString:@"f84b2f"];
        _status.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [self addSubview:_status];
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(16, 10+15+10, zScreenWidth-32, 114-35)];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 4;
        back.backgroundColor = [UIColor whiteColor];
        [self addSubview:back];
        
        _content = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, zScreenWidth-32-30-20, 60)];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.textColor = [UIColor colorHexString:@"888888"];
        _content.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        _content.numberOfLines = 0;
        [back addSubview:_content];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-32-20, 32.5, 15, 15)];
        image.contentMode = UIViewContentModeCenter;
        image.image = [UIImage imageNamed:@"btn_more"];
        [back addSubview:image];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
