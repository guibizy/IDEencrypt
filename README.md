IDE加密解密
====
1.将IDE文件夹导入工程<br>
2.在需要加密的地方
```Objective-c
#import "NSString+IDEA.h"
```
3.直接调用方法调用
```Objective-c
[self.textfield1.text stringWithStrToIDEA]//加密
[self.textfield1.text stringWithIDEAToStr]//解密
```
