//
//  NSObject+KVO.m
//  ImplementKVO
//
//  Created by Peng Gu on 2/26/15.
//  Copyright (c) 2015 Peng Gu. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString *const kPGKVOClassPrefix = @"PGKVOClassPrefix_";
NSString *const kPGKVOAssociatedObservers = @"PGKVOAssociatedObservers";

//KVO (原Demo地址   https://github.com/okcomp/ImplementKVO)
//我只是在原来的基础上加上了注释 方便自己学习


#pragma mark - PGObservationInfo
@interface PGObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) PGObservingBlock block;

@end

@implementation PGObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(PGObservingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end


#pragma mark - Debug Help Methods
static NSArray *ClassMethodNames(Class c)
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++) {
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    
    return array;
}


static void PrintDescription(NSString *name, id obj)
{
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\tNSObject class %s\n\tRuntime class %s\n\timplements methods <%@>\n\n",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n", [str UTF8String]);
}


#pragma mark - Helpers
static NSString * getterForSetter(NSString *setter)
{
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}


static NSString * setterForGetter(NSString *getter)
{
    if (getter.length <= 0) {
        return nil;
    }
    // upper case the first letter
    //取出首字母 并且大写
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    //取出余下字符串
    NSString *remainingLetters = [getter substringFromIndex:1];
    // add 'set' at the begining and ':' at the end
    // eg:把 method 修改为 setMethod:
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    return setter;
}


#pragma mark - Overridden Methods
static void kvo_setter(id self, SEL _cmd, id newValue)
{
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // look up observers and call the blocks
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kPGKVOAssociatedObservers));
    for (PGObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
    NSLog(@"setterName = %@",setterName);
    NSLog(@"getterName = %@",getterName);
    NSLog(@"oldValue = %@",oldValue);
    NSLog(@"newValue = %@",newValue);



}


static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}


#pragma mark - KVO Category
@implementation NSObject (KVO)

- (void)PG_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(PGObservingBlock)block
{
    //setterForGetter 通过要观察的 key 组装 set方法字符串
    //NSSelectorFromString 通过字符串 生成 SEL
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    //class_getInstanceMethod 通过SEL 获取 [self class] 实例方法 Method
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    //如果实例方法不存在
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        
        return;
    }
    //1,取的当前类
    Class clazz = object_getClass(self);
    //2，根据类得到类名称的字符串
    NSString *clazzName = NSStringFromClass(clazz);
    
    // if not an KVO class yet
    //3,判断类名称是否包含 kPGKVOClassPrefix
    //判断KVO子类是否创建
    if (![clazzName hasPrefix:kPGKVOClassPrefix]) {
        //如果不包含，创建当前类的子类 用于KVO
        clazz = [self makeKvoClassWithOriginalClassName:clazzName];
        
        //将self isa 指向 clazz
        
        //这可以用在Key Value Observing。当你开始observing an object时，Cocoa会创建这个object的class的subclass，然后将这个object的isa指向新创建的subclass。
        //  http://blog.jobbole.com/45963/
        
        //简单粗暴的理解就是 建立一个子类，替代现有父类
        //把当前类实例self，指向子类clazz
        
         /**
         * Sets the class of an object.
         *
         * @param obj The object to modify.
         * @param cls A class object.
         *
         * @return The previous value of \e object's class, or \c Nil if \e object is \c nil.
         */
        
        object_setClass(self, clazz);
    }
    
    // add our kvo setter if this class (not superclasses) doesn't implement the setter?
    
    //判断是否已经创建 新的set 方法
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        //创建新的set方法 替换原有的方法
        
        //class_addMethod的4个参数分别添加方法的目标类、新方法的选择器、函数的地址（数据类型为IMP）和描述方法参数的数据类型的字符串（字符串里的内容分别依次为函数返回值类型和每个参数类型，在这里v表示void，@表示selector，：表示IMP）
        //http://blog.csdn.net/lvmaker/article/details/32396167
        
        // setterSelector 方法名
        //(IMP)kvo_setter setterSelector 的具体实现！！！！！！
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
    
    PGObservationInfo *info = [[PGObservationInfo alloc] initWithObserver:observer Key:key block:block];
    
    //关联对象
    //objc_getAssociatedObject 相当于get方法读取
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kPGKVOAssociatedObservers));
    if (!observers) {
        //如果没有 objc_setAssociatedObject 相当于调用set方法
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kPGKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //加入数组
    [observers addObject:info];
}


- (void)PG_removeObserver:(NSObject *)observer forKey:(NSString *)key
{
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kPGKVOAssociatedObservers));
    
    PGObservationInfo *infoToRemove;
    for (PGObservationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    
    [observers removeObject:infoToRemove];
}


- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName
{
    //拼接 kPGKVOClassPrefix 作为子类名称
    NSString *kvoClazzName = [kPGKVOClassPrefix stringByAppendingString:originalClazzName];
    //由 字符串 得到类名称
    Class clazz = NSClassFromString(kvoClazzName);
    //如果clazz类存在 直接返回 clazz
    if (clazz) {
        return clazz;
    }
    
    //如果clazz 不存在  创建 注册
    //为了创建一个新类，我们需要调用objc_allocateClassPair。然后使用诸如class_addMethod，class_addIvar等函数来为新创建的类添加方法、实例变量和属性等。完成这些后，我们需要调用objc_registerClassPair函数来注册类，之后这个新类就可以在程序中使用了。

    // class doesn't exist yet, make it
    //取得当前类
    Class originalClazz = object_getClass(self);
    //创建 kvoClazzName 类 并且把originalClazz 当做父类
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    // grab class method's signature so we can borrow it
    //获取实例方法 class
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    // class_addMethod的4个参数分别添加方法的目标类、新方法的选择器、函数的地址（数据类型为IMP）和描述方法参数的数据类型的字符串（字符串里的内容分别依次为函数返回值类型和每个参数类型，在这里v表示void，@表示selector，：表示IMP）
    //下面代码的意思 就是为kvoClazz添加一个class方法，具体的实现是(IMP)kvo_class
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    objc_registerClassPair(kvoClazz);
    return kvoClazz;
}


- (BOOL)hasSelector:(SEL)selector
{
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    //class_copyMethodList 取得clazz方法列表
    Method* methodList = class_copyMethodList(clazz, &methodCount);
    //判断selector 是否已经存在
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    
    free(methodList);
    return NO;
}


@end




