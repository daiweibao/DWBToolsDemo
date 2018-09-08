//
//  JXActionSheet.m
//  JXKit
//
//  Created by huangxiangwang on 16/1/18.
//  Copyright © 2016年 JX.Wang. All rights reserved.
//

#import "JXActionSheet.h"

const CGFloat KJX_MinButtonHeight = 50.;
const CGFloat KJX_Edges = 15.;
const CGFloat KJX_sectionHeight = 8.;
const CGFloat KJX_backgroundViewAlpha = 0.4;
NSString *const KJX_ItemIdentifier = @"KJX.Wang_Item";

//***************************** JXSheetModel ***********************************//

@interface JXSheetModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat height;

+ (instancetype)modelWithTitle:(NSString *)title font:(UIFont *)font;
- (void)updateHeightForFont:(UIFont *)font;

@end

@implementation JXSheetModel

+ (instancetype)modelWithTitle:(NSString *)title font:(UIFont *)font {
    JXSheetModel *model = [[JXSheetModel alloc] init];
    if (model) {
        model.title = title;
        model.height = [model heightForFont:font];
    }
    return model;
}

- (CGFloat)heightForFont:(UIFont *)font {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - KJX_Edges * 2, 0);
    CGRect rect = [self.title boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    NSInteger height = rect.size.height + KJX_Edges * 2;
    return  MAX(height, KJX_MinButtonHeight);
}

- (void)updateHeightForFont:(UIFont *)font {
    self.height = [self heightForFont:font];
}

@end

//***************************** JXSheetItem ***********************************//

@interface JXSheetItem : UITableViewCell

@end

@implementation JXSheetItem

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(KJX_Edges, 0, CGRectGetWidth(self.bounds) - KJX_Edges * 2, CGRectGetHeight(self.bounds));
    
    UIView *view = [self valueForKey:@"_separatorView"];
    if (view) {
        CGRect frame = view.frame;
        frame.origin.x = 0.;
        frame.size.width = CGRectGetWidth(self.bounds);
        view.frame = frame;
    }
}

@end

//***************************** JXActionSheet ***********************************//

@interface JXActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nullable, nonatomic, strong) JXSheetModel *titleModel;
@property (nullable, nonatomic, strong) JXSheetModel *cancelModel;
@property (nullable, nonatomic, copy) NSArray<JXSheetModel *> *otherModels;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, assign) BOOL tableViewShouldFixed;

@property (nonatomic, strong) UIView *backgroundView;

@property (nullable, nonatomic, copy) JXSheetCompletionHanlde completionHanlde;

@end

@implementation JXActionSheet

#pragma mark - life cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)otherTitles {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        self.cancelTitle = cancelTitle;
        self.otherTitles = otherTitles;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _destructiveButtonIndex = -1;
        _titleColor = [UIColor grayColor];
        _destructiveColor = [UIColor redColor];
        _otherTitlesColor = [UIColor blackColor];
        _titleFont = [UIFont systemFontOfSize:14.];
        _otherTitlesFont = [UIFont systemFontOfSize:18.];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationDidChangeNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

#pragma mark - public method

- (void)showView {
    self.tableViewHeight = [self tableHeight];
    UIWindow *statusBarWindow = [self statusBarWindow];
    [statusBarWindow addSubview:self];
    [self addSubview:self.backgroundView];
    [self addSubview:self.tableView];
    [self updateTableView];
    [self showViewAnimation];
}

- (void)dismissForCompletionHandle:(JXSheetCompletionHanlde)handle {
    self.completionHanlde = handle;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = (UITouch *)touches.anyObject;
    if (touch.view == self) {
        if (_completionHanlde) {
            self.completionHanlde(NSNotFound, YES);
        }
        [self dismissViewAnimation];
    }
}

#pragma mark - interface

- (void)reloadData {
    if (_titleModel) {
        [_titleModel updateHeightForFont:_titleFont];
    }
    if (_cancelModel) {
        [_cancelModel updateHeightForFont:_otherTitlesFont];
    }
    if (_otherTitles) {
        for (JXSheetModel *model in _otherModels) {
            if (model) {
                [model updateHeightForFont:_otherTitlesFont];
            }
        }
    }
    self.tableViewHeight = [self tableHeight];
}

- (void)updateTableView {
    self.tableView.scrollEnabled = !_tableViewShouldFixed;
    self.tableView.showsVerticalScrollIndicator = !_tableViewShouldFixed;
}

- (void)statusBarOrientationDidChangeNotification:(NSNotification *)sender {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundView.frame = self.bounds;
    
    [self reloadData];
    self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - _tableViewHeight-MC_TabbarSafeBottomMargin, CGRectGetWidth(self.bounds), _tableViewHeight);
    [self updateTableView];
}

- (UIWindow *)statusBarWindow {
    return [[UIApplication sharedApplication] valueForKey:@"_statusBarWindow"];
}

- (UIInterfaceOrientation)appInterface {
    return [UIApplication sharedApplication].statusBarOrientation;
}

#pragma mark - private method

- (void)showViewAnimation {
    __weak typeof(self) wSelf = self;
    [UIView animateWithDuration:[self animationDuration] animations:^{
        CGRect frame = _tableView.frame;
        frame.origin.y = CGRectGetHeight(wSelf.bounds) - frame.size.height-MC_TabbarSafeBottomMargin;
        wSelf.tableView.frame = frame;
        wSelf.backgroundView.alpha = KJX_backgroundViewAlpha;
    }];
}

