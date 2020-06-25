//
//  GroupShadowTableView.m
//  FaceMoney
//
//  Created by 杨洋 on 9/11/16.
//  Copyright © 2016 杨洋. All rights reserved.
//

#import "GroupShadowTableView.h"
#import "BaseShadowContentView.h"

@interface UIView (Add)

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;

@end

@implementation UIView (Add)


- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity {
    self.layer.cornerRadius = radius;
    if (shadow) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.layer.shadowColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = radius;
        self.layer.shouldRasterize = NO;
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:radius] CGPath];
    }
    self.layer.masksToBounds = !shadow;
}

@end

@class PlainTableViewCell;
@protocol PlainTableViewCellDelegate <NSObject>

- (NSInteger)plainTableViewCell:(PlainTableViewCell *)cell numberOfRowsInSection:(NSInteger)section;

- (CGFloat)plainTableViewCell:(PlainTableViewCell *)cell heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)plainTableViewCell:(PlainTableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PlainTableViewCell : UITableViewCell <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak,nullable) id<PlainTableViewCellDelegate> delegate;

@property (nonatomic,assign) BOOL showSeparator;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) BaseShadowContentView * shadowView;

@property (nonatomic,assign) CGFloat groupSpaceHeight; //组间距

@property (nonatomic,assign) CGFloat groupHorizontalMargin; //组边距

@property (nonatomic,copy) NSInteger (^numberOfRowsInSection)(PlainTableViewCell *plainCell,NSInteger section);

@property (nonatomic,copy) UITableViewCell * (^cellForRowAtIndexPath)(PlainTableViewCell *plainCell,NSIndexPath *indexPath);

@property (nonatomic,copy) CGFloat (^heightForRowAtIndexPath)(PlainTableViewCell *plainCell,NSIndexPath *indexPath);

@property (nonatomic,copy) void (^didSelectRowAtIndexPath)(PlainTableViewCell *plainCell,NSIndexPath *indexPath);

- (void)deselectCell;

- (void)selectCell:(NSInteger)row;

@end

@interface GroupShadowTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) PlainTableViewCell *selectedCell;

@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@end

@implementation GroupShadowTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initializeUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeUI];
    }
    return self;
}

-(void)initializeUI {
    [self registerClass:[PlainTableViewCell class] forCellReuseIdentifier:@"PlainTableViewCell"];
    self.delegate = self;
    self.dataSource = self;
}

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    PlainTableViewCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    [cell.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:animated];
}

//MARK: - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.numberOfSectionsInGroupShadowTableView) {
        return self.numberOfSectionsInGroupShadowTableView(self);
    }else if (self.groupShadowDataSource && [self.groupShadowDataSource respondsToSelector:@selector(numberOfSectionsInGroupShadowTableView:)]) {
        return [self.groupShadowDataSource numberOfSectionsInGroupShadowTableView:self];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlainTableViewCell"];
    cell.showSeparator = self.showSeparator;
    cell.tableView.separatorInset = self.separatorInset;
    if (self.groupShadowDelegate && [self.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:canSelectAtSection:)]) {
        cell.tableView.allowsSelection = [self.groupShadowDelegate groupShadowTableView:self canSelectAtSection:indexPath.section];
    }else {
        cell.tableView.allowsSelection = self.allowsSelection;
    }
    cell.tag = indexPath.section + 100; //标记是第几组
    __weak typeof(self) weakSelf = self;
    [cell setNumberOfRowsInSection:^NSInteger(PlainTableViewCell *plainTableViewCell, NSInteger section) {
        if (weakSelf.numberOfRowsInSection) {
            return weakSelf.numberOfRowsInSection(weakSelf,section);
        }else if (weakSelf.groupShadowDataSource && [weakSelf.groupShadowDataSource respondsToSelector:@selector(groupShadowTableView:numberOfRowsInSection:)]) {
            return [weakSelf.groupShadowDataSource groupShadowTableView:weakSelf numberOfRowsInSection:section];
        }
        return 0;
    }];
    
    [cell setHeightForRowAtIndexPath:^CGFloat(PlainTableViewCell *plainTableViewCell, NSIndexPath *indexPath) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:plainTableViewCell.tag - 100];
        if (weakSelf.heightForRowAtIndexPath) {
            return  weakSelf.heightForRowAtIndexPath(weakSelf,newIndexPath);
        }else if (weakSelf.groupShadowDelegate && [weakSelf.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:heightForRowAtIndexPath:)]) {
            return [weakSelf.groupShadowDelegate groupShadowTableView:weakSelf heightForRowAtIndexPath:newIndexPath];
        }
        return 0;
    }];
    
    [cell setCellForRowAtIndexPath:^UITableViewCell *(PlainTableViewCell *plainTableViewCell, NSIndexPath *indexPath) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:plainTableViewCell.tag - 100];
        if (weakSelf.cellForRowAtIndexPath) {
            return  weakSelf.cellForRowAtIndexPath(weakSelf,newIndexPath);
        }else if (weakSelf.groupShadowDataSource && [weakSelf.groupShadowDataSource respondsToSelector:@selector(groupShadowTableView:cellForRowAtIndexPath:)]) {
            return [weakSelf.groupShadowDataSource groupShadowTableView:weakSelf cellForRowAtIndexPath:newIndexPath];
        }
        return nil;
    }];
    
    [cell setDidSelectRowAtIndexPath:^(PlainTableViewCell *plainTableViewCell, NSIndexPath *indexPath) {
        
        NSInteger actualSection = plainTableViewCell.tag - 100;
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:actualSection];
        if (weakSelf.selectedCell && weakSelf.selectedCell != plainTableViewCell) {
            [weakSelf.selectedCell deselectCell];
        }
        if (weakSelf.didSelectRowAtIndexPath) {
            weakSelf.didSelectRowAtIndexPath(weakSelf,newIndexPath);
        }else if (weakSelf.groupShadowDelegate && [weakSelf.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:didSelectRowAtIndexPath:)]) {
            [weakSelf.groupShadowDelegate groupShadowTableView:weakSelf didSelectRowAtIndexPath:newIndexPath];
        }
        self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:actualSection];
        self.selectedCell = plainTableViewCell;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PlainTableViewCell *ptCell = (PlainTableViewCell *)cell;
    
    //计算组间隔
    if (self.groupSpaceHeightForRowAtIndexPath) {
        CGFloat groupSpace = self.groupSpaceHeightForRowAtIndexPath(self,indexPath);
        if (ptCell && [ptCell isKindOfClass:PlainTableViewCell.class]) {
            ptCell.groupSpaceHeight = groupSpace;
        }
    }
    else if (self.groupShadowDelegate && [self.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:groupSpaceHeightForRowAtIndexPath:)]) {
       CGFloat groupSpace = [self.groupShadowDelegate groupShadowTableView:self groupSpaceHeightForRowAtIndexPath:indexPath];
       if (ptCell && [ptCell isKindOfClass:PlainTableViewCell.class]) {
           ptCell.groupSpaceHeight = groupSpace;
       }
    }
    
    //计算组边距
    if (self.groupMarginWidthForRowAtIndexPath) {
        CGFloat marginWidth = self.groupMarginWidthForRowAtIndexPath(self,indexPath);
        if (ptCell && [ptCell isKindOfClass:PlainTableViewCell.class]) {
            ptCell.groupHorizontalMargin = marginWidth;
        }
    }
    else if (self.groupShadowDelegate && [self.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:groupMarginWidthForRowAtIndexPath:)]) {
        CGFloat marginWidth = [self.groupShadowDelegate groupShadowTableView:self groupMarginWidthForRowAtIndexPath:indexPath];
        if (ptCell && [ptCell isKindOfClass:PlainTableViewCell.class]) {
            ptCell.groupHorizontalMargin = marginWidth;
        }
    }
    [ptCell.tableView reloadData];
    if (indexPath.section == self.selectedIndexPath.section) {
        [self.selectedCell selectCell:self.selectedIndexPath.row];
    }
}

//MARK: - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger totalRows = 0;
    //获取组内单元格个数
    if (self.numberOfRowsInSection) {
        totalRows = self.numberOfRowsInSection(self,indexPath.section);
    }else if (self.groupShadowDataSource && [self.groupShadowDataSource respondsToSelector:@selector(groupShadowTableView:numberOfRowsInSection:)]) {
        totalRows = [self.groupShadowDataSource groupShadowTableView:self numberOfRowsInSection:indexPath.section];
    }
    
    //计算组高
    CGFloat totalHeight = 0;
    for (int i = 0; i < totalRows; i ++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        if (self.heightForRowAtIndexPath) {
            totalHeight += self.heightForRowAtIndexPath(self,newIndexPath);
        }else if (self.groupShadowDelegate && [self.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:heightForRowAtIndexPath:)]) {
            totalHeight += [self.groupShadowDelegate groupShadowTableView:self heightForRowAtIndexPath:newIndexPath];
        }
    }
    
    //计算组间隔
    if (self.groupSpaceHeightForRowAtIndexPath) {
        CGFloat groupSpace = self.groupSpaceHeightForRowAtIndexPath(self,indexPath);
        totalHeight += groupSpace;
    }
    else if (self.groupShadowDelegate && [self.groupShadowDelegate respondsToSelector:@selector(groupShadowTableView:groupSpaceHeightForRowAtIndexPath:)]) {
        CGFloat groupSpace = [self.groupShadowDelegate groupShadowTableView:self groupSpaceHeightForRowAtIndexPath:indexPath];
        totalHeight += groupSpace;
    }
    
    return totalHeight;
}

@end

//MARK: - PlainTableViewCell
@implementation PlainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        [self.contentView addSubview:self.shadowView];
        [self.contentView addSubview:self.tableView];
        self.groupHorizontalMargin = 0;
        self.groupSpaceHeight = 0;
        
        //设置阴影颜色
//        [self.shadowView setShadowColor:[UIColor blackColor]];
        [self.shadowView setRectCorner:RadiusType_All];
    }
    return self;
}

-(void)setGroupSpaceHeight:(CGFloat)groupSpaceHeight{
    _groupSpaceHeight = groupSpaceHeight;
    [self.tableView setFrame:CGRectMake(self.groupHorizontalMargin, 0, self.width - self.groupHorizontalMargin*2, self.height - groupSpaceHeight)];
    [self.shadowView setFrame:self.tableView.frame];
}

-(void)setGroupHorizontalMargin:(CGFloat)groupHorizontalMargin{
    _groupHorizontalMargin = groupHorizontalMargin;
    [self.tableView setFrame:CGRectMake(groupHorizontalMargin, 0, self.width - groupHorizontalMargin*2, self.height - self.groupSpaceHeight)];
    [self.shadowView setFrame:self.tableView.frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

//MARK: - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.numberOfRowsInSection) {
        return self.numberOfRowsInSection(self,self.tag-100);
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(plainTableViewCell:numberOfRowsInSection:)]) {
            return  [self.delegate plainTableViewCell:self numberOfRowsInSection:self.tag -100];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.cellForRowAtIndexPath) {
        cell = self.cellForRowAtIndexPath(self,indexPath);
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(plainTableViewCell:cellForRowAtIndexPath:)]) {
            cell = [self.delegate plainTableViewCell:self cellForRowAtIndexPath:indexPath];
        }
    }
    NSAssert(cell, @"Cell不能为空");
    return cell;
}

//MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(self,indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightForRowAtIndexPath) {
        return self.heightForRowAtIndexPath(self,indexPath);
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(plainTableViewCell:heightForRowAtIndexPath:)]) {
            return  [self.delegate plainTableViewCell:self heightForRowAtIndexPath:indexPath];
        }
    }
    return 0;
}

- (void)deselectCell {
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

- (void)selectCell:(NSInteger)row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(self.bounds, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.clipsToBounds = YES;
        [_tableView.layer setMasksToBounds:YES];
        [_tableView.layer setCornerRadius:18];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _tableView;
}

-(BaseShadowContentView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[BaseShadowContentView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    }
    return _shadowView;
}

@end
