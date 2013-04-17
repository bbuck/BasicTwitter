@implementation UIColor (ColorExtensions)

+ (UIColor*)paleYellow
{
    static UIColor* paleYellowColor = nil;
    if (!paleYellowColor)
        paleYellowColor = [UIColor colorWithRed:(230 / 255.0) green:(230 / 255.0) blue:(184 / 255.0) alpha:1];
    return paleYellowColor;
}

+ (UIColor*)paleYellowDarker
{
    static UIColor* paleYellowDarkerColor = nil;
    if (!paleYellowDarkerColor)
        paleYellowDarkerColor = [UIColor colorWithRed:(179 / 255.0) green:(179 / 255.0) blue:(143 / 255.0) alpha:1];
    return paleYellowDarkerColor;
}

@end