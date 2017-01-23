//
//  JZSpeechViewController.m
//  chuanke
//
//  Created by jinzelu on 15/7/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZSpeechViewController.h"
#import "NetworkSingleton.h"
#import "JZCateModel.h"
#import "JZAllCourseCell.h"
#import "MJExtension.h"
#import "JZCourseDetailViewController.h"


//包含头文件
//文字转语音
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

//语音转文字
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"

#import "ISRDataHelper.h"


@interface JZSpeechViewController ()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    //不带界面的识别对象
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    
    UILabel *_textLabel;
    NSString *_resultStr;
    
    
    NSMutableArray *_dataSourceArray;
}
@end

@implementation JZSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setNav];
    [self initIFly];
    [self initViews];
    
    [self initTableView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
    
}

-(void)HideKeyboard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _dataSourceArray = [[NSMutableArray alloc] init];
}

-(void)initViews{
    //搜索框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64+10, screen_width-60, 30)];
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"请 “尝试语音输入课程“";
    self.textField.text = @"";
    self.textField.backgroundColor = RGB(242, 242, 242);
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    
    //语音按钮
    UIImageView *voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-60, 64+6, 60, 36)];
    [voiceImageView setImage:[UIImage imageNamed:@"voice"]];
    [self.view addSubview:voiceImageView];
    UITapGestureRecognizer *voiceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapVoice)];
    voiceImageView.userInteractionEnabled = YES;
    [voiceImageView addGestureRecognizer:voiceTap];
    
    
    
    //
//    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    beginBtn.frame = CGRectMake(10, 100, 80, 40);
//    [beginBtn addTarget:self action:@selector(OnBeginBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [beginBtn setTitle:@"开始录音" forState:UIControlStateNormal];
//    [beginBtn setTitleColor:navigationBarColor forState:UIControlStateNormal];
//    [self.view addSubview:beginBtn];
//    
//    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    endBtn.frame = CGRectMake(100, 100, 80, 40);
//    [endBtn addTarget:self action:@selector(OnEndBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [endBtn setTitle:@"结束录音" forState:UIControlStateNormal];
//    [endBtn setTitleColor:navigationBarColor forState:UIControlStateNormal];
//    [self.view addSubview:endBtn];
    
    //
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, screen_width-10, 100)];
    _textLabel.numberOfLines = 0;
    _textLabel.text = @"";
    _textLabel.hidden = YES;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.textColor = navigationBarColor;
    [self.view addSubview:_textLabel];
    
}

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 20, 120, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"课程详情";
    [backView addSubview:titleLabel];
    
    //收藏
    UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(screen_width-60, 20, 40, 40);
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collect"] forState:UIControlStateNormal];
//    [collectBtn setImage:[UIImage imageNamed:@"course_info_bg_collected"] forState:UIControlStateSelected];
    [collectBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(OnTapCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:collectBtn];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, screen_width, screen_height-64-40-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)getData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getSearchData];
    });
}

//搜索数据
-(void)getSearchData{
    __weak typeof(self) weakself = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://pop.client.chuanke.com/?mod=search&act=mobile&page=1&limit=20&keyword=%@&cVersion=2.4.1.2&from=iPhone",self.textField.text];
    [[NetworkSingleton sharedManager] getSearchResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"搜索查询成功");
        
        [_dataSourceArray removeAllObjects];
        NSMutableArray *ClassListArray = [responseBody objectForKey:@"ClassList"];
        for (int i = 0; i < ClassListArray.count; i++) {
            JZCateModel *jzCateM = [JZCateModel objectWithKeyValues:ClassListArray[i]];
            [_dataSourceArray addObject:jzCateM];
        }
        
        
        [weakself.tableView reloadData];
        
        
    } failureBlock:^(NSString *error){
        NSLog(@"搜索查询失败:%@",error);
    }];
}


