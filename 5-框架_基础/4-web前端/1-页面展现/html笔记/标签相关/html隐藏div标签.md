## HTML 隐藏 div

div的visibility可以控制div的显示和隐藏，但是隐藏后页面显示空白: 
```
　　style="visibility: none;" 
　　document.getElementById("typediv1").style.visibility="hidden";//隐藏
　　document.getElementById("typediv1").style.visibility="visible";//显示
```

通过设置display属性可以使div隐藏后释放占用的页面空间，如下
```
　　style="display: none;"
　　document.getElementById("typediv1").style.display="none";//隐藏
　　document.getElementById("typediv1").style.display="";//显示
```
