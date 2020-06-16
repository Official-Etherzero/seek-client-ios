//
//  PersonalHeader.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "PersonalHeader.h"
#import "YYViewHeader.h"

@interface PersonalHeader ()

@property(nonatomic, strong, readwrite) UILabel *titleView;

@end

@implementation PersonalHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_ffffff;
        self.titleView = ({
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectZero];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.font = FONT_DESIGN_36;
            lbl.textColor = COLOR_1a1a1a;
            lbl;
        });
        [self addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(YYSIZE_22);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}

- (void)setModel:(SettingHeaderModel *)model {
    _model = model;
    self.titleView.text = model.title;
}

+ (NSString *)identifier {
    return @"PersonalHeader";
}

+ (CGFloat)height {
    return YYSIZE_64;
//    return 44;
}



@end
