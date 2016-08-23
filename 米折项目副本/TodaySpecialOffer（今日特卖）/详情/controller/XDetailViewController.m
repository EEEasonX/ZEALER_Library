//
//  XDetailViewController.m
//  米折项目
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XDetailViewController.h"

#import "WXNewViewController.h"


@interface XDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    BOOL _status_detail;
    
    BOOL _price_status;
    
    UIButton *_select_bt;
    
    UIButton *_moreBt;
}


@property(nonatomic,strong)MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UILabel *Lab_title;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIView *headerOfView;

@property(nonatomic,strong)UIImageView *big_imageview;

@property(nonatomic,strong)UIImageView *logo_imageview;

@property(nonatomic,strong)UILabel *brandLabel;

@property(nonatomic,strong)UILabel *num_label;

@property(nonatomic,strong)UILabel *detail_label;

@property(nonatomic,copy)NSDictionary *dic;

@property(nonatomic,strong)UIView *bt_view;

@end

@implementation XDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
}
- (IBAction)ShareAction:(id)sender {
}
- (IBAction)BackAction1:(id)sender {
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseID" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}


#pragma Mark ---------------不是必须实现的协议方法----------
//返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionReusableView * )collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //头视图尾视图 遵循复用机制
    UICollectionReusableView * crv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    lab.textColor = [UIColor colorWithRed:0.98 green:0.93 blue:0.95 alpha:1.00];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    crv.backgroundColor = [UIColor colorWithRed:0.95 green:0.78 blue:0.87 alpha:1.00];
    
    [crv addSubview:lab];
    //判断绘制的是头视图还是尾视图
    if ([kind isEqualToString: UICollectionElementKindSectionHeader] == YES) {
        lab.text = @"你妹的！！！";
    }
    return crv;
}


-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {320, 300};
        return size;
    }
    else
    {
        CGSize size = {320, 20};
        return size;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"我草拟大爷");
    
}

#warning --- 跟tableView 不同的是 collectionView 的cell 必须提前注册 注册过后才能使用
-(void)registerCell{
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseID"];
     // collectionView 的组头视图（header）和组尾视图（footer）是需要放在一个UICollectionRectangleView 上的 也必须注册
    /**
     *  1.头视图或尾视图要放在谁上
     *  2.归定 是头视图还是尾视图
     *  3.唯一标示
     */
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

#pragma mark ---------- 懒加载 -------------

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        /**
         这很重要 ：初始化一个collectview 时 必须携带一个collectionviewLayout
         */
        //流式布局
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        
        //自动
        layout.itemSize = CGSizeMake(CURRENT_SIZE(140), CURRENT_SIZE(140));
        
        layout.scrollDirection = 0;
        /**
         UICollectionViewScrollDirectionVertical,   上下滑
         UICollectionViewScrollDirectionHorizontal  左右滑
         */
        //设置边框的 上下左右的宽度
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //设置连个 cell 的行间距
        layout.minimumLineSpacing = 20;
        //设置连个 cell 的列间距
        layout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor colorWithRed:0.82 green:0.98 blue:1.00 alpha:1.00];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView addSubview:self.headerOfView];
    }
    return _collectionView;
}

-(UIView *)headerOfView{
    if (!_headerOfView) {
        _headerOfView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, CURRENT_SIZE(300))];
        _headerOfView.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        
        [self.headerOfView addSubview:self.big_imageview];
        
        [self.headerOfView addSubview:self.logo_imageview];
        
        [self.headerOfView addSubview:self.brandLabel];
        
        [self.headerOfView addSubview:self.num_label];
        
        
        [self.headerOfView addSubview:self.bt_view];
        
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.num_label.frame.origin.x+self.num_label.frame.size.width, self.num_label.frame.origin.y, 80, 20)];
        
        lab.text=@"人已经购买";
        
        lab.textColor=[UIColor grayColor];
        
        lab.numberOfLines=0;
        
        lab.font=[UIFont systemFontOfSize:12];
        
        [self.headerOfView addSubview:lab];
        
        [self.headerOfView addSubview:self.detail_label];
        
        _moreBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.detail_label.frame.size.height+self.detail_label.frame.origin.y+5, 10, 5)];
        
        [_moreBt setBackgroundImage:[UIImage imageNamed:@"ic_cart_arrow_gray"] forState:UIControlStateNormal];
        
        [_moreBt addTarget:self action:@selector(showMoreAction:) forControlEvents:UIControlEventTouchDown];
        
        [self.headerOfView addSubview:_moreBt];
        
        
        
        
    }
    return _headerOfView;
    
}