- (void)dismissViewAnimation {
    __weak typeof(self) wSelf = self;
    [UIView animateWithDuration:[self animationDuration] animations:^{
        CGRect frame = _tableView.frame;
        frame.origin.y = CGRectGetHeight(wSelf.bounds)-MC_TabbarSafeBottomMargin;
        wSelf.tableView.frame = frame;
        wSelf.backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [wSelf removeFromSuperview];
        }
    }];
}

- (NSTimeInterval)animationDuration {
    NSTimeInterval time = 0.;
    if (UIInterfaceOrientationIsLandscape([self appInterface])) {
        time = _tableViewHeight / CGRectGetWidth(self.bounds);
    } else {
        time = _tableViewHeight / CGRectGetHeight(self.bounds);
    }
    time = (int)(time * 100) / 100.;
    time = fmax(time, 0.35);
    time = fmin(time, 0.5);
    return time;
}

- (CGFloat)tableHeight {
    CGFloat h = 0.;
    h += _titleModel.height;
    h += _cancelModel ? _cancelModel.height + KJX_sectionHeight : 0.;
    if (_otherModels.count) {
        for (JXSheetModel *model in _otherModels) {
            h += model.height;
        }
    }
    if ((NSInteger)h == 0) {
        self.cancelModel = [JXSheetModel modelWithTitle:@"" font:_otherTitlesFont];
        h = _cancelModel.height;
        return h;
    }
    if (h > CGRectGetHeight(self.bounds) - 44.) {
        h = CGRectGetHeight(self.bounds) - 44.;
        self.tableViewShouldFixed = NO;
    } else {
        self.tableViewShouldFixed = YES;
    }
    return MAX(h, KJX_sectionHeight);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cancelModel ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) return 1;
    return _titleModel ? _otherModels.count + 1 : _otherModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXSheetItem *item = [tableView dequeueReusableCellWithIdentifier:KJX_ItemIdentifier];
    if (!item) {
        item = [[JXSheetItem alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KJX_ItemIdentifier];
        item.textLabel.numberOfLines = 0;
        item.textLabel.textAlignment = NSTextAlignmentCenter;
        /* 忽略点击效果 */
        [item setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return item;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_titleModel && indexPath.section == 0 && indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _titleModel.title;
        cell.textLabel.textColor = _titleColor;
        cell.textLabel.font = _titleFont;
    }
    else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.textLabel.font = _otherTitlesFont;
        cell.textLabel.textColor = _otherTitlesColor;
        if (indexPath.section == 1 && _cancelModel) {
            cell.textLabel.text = _cancelModel.title;
        }
        else {
            NSInteger row = _titleModel ? indexPath.row - 1 : indexPath.row;
            JXSheetModel *otherModel = _otherModels[row];
            cell.textLabel.text = otherModel.title;
            if (row == _destructiveButtonIndex) {
                cell.textLabel.textColor = _destructiveColor;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 1 && view
        && [view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_titleModel && indexPath.section == 0 && indexPath.row == 0) {
        return _titleModel.height;
    } else if (indexPath.section == 1 && _cancelModel) {
        return _cancelModel.height;
    } else {
        NSInteger row = _titleModel ? indexPath.row - 1 : indexPath.row;
        JXSheetModel *model = _otherModels[row];
        return model.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!_titleModel && _otherModels.count == 0) return 0.;
    return section == 1 ? KJX_sectionHeight : 0.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_titleModel && indexPath.section == 0 && indexPath.row == 0) return;
    
    NSInteger index = _otherModels.count;
    if (indexPath.section == 0) {
        index = _titleModel ? indexPath.row - 1 : indexPath.row;
    }
    if (_completionHanlde) {
        self.completionHanlde(index, (indexPath.section == 1));
    }
    [self dismissViewAnimation];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setters

- (void)setTitle:(NSString *)title {
    _title = title;
    if (title.length) {
        self.titleModel = [JXSheetModel modelWithTitle:title font:_titleFont];
    }
    else {
        self.titleModel = nil;
    }
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    _cancelTitle = cancelTitle;
    if (cancelTitle.length) {
        self.cancelModel = [JXSheetModel modelWithTitle:cancelTitle font:_otherTitlesFont];
    }
    else {
        self.cancelModel = nil;
    }
}

- (void)setOtherTitles:(NSArray *)otherTitles {
    _otherTitles = otherTitles;
    if (_otherTitles.count == 0) self.otherModels = nil;
    else {
        NSMutableArray *temps = @[].mutableCopy;
        for (NSString *title in _otherTitles) {
            JXSheetModel *model = [JXSheetModel modelWithTitle:title font:_otherTitlesFont];
            if (model) {
                [temps addObject:model];
            }
        }
        self.otherModels = temps.copy;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (titleColor) {
        _titleColor = titleColor;
    }
}

- (void)setDestructiveColor:(UIColor *)destructiveColor {
    if (destructiveColor) {
        _destructiveColor = destructiveColor;
    }
}

- (void)setOtherTitlesColor:(UIColor *)otherTitlesColor {
    if (otherTitlesColor) {
        _otherTitlesColor = otherTitlesColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (titleFont) {
        _titleFont = titleFont;
    }
}

- (void)setOtherTitlesFont:(UIFont *)otherTitlesFont {
    if (otherTitlesFont) {
        _otherTitlesFont = otherTitlesFont;
    }
}

#pragma mark - getters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.userInteractionEnabled = NO;
        _backgroundView.alpha = 0.;
    }
    return _backgroundView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, _tableViewHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = KJX_MinButtonHeight;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        //适配iOS11，否则有问题
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        //容器底部遮挡白色,不然很难看
        if (iPhoneX) {
            UIView * viewBjX = [[UIView alloc]init];
            viewBjX.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
            viewBjX.backgroundColor = [UIColor whiteColor];
            [self addSubview:viewBjX];
        }
    }
    return _tableView;
}

@end
