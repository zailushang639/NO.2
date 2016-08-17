

#import "TabButton.h"

@implementation TabButton
-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        self.titleLabel.font=[UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.22 green:0.64 blue:0.98 alpha:1] forState:UIControlStateSelected];
    }
    return self;
}

//重新设置按钮上的图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width-30)/2.0, 2, 30, 30);
}
//重新设置按钮上标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 32, contentRect.size.width, 15);
}

//设置按钮的图片
-(void)setImageWithBtn:(UIImage *)image{
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

@end

