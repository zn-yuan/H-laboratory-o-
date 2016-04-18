//
//  CocoTestVC.m
//  laboratory
//
//  Created by hryan on 16/2/24.
//  Copyright © 2016年 fe. All rights reserved.
//

#import "CocoTestVC.h"

@interface CocoTestVC ()

@end

@implementation CocoTestVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self write ];
//    [self changePath];
//    [self changeExtension];
//    [self Array];
//    test3();
    test4();

}

- (void)read {
    
    NSString *path = @"/Users/hryan/Desktop/list.txt";
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *str2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error;
    NSStringEncoding encoding = 0;
    NSString *str3 =[NSString stringWithContentsOfFile:path usedEncoding:&encoding error:&error];
    
    NSString *str4 = [NSString stringWithContentsOfFile:path2 encoding:kCFStringEncodingGB_18030_2000 error:&error];
    
    DLog(@"______str:%@",str)
    DLog(@"______str2:%@",str2)
    DLog(@"______str3:%@, error:%@,NSStringEncoding:%lu",str3,error,encoding)
    DLog(@"______str4: %@ ,error:%@",str4, error);
}

- (void)write {
    
    NSString *path = @"/Users/hryan/Desktop/list.txt";
//    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSError *error;
    NSString *writeStr = @"股份结构";
    [writeStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        DLog(@"Write_error:%@",error)
    } else {
        DLog(@"write success")
    }
    
}

- (void)changePath {
    NSMutableArray *marray=[NSMutableArray array];//可变数组
    [marray addObject:@"Users"];
    [marray addObject:@"KenshinCui"];
    [marray addObject:@"Desktop"];
    
    NSString *path=[NSString pathWithComponents:marray];
    DLog(@"%@",path);//字符串拼接成路径
    //结果：Users/KenshinCui/Desktop
    
    DLog(@"[path pathComponents]:%@",[path pathComponents]);//路径分割成数组
    /*结果：
     (
     Users,
     KenshinCui,
     Desktop
     )
     */
    
    NSLog(@"isAbsolutePath: %i",[path isAbsolutePath]);//是否绝对路径（其实就是看字符串是否以“/”开头）
    //结果：0
    NSLog(@"lastPathComponent: %@",[path lastPathComponent]);//取得最后一个目录
    //结果：Desktop
    NSLog(@"stringByDeletingLastPathComponent :%@",[path stringByDeletingLastPathComponent]);//删除最后一个目录，注意path本身是常量不会被修改,只是返回一个新字符串
    //结果：Users/KenshinCui
    NSLog(@"stringByAppendingPathComponent :%@",[path stringByAppendingPathComponent:@"Documents"]);//路径拼接
    //结果：Users/KenshinCui/Desktop/Documents
}


- (void)changeExtension {
    
    NSString *path=@"Users/KenshinCui/Desktop/test.txt";
    DLog(@"%@",[path pathExtension]);//取得扩展名，注意ObjC中扩展名不包括"."
    //结果：txt
    DLog(@"%@",[path stringByDeletingPathExtension]);//删除扩展名，注意包含"."
    //结果：Users/KenshinCui/Desktop/test
    DLog(@"%@",[@"Users/KenshinCui/Desktop/test" stringByAppendingPathExtension:@"mp3"]);//添加扩展名
    //结果：Users/KenshinCui/Desktop/test.mp3
    
}

- (void)Array {
    
    People *person1 = [[People alloc]init];
    People *person2 = [[People alloc]init];
    People *person3 = [[People alloc] init];
    
    person1.name = @"js";
    person2.name = @"oc";
    person3.name = @"swift";
    
    NSArray *array =@[person1, person2, person3];
    //执行所有元素的showMessage方法,后面的参数最多只能有一个
    [array makeObjectsPerformSelector:@selector(showMess:) withObject:@"Hello,world!"];
    
    
#pragma mark---array遍历 
    
    //方法3,利用代码块方法
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"method3:index %zi is %@",idx,obj);
        if(idx==2){//当idx=2时设置*stop为YES停止遍历
            *stop=YES;
        }
    }];
    /*结果：
     method3:index 0 is abc
     method3:index 1 is <NSObject: 0x100106de0>
     method3:index 2 is cde
     */
    
    
    //方法4，利用迭代器
    //NSEnumerator *enumerator= [array objectEnumerator];//获得一个迭代器
    NSEnumerator *enumerator=[array reverseObjectEnumerator];//获取一个反向迭代器
    //NSLog(@"all:%@",[enumerator allObjects]);//获取所有迭代对象，注意调用完此方法迭代器就遍历完了，下面的nextObject就没有值了
    id obj2=nil;
    while (obj2=[enumerator nextObject]) {
        NSLog(@"method4:%@",obj2);
    }
    /*结果：
     method4:25
     method4:opq
     method4:cde
     method4:<NSObject: 0x100106de0>
     method4:abc
     */

}


