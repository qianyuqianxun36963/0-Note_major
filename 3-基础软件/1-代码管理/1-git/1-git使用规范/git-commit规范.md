# Git commit日志基本规范

## 格式模板
```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

## 说明：

type和subject 必需。


## 格式要求：
```
# 标题行：50个字符以内，描述主要变更内容
#
# 主体内容：更详细的说明文本，建议72个字符以内。 需要描述的信息包括:
#
# * 为什么这个变更是必须的? 它可能是用来修复一个bug，增加一个feature，提升性能、可靠性、稳定性等等
# * 他如何解决这个问题? 具体描述解决问题的步骤
# * 是否存在副作用、风险? 
#
# 尾部：如果需要的化可以添加一个链接到issue地址或者其它文档，或者关闭某个issue。
```

### type

**所有的 type 类型如下：**

* feat： 新增 feature
* fix: 修复 bug
* docs: 仅仅修改了文档，比如 README, CHANGELOG, CONTRIBUTE等等
* style: 仅仅修改了空格、格式缩进、逗号等等，不改变代码逻辑
* refactor: 代码重构，没有加新功能或者修复 bug
* perf: 优化相关，比如提升性能、体验
* test: 测试用例，包括单元测试、集成测试等
* chore: 改变构建流程、或者增加依赖库、工具等
* revert: 回滚到上一个版本

### scope
> scope用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。

### subject
> subject是 commit 目的的简短描述，不超过50个字符。
- 以动词开头，使用第一人称现在时，比如change，而不是changed或changes
- 第一个字母小写
- 结尾不加句号（.）

### Body
> 对本次 commit 的详细描述，可以分成多行。


## Git commit 参考

### Git commit 日志文本参考

```
docs: branding fixes (#14132)

Angular 1.x -> AngularJS
Angular 1 -> AngularJS
Angular2 -> Angular

I have deliberately not touched any of the symbol names as that would cause big merge collisions with Tobias's work.

All the renames are in .md, .json, and inline comments and jsdocs.

PR Close #14132
```

### Git commit 日志参考案例

* [angular](https://github.com/angular/angular)
* [commit-message-test-project](https://github.com/cpselvis/commit-message-test-project)
* [babel-plugin-istanbul](https://github.com/istanbuljs/babel-plugin-istanbul)
* [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog)