//计算字符串的高度和长度
-(CGRect)rectWithText:(NSString *)text WithFontSize:(CGFloat)fontsize{
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    CGSize size=CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000);
    CGRect rect=[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}


-(void)showMoreAction:(UIButton *)button{
    
    if (_status_detail==YES) {
        [button setBackgroundImage:[UIImage imageNamed:@"ic_default_arrow_up"] forState:UIControlStateNormal];
        
        CGRect rect=[self rectWithText:[self.dic objectForKey:@"brand_story"] WithFontSize:12];
        
        self.detail_label.frame=CGRectMake(10,200, SCREEN_WIDTH-20,rect.size.height);
        
        self.headerOfView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 350+rect.size.height-40);
        
        self.detail_label.numberOfLines=0;
        
        
        _status_detail=NO;
        
    }else if(_status_detail==NO){
        
        [button setBackgroundImage:[UIImage imageNamed:@"ic_cart_arrow_gray"] forState:UIControlStateNormal];
        
        self.headerOfView.frame=CGRectMake(0, 0,SCREEN_WIDTH, 350);
        
        self.detail_label.frame=CGRectMake(10, 200, SCREEN_WIDTH-20, 60);
        
        self.detail_label.numberOfLines=2;
        
        _detail_label.lineBreakMode=NSLineBreakByClipping;
        
        _status_detail=YES;
    }
    
    self.bt_view.frame=CGRectMake(0, self.detail_label.frame.origin.y+self.detail_label.frame.size.height+40, SCREEN_WIDTH, 50);
    
    _moreBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.detail_label.frame.size.height+self.detail_label.frame.origin.y+5, 10, 5)];
    
}

-(UIImageView *)big_imageview{
    if (!_big_imageview) {
        _big_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        
        
    }
    
    return _big_imageview;
}


-(UIImageView *)logo_imageview{
    if (!_logo_imageview) {
        _logo_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 140, 60, 60)];
    }
    return _logo_imageview;
}

-(UILabel *)brandLabel{
    
    if (!_brandLabel) {
        _brandLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 160,80, 20)];
        
        _brandLabel.textColor=SELECT_COLOR(123, 123, 123, 1);
        _brandLabel.textAlignment=NSTextAlignmentCenter;
        
        _brandLabel.font=[UIFont systemFontOfSize:13];
    }
    return _brandLabel;
}



-(UILabel *)num_label{
    if (!_num_label) {
        _num_label=[[UILabel alloc]initWithFrame:CGRectMake(70, 180, 80, 20)];
        
        _num_label.textAlignment=NSTextAlignmentCenter;
        
        _num_label.textColor=[UIColor orangeColor];
        
        _num_label.font=[UIFont systemFontOfSize:12];
    }
    return _num_label;
    
}


-(UILabel *)detail_label{
    if (!_detail_label) {
        _detail_label=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 60)];
        
        _detail_label.textColor=SELECT_COLOR(93, 93, 93, 1);
        
        _detail_label.font=[UIFont systemFontOfSize:12];
        
        _detail_label.numberOfLines=2;
        
        _detail_label.lineBreakMode=NSLineBreakByClipping;
        
    }
    return _detail_label;
}

-(NSDictionary *)dic{
    if (!_dic) {
        _dic=[[NSDictionary alloc]init];
    }
    return _dic;
}

-(UIView *)bt_view{
    if (!_bt_view) {
        _bt_view=[[UIView alloc]initWithFrame:CGRectMake(0, self.detail_label.frame.origin.y+self.detail_label.frame.size.height+40, SCREEN_WIDTH, 50)];
        NSArray *cateArr=@[@"综合",@"价格",@"销量",@"筛选"];
        
        for (int i=0; i<cateArr.count; i++) {
            
            
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*i, 0, SCREEN_WIDTH/4, 25)];
            
            button.tag=100+i;
            
            [button setTitle:cateArr[i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            if (i==0) {
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                
                _select_bt=button;
                
            }
            
            
            
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchDown];
            
            [self.bt_view addSubview:button];
            
            
        }
        
    }
    
    return _bt_view;
    
}

#pragma mark ------------点击事件 ----------
-(void)selectButton:(UIButton *)button{
    if (button.tag==103) {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
    }if (button.tag==101) {
        
        
        
        if (_price_status==YES) {
            
            [button setImage:[UIImage imageNamed:@"ic_price_down"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            
            
            _price_status=NO;
        }else if(_price_status==NO){
            
            [button setImage:[UIImage imageNamed:@"ic_price_up"] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
            
            _price_status=YES;
            
        }
    }
    
    if(button==_select_bt){
        return;
    }
    
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_select_bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    _select_bt=button;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
