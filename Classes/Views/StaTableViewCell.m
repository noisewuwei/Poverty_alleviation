//
//  StaTableViewCell.m
//  Poverty alleviation
//
//  Created by 中科禹贡 on 2018/3/28.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "StaTableViewCell.h"

@implementation StaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorHexString:@"f3f8f7"];
        
        NSArray *arr = @[@"count_times",@"count_Location2",@"count_dynamic"];
        NSArray *arr1 = @[@"打卡时间:",@"定位地点:",@"帮扶动态:"];
        
        for (int i=0; i<3; i++) {
            UIImageView *littleImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10+20*i, 10, 10)];
            littleImg.contentMode = UIViewContentModeCenter;
            littleImg.image = [UIImage imageNamed:arr[i]];
            [self addSubview:littleImg];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20+10+5, 7.5+19.5*i, 80, 15)];
            label.textColor = [UIColor colorHexString:@"888888"];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:14];
            label.text = arr1[i];
            [self addSubview:label];
        }
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(20+10+80, 7.5, zScreenWidth-20-115, 15)];
        _timeLab.textColor = [UIColor blackColor];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLab];
        
        _addLab = [[UILabel alloc]initWithFrame:CGRectMake(20+10+80, 7.5+19.5, zScreenWidth-20-115, 15)];
        _addLab.textColor = [UIColor blackColor];
        _addLab.textAlignment = NSTextAlignmentLeft;
        _addLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_addLab];
        
        _conLab = [[UILabel alloc]initWithFrame:CGRectMake(20+10+80, 7.5+19.5*2-4, zScreenWidth-20-115, 50)];
        _conLab.numberOfLines = 0;
        _conLab.textColor = [UIColor blackColor];
        _conLab.textAlignment = NSTextAlignmentLeft;
        _conLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [self addSubview:_conLab];
        
//        for (int i=0; i<4; i++) {
//            _image = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*i+10*i, 100, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
//            _image.tag = i;
//            _image.layer.masksToBounds = YES;
//            _image.layer.cornerRadius = 4;
//            _image.backgroundColor = [UIColor blackColor];
//            [self addSubview:_image];
//        }
        
        _image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*0+10*0, 90, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
        _image1.layer.masksToBounds = YES;
        _image1.layer.cornerRadius = 4;
        _image1.backgroundColor = [UIColor clearColor];
        [self addSubview:_image1];
        
        _image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*1+10*1, 90, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
        _image2.layer.masksToBounds = YES;
        _image2.layer.cornerRadius = 4;
        _image2.backgroundColor = [UIColor clearColor];
        [self addSubview:_image2];
        
        _image3 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*2+10*2, 90, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
        _image3.layer.masksToBounds = YES;
        _image3.layer.cornerRadius = 4;
        _image3.backgroundColor = [UIColor clearColor];
        [self addSubview:_image3];
        
        _image4 = [[UIImageView alloc]initWithFrame:CGRectMake(10+(zScreenWidth-50)/4*3+10*3, 90, (zScreenWidth-50)/4, (zScreenWidth-50)/4)];
        _image4.layer.masksToBounds = YES;
        _image4.layer.cornerRadius = 4;
        _image4.backgroundColor = [UIColor clearColor];
        [self addSubview:_image4];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 192, zScreenWidth, 1)];
        line.backgroundColor = [UIColor colorHexString:@"e1e1e1"];
        [self addSubview:line];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
