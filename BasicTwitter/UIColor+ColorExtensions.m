@implementation UIColor (ColorExtensions)

+ (UIColor*)paleYellow
{
    static UIColor* paleYellowColor = nil;
    if (!paleYellowColor)
        paleYellowColor = [UIColor colorWithRed:(230 / 255.0) green:(230 / 255.0) blue:(184 / 255.0) alpha:1];
    return paleYellowColor;
}

@end