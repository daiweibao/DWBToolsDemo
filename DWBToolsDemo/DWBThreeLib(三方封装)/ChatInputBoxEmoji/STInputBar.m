//
//  STInputBar.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STInputBar.h"
#import "STEmojiKeyboard.h"

#define kSTIBDefaultHeight 50
#define kSTLeftButtonWidth 50
#define kSTLeftButtonHeight 30
#define kSTRightButtonWidth 55
#define kSTTextviewDefaultHeight 36
#define kSTTextviewMaxHeight 80

//读取图片
#define GETImageNasme(imageName) [[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ChatInputBox" ofType:@"bundle"]] resourcePath] stringByAppendingPathComponent:imageName]


@interface STInputBar () <UITextViewDelegate>

@property (strong, nonatomic) UIButton *keyboardTypeButton;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) STEmojiKeyboard *keyboard;

@property (strong, nonatomic) void (^sendDidClickedHandler)(NSString *);
@property (strong, nonatomic) void (^sizeChangedHandler)(void);


@end

@implementation STInputBar{
    BOOL _isRegistedKeyboardNotif;
    BOOL _isDefaultKeyboard;
    NSArray *_switchKeyboardImages;
}

+ (instancetype)inputBar{
    return [self new];
}

- (void)dealloc{
    if (_isRegistedKeyboardNotif){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSTIBDefaultHeight)]){
        _isRegistedKeyboardNotif = NO;
        _isDefaultKeyboard = YES;
//        GETImageNasme(@"ChatFace_icon");
        _switchKeyboardImages = @[@"ChatFace_icon",@"Chatkeyboard_icon"];
        
    }
    return self;
}

//得到类型后再创建立
-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    if ([typeString isEqual:@"融云聊天"]) {
        //创建UI
        [self createChatUI];
        
    }
}


#pragma mark =====================融云聊天UI界面-开始========================
- (void)createChatUI{
    self.backgroundColor = RGBA_COLOR(245, 243, 243, 1.0);
    //加边框
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGBA_COLOR(215, 215, 215 ,1.0).CGColor;
    
    //表情键盘
    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 47, 50)];
    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _keyboardTypeButton.tag = 0;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    //    表情
    WeakSelf(self);
    _keyboard = [STEmojiKeyboard keyboard];
    [_keyboard setGetSenderButtonMain:^{
        //表情发送键点击回调
        [weakself sendTextCommentTaped:nil];
    }];
    

    //输入框
    self.textView = [[ZBHTextView alloc] initWithFrame:CGRectMake(47, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, SCREEN_WIDTH-93-47, kSTTextviewDefaultHeight)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    //self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = RGBA_COLOR(211, 211, 211 ,1.0).CGColor;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.userInteractionEnabled = YES;
    self.textView.layer.cornerRadius = 5;
    
    //回复那个按钮
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-83, 7, 73, 36);
    self.sendButton.backgroundColor = [UIColor clearColor];
    [self.sendButton setTitle:@"发包" forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = 5;
    self.sendButton.layer.borderWidth = 1;
    self.sendButton.layer.borderColor =[UIColor colorWithHexString:@"#e53836"].CGColor;
    [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#e53836"] forState:UIControlStateNormal];;
    self.sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.sendButton addTarget:self action:@selector(ActionsendRedEn:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.enabled = YES;
    [self addSubview:_keyboardTypeButton];//表情
    [self addSubview:_textView];
    [self addSubview:self.sendButton];//发送
    
}

//发包
-(void)ActionsendRedEn:(UIButton *)button{
    
    if ([button.titleLabel.text isEqual:@"发送"]) {
        //发送
        [self sendTextCommentTaped:button];
        
    }else{
        //发送红包按钮
        if (self.senderRedEnvelope) {
            self.senderRedEnvelope();
        }
    }
}

#pragma mark =====================融云聊天UI界面-结束========================

- (void)layout{
    
    self.sendButton.enabled = ![@"" isEqualToString:self.textView.text];
    self.sendButton.enabled = YES;
    
    CGRect textViewFrame = self.textView.frame;
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    
    //这里必须写15，非常重要
    CGFloat offset = 15;
    self.textView.scrollEnabled = (textSize.height > kSTTextviewMaxHeight-offset);
    textViewFrame.size.height = MAX(kSTTextviewDefaultHeight, MIN(kSTTextviewMaxHeight, textSize.height));
    self.textView.frame = textViewFrame;
    
    CGRect addBarFrame = self.frame;
    CGFloat maxY = CGRectGetMaxY(addBarFrame);
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = maxY-addBarFrame.size.height;
    self.frame = addBarFrame;
    
    self.keyboardTypeButton.center = CGPointMake(CGRectGetMidX(self.keyboardTypeButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.sendButton.center = CGPointMake(CGRectGetMidX(self.sendButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    
    if (self.sizeChangedHandler){
        self.sizeChangedHandler();
    }
    
}

#pragma mark - public

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    return [_textView resignFirstResponder];
}

- (void)registerKeyboardNotif{
    _isRegistedKeyboardNotif = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    //点击按钮--弹出键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replyActionSon) name:@"replyActionSon" object:nil];
    //清除输入框里的内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DeleteContent) name:@"DeleteContent" object:nil];
    
    
}

//清除输入框里的内容
-(void)DeleteContent{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.textView.text = @"";
        //布局
        [self layout];
        
    });
}

-(void)replyActionSon{
    //弹出键盘
    [self.textView becomeFirstResponder];
    
}

//换行键的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        
        if (self.sendDidClickedHandler){
            self.sendDidClickedHandler(self.textView.text);
            //            self.textView.text = @"";
            [self layout];
        }
        
        return NO;
        
    }
    
    return YES;
    
}


- (void)setDidSendClicked:(void (^)(NSString *))handler{
    _sendDidClickedHandler = handler;
}

- (void)setInputBarSizeChangedHandle:(void (^)(void))handler{
    _sizeChangedHandler = handler;
}

- (void)setFitWhenKeyboardShowOrHide:(BOOL)fitWhenKeyboardShowOrHide{
    if (fitWhenKeyboardShowOrHide){
        [self registerKeyboardNotif];
    }
    if (!fitWhenKeyboardShowOrHide && _fitWhenKeyboardShowOrHide){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    _fitWhenKeyboardShowOrHide = fitWhenKeyboardShowOrHide;
}

#pragma mark - notif

- (void)keyboardWillShow:(NSNotification *)notification
{
   
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //回调键盘高度
    if (self.getKeyboardHeight) {
        self.getKeyboardHeight(kbSize.height);
    }
    
    if ([self.typeString isEqual:@"融云聊天"]) {
        //融云聊天,自己弹出高度，所以不需要
    }else{
        
        [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                              delay:0
                            options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                         animations:^{
                             CGRect newInputBarFrame = self.frame;
                             newInputBarFrame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame)-kbSize.height;
                             self.frame = newInputBarFrame;
                         }
                         completion:nil];
        
    }
    
    //发送按钮改变
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    
    //    if (self.textView.inputView !=nil) {
    //结束编辑
    if (self.endEidt) {
        self.endEidt(self.textView.text);
    }
    //    }
    
    NSDictionary* info = [notification userInfo];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, height-CGRectGetHeight(self.frame)/2.0-MC_TabbarSafeBottomMargin);
                     }
                     completion:nil];
    
    //设置为nil恢复键盘
    self.textView.inputView = nil;
    //表情键盘复原
    [self keyboardTypeButtonNomal];
    
    
    //发送按钮改变
    [self.sendButton setTitle:@"发包" forState:UIControlStateNormal];
}

//表情键盘复原
-(void)keyboardTypeButtonNomal{
    //表情处理
    _keyboardTypeButton.tag = 0;//tage
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[0]] forState:UIControlStateNormal];//图片
}

#pragma mark - action

- (void)sendTextCommentTaped:(UIButton *)button{
    if (self.sendDidClickedHandler){
        self.sendDidClickedHandler(self.textView.text);
        //        self.textView.text = @"";
        [self layout];
    }
}

- (void)keyboardTypeButtonClicked:(UIButton *)button{
    if (button.tag == 1){
        self.textView.inputView = nil;
    }
    else{
        [_keyboard setTextView:self.textView];
    }
    [self.textView reloadInputViews];
    button.tag = (button.tag+1)%2;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[button.tag]] forState:UIControlStateNormal];
    [_textView becomeFirstResponder];
    
}

#pragma mark - text view delegate

- (void)textViewDidChange:(UITextView *)textView{
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //设置为nil恢复键盘
    //    self.textView.inputView = nil;
    
    return YES;
}

//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.endEidt) {
        self.endEidt(textView.text);
    }
}



@end