//响应函数
-(void)OnTapBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)OnTapCollectBtn:(UIButton *)sender{
    [self.view endEditing:YES];
    if ([self.textField.text isEqualToString:@""]) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容再搜索" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    [self getData];
    
}
-(void)OnBeginBtn:(UIButton *)sender{
//    [iFlySpeechRecognizer startListening];
    _textLabel.text = @"";
    
    [self speechRecognize];
}
-(void)OnEndBtn:(UIButton *)sender{
    [_iFlySpeechRecognizer stopListening];
}

-(void)OnTapVoice{
    _textLabel.text = @"";
    [self startBtn];
}


//有界面
-(void)initRecognizer{
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil) {
        //设置最长录音时间
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点 3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点   3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //设置采样率，推荐使用16K    16000
        [_iflyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
//        if ([instance.language isEqualToString:[IATConfig chinese]]) {
//            //设置语言   zh_cn
            [_iflyRecognizerView setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
//            //设置方言  mandarin
            [_iflyRecognizerView setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
//        }else if ([instance.language isEqualToString:[IATConfig english]]) {
//            //设置语言
//            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//        }
//        //设置是否返回标点符号   0
        [_iflyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
}

/**
 *  启动听写
 */
-(void)startBtn{
    if (_iflyRecognizerView == nil) {
        [self initRecognizer ];
    }
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iflyRecognizerView start];
}


















//文字转语音
-(void)initIFly{
    //1.创建合成对象
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //2.设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"xiaoxin" forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
//    [_iFlySpeechSynthesizer startSpeaking: @"喜欢你，那双眼动人，笑声更迷人，愿再可，轻抚你。你好,我是科大讯飞的小燕"];
    [_iFlySpeechSynthesizer startSpeaking: @"我只是个小孩,干吗那么认真啊。不对,动感超人是这样笑的，5呼呼呼呼~~~~~~。"];
}
//听写
-(void)speechRecognize{
    //1.创建语音听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置听写模式
    _iFlySpeechRecognizer.delegate = self;
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //2.设置听写参数
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //3.启动识别服务
    [_iFlySpeechRecognizer startListening];//官网文档里有错误，不是start
}

#pragma mark - IFlySpeechSynthesizerDelegate
//结束代理
-(void)onCompleted:(IFlySpeechError *)error{
    NSLog(@"onCompleted");
}
//合成开始
- (void) onSpeakBegin{
    NSLog(@"onSpeakBegin");
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"onBufferProgress");
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
//    NSLog(@"onSpeakProgress");
}


#pragma mark - IFlySpeechRecognizerDelegate
//没有界面时的语音听写
//识别结果返回代理
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];//合并结果
    }
    NSLog(@"识别成功:%@",result);
    _resultStr = [NSString stringWithFormat:@"%@%@",_textLabel.text,result];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
    _textLabel.text = [NSString stringWithFormat:@"%@%@", _textLabel.text,resultFromJson];
}

-(void)onError:(IFlySpeechError *)errorCode{
    NSLog(@"识别失败");
}

-(void)onEndOfSpeech{
    NSLog(@"停止录音");
}

-(void)onBeginOfSpeech{
    NSLog(@"开始录音");
}

-(void)onVolumeChanged:(int)volume{
//    NSLog(@"音量");
}




/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    _textLabel.text = [NSString stringWithFormat:@"%@%@",_textLabel.text,result];
    if (isLast) {
        NSLog(@"结果：%@",_textLabel.text);
        self.textField.text = _textLabel.text;
        [self getData];
    }
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"searchCell";
    JZAllCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[JZAllCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 73.5, screen_width, 0.5)];
        lineView.backgroundColor = separaterColor;
        [cell addSubview:lineView];
    }
    
    JZCateModel *jzCateM = _dataSourceArray[indexPath.row];
    [cell setJzCateM:jzCateM];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    JZCateModel *jzCateM = _dataSourceArray[indexPath.row];
    JZCourseDetailViewController *jzCourseDVC = [[JZCourseDetailViewController alloc] init];
    jzCourseDVC.SID = jzCateM.SID;
    jzCourseDVC.courseId = jzCateM.CourseID;
    [self.navigationController pushViewController:jzCourseDVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_iFlySpeechSynthesizer stopSpeaking];
    [_iFlySpeechRecognizer stopListening];
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
