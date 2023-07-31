//
//  FamilyMemberTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/14.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FamilyMemberTableViewCell.h"

@implementation FamilyMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 7, (zScreenWidth-26)/4, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4-15, 7, (zScreenWidth-26)/4-50+15, 30)];
        _sexLabel.font = [UIFont systemFontOfSize:12];
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*2-50, 7, (zScreenWidth-26)/4+50+50, 30)];
        _numLabel.font = [UIFont systemFontOfSize:12];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _relaLabel = [[UILabel alloc]initWithFrame:CGRectMake(13+(zScreenWidth-26)/4*3+50-10,7, (zScreenWidth-26)/4-50+10, 30)];
        _relaLabel.font = [UIFont systemFontOfSize:12];
        
        _relaLabel.textAlignment = NSTextAlignmentRight;

        
        [self addSubview:_nameLabel];
        [self addSubview:_sexLabel];
        [self addSubview:_numLabel];
        [self addSubview:_relaLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