//数组派生出新的数组
void test3(){
    NSArray *array=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSArray *array2=[array arrayByAddingObject:@"4"];//注意此时array并没有变
    NSLog(@"%@",array2);
    /*结果：
     (
     1,
     2,
     3,
     4
     )
     */
    
    
    NSLog(@"%@",[array2 arrayByAddingObjectsFromArray:[NSArray arrayWithObjects:@"5",@"6", nil]]);//追加形成新的数组
    /*结果：
     (
     1,
     2,
     3,
     4,
     5,
     6
     )
     */
    
    
    NSLog(@"%@",[array2 subarrayWithRange:NSMakeRange(1, 3)]);//根据一定范围取得生成一个新的数组
    /*结果：
     (
     2,
     3,
     4
     )
     */
    
    
    NSLog(@"%@",[array componentsJoinedByString:@","]);//数组连接，形成一个字符串
    //结果：1,2,3
    
    //读写文件
    NSString *path=@"/Users/hryan/Desktop/array.xml";
    [array writeToFile:path atomically:YES];
    NSArray *array3=[NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",array3);
    /*结果：
     (
     1,
     2,
     3
     )
     */
}


//数组排序
void test4(){
    //方法1,使用自带的比较器
    NSArray *array=[NSArray arrayWithObjects:@"3",@"1",@"2", nil];
    NSArray *array2= [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@",array2);
    /*结果：
     (
     1,
     2,
     3
     )
     */
    
    
    //方法2,自己定义比较器
    People *person1=[People personWithName:@"Kenshin"];
    People *person2=[People personWithName:@"Kaoru"];
    People *person3=[People personWithName:@"Rosa"];
    NSArray *array3=[NSArray arrayWithObjects:person1,person2,person3, nil];
    NSArray *array4=[array3 sortedArrayUsingSelector:@selector(show:)];
    NSLog(@"%@",array4);
    /*结果：
     (
     "name=Kaoru",
     "name=Kenshin",
     "name=Rosa"
     )
     */
    
    
    //方法3使用代码块
    NSArray *array5=[array3 sortedArrayUsingComparator:^NSComparisonResult(People *obj1, People *obj2) {
        return [obj2.name compare:obj1.name];//降序
    }];
    NSLog(@"%@",array5);
    /*结果：
     (
     "name=Rosa",
     "name=Kenshin",
     "name=Kaoru"
     )
     */
    
    
    //方法4 通过描述器定义排序规则
    People *person4=[People personWithName:@"Jack"];
    People *person5=[People personWithName:@"Jerry"];
    People *person6=[People personWithName:@"Tom"];
    People *person7=[People personWithName:@"Terry"];
    NSArray *array6=[NSArray arrayWithObjects:person4,person5,person6,person7, nil];
    //定义一个排序描述
    NSSortDescriptor *personName=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *accountBalance=[NSSortDescriptor sortDescriptorWithKey:@"account.balance" ascending:YES];
    NSArray *des=[NSArray arrayWithObjects:personName,accountBalance, nil];//先按照person的name排序再按照account的balance排序
    NSArray *array7=[array6 sortedArrayUsingDescriptors:des];
    NSLog(@"%@",array7);
    /*结果：
     (
     "name=Jack",
     "name=Jerry",
     "name=Terry",
     "name=Tom"
     )
     */
}



@end

@interface People ()

@property (nonatomic) BOOL sex;

@end

@implementation People

- (NSString *)description{
    return  self.name;
}

+(instancetype)personWithName:(NSString *)name {
    
    return [[self alloc]initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)show:(People*)ss {
    DLog(@"%@",ss.name);
    DLog(@"%@",self.name);

}

- (void)showMess:(id)object {
    DLog(@"%@:%@",self.name, object);
}

@end




