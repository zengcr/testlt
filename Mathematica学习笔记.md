## Wolfram语言：快速编程入门
#### QA部分
- ->代表什么意思？
- FullForm 总是显示底层结构；Head 总是给出一个表达式的标头；Length 给出参数数目.
- 使用 == 获取完整的 Wolfram|Alpha 报告，什么是Wolfram|Alpha?
- 关联的使用方法？
- 向量叉乘的意义？




#### 常用语法
- % 指定最近的输出
- 函数参数始终用,分隔
- 列表在 Wolfram 语言中由{ ... }表示
- =是立即赋值；：=是延迟赋值
- /. 表示 “全部替代”
- /;表示限制定义，使其适用于某种条件
- :> 是一个延迟规则；类似于规则中的 :=
- 纯函数：由&结尾，第一个参数由#指明
- 将一个函数“映射”到多个表达式，Map,/@ 是Map的简写形式  
  Apply 将一个函数应用于多个参数
  1. Map默认在第一层操作
  2. @@ 等价于Apply，默认在第0层操作
  3. @@@ 是指在第一层应用
  4. @ 是指普通函数应用 （前缀）
  5. // 是后缀函数的应用
- 交互式界面：
    1. Manipulate
    2. TabView
    3. Button
    4. Dynamic
- 字符串使用双引号指定；<> 连接字符串
- % 代表最近的输出；%n 代表结果 Out[n].
- 使用 CMD+L 复制最近的输入到当前输入.
- 若在行尾使用 ";" 则不会显示输出
- 使用 Short 获取输出的简短摘要
- 如果你需要结束计算，选择菜单选项放弃计算，或按 CMD + .（Mac）或 ALT + .
- Import 与 Export 自动处理来自文件、程序、网页等的数百种格式

## Wolfram语言的语法

- 运算符 // 的优先级别相当低
- 运算符 @ 的优先级别较高

## Wolfram 语言的四种括号
- (term)	表示组合的圆括号
- f[x]	表示函数的方括号
- {a,b,c}	表示列表的花括号
- v[[i]]	表示索引的双括号 （Part[v,i]）
- *当输入的表达式较为复杂时，在括号之间留出一些间隔是比较好的. 这可以更容易分清相匹配的括号对*

## 输入技巧
- 输入>=可输入≥
- 输入&& 表示 And
- 键入ESC deg ESC 可输入角度符号
- 键入ESC pi ESC 来输入 π 字符
- 键入ESC th ESC 可得到 θ 字符
- 键入 -> 可得到 → 符号
- 键入ESC inf ESC 可得到 ∞ 符号
- 键入ESC intt ESC 可得到一个可填充的数学表达式
- 键入ESC dintt ESC 可得到定积分表达式，并指定上下限
- 键入ESC sumt ESC 可得到填充的排版形式
- 键入ESC pd ESC 可以输入偏导数
- CTRL + - 产生下标
- 键入ESC dd ESC 可得到d
- 键入ESC cross ESC 得到叉乘符号
- 键入ESC grad ESC 可得到梯度符号
- 键入ESC co ESC 可得到 Conjugate 符号（共轭的）
- 键入ESC ue ESC 得到UndirectedEdge，或用 ESC de ESC 输入 DirectedEdge
- 键入ESC dist ESC 可得到
- 键入ESC m ESC 可得到 μ,或键入ESC s ESC 得到σ

## 面向数学学习的快速入门指南
1. 代数
    -  Factor 因式分解或展开
    -  Solve 解方程的精确解
    -  NSolve 近似解
    -  Roots 求方程的根
    -  NRoots 近似根
    -  Reduce 把不等式化简
    -  NumberLinePlot 将结果可视化
2. 二维绘图
    -  Plot 二维曲线
    -  RegionPlot 二维区域
    -  Show 组合不同的绘图类型
3. 几何
    -  Graphics 生成二维形状
    -  SASTriangle 生成三角形
    -  Area 计算面积
    -  Graphics3D 显示三维物体
    -  Volume 计算体积
    -  Rotate 几何变换
4. 三角函数
    -  Arc 求反函数
    -  TrigExpand 展开三解表达式
    -  TrigFactor 因式分解三角多项式
5. 极坐标
    -  PolarPlot 极坐标绘图
    -  ToPolarCoordinates 把直角坐标转换成极从标
6. 指数和对数
    -  E 表示指数常数
    -  Log 自然对数
    -  LogPlot 在对数刻度上绘图
    -  LogLogPlot 把两个坐标轴都设成对数刻度
7. 极限
    -  Limit 求极限值
    -  设置为1时从左侧逼近极限
    -  设置为-1时从右侧逼近极限
    -  用HoldForm将表达式保持为未计算状态
    -  TraditionalForm 用传统的数学排版形式显示
8. 导数
    -  D 计算导数，或者使用角分符号
    -  Plot 绘制导数
    -  可多次求导
9. 积分
    -  Integrate 积分
    -  NIntegrate 近似数值
10. 序列、求和与级数
    -  Table 定义一个简单的序列
    -  RecurrenceTable 定义递归序列
    -  Total 计算和
    -  Sum 根据母函数计算序列的和
    -  FindSequenceFunction 计算序列的母函数
    -  Series 生成几乎任意内置函数的组合的幂级数近似
        -  O[x]9 表示省略掉的更高次数的项；用 Normal 来截断这些项
        -  给定一个未知或未定义的函数，Series 返回用导数表示的幂级数
    -  系统可自动化简收敛级数
11. 更多二维绘图
    -  ParametricPlot 绘制一组参数方程
    -  ContourPlot  等高线
    -  DensityPlot 绘制连续形式的图
12. 三维绘图
    -  Plot3D 绘制三维的笛卡尔曲线或曲面
    -  ParametricPlot3D 绘制三维空间曲线
    -  SphericalPlot3D 在球面坐标系中绘图
    -  RevolutionPlot3D 通过绕轴旋转一个表达式构建曲面
13. 多变量微积分
    -  D 可用于求偏导数，只需指定对哪个或哪些变量求导
14. 矢量分析与可视化
    -  长度为n的列表表示n维矢量
    -  Norm 计算模
    -  Projection 在某个轴的投影
    -  VectorAngle 求两个矢量的夹角
    -  计算矢量的梯度
    -  Div 计算向量场的散度或旋度
    -  可视化向量场的二维和三维函数
        -  VectorPlot 二维可视化
        -  VectorPlot3D 三维可视化
    -  SliceVectorPlot3D 在切片曲面上绘制向量场
15. 微分方程  
    Wolfram语言可以求解常微分方程、偏微分方程和时滞微分方程（ODE、PDE、DDE）
    -  DSolveValue 接受微分方程并返回通解
    -  NDSolveValue 可求出数值解，可用Plot直接绘制InterpolatingFunction
    -  如果想要求解微分方程组，把所有方程和条件都放在列表中（注意：换行符没有任何影响）
    - ParametricPlot 用参数图可视化解
16. 复分析
    - ComplexExpand 展开复数表达式
    - ExpToTrig 指数形式转化为三解函数形式
    - TrigToExp 三解函数形式转化为指数形式
    - ReIm 提取表达式的实部和虚部
    - AbsArg 求绝对值和辐角
    - ParametricPlot 绘制保角映射
    - PolarPlot使用AbsArg
    - DensityPlot 可视化复分量
17. 矩阵与线性代数  
    Wolfram语言用列表的列表表示矩阵
    - 用“CTRL + ENTER” 输入行，用“CTRL + ,”输入列
    - MatrixForm 将输出显示为一个矩阵
    - 可用迭代函数构建矩阵，或导入表示矩阵的数据
    - IdentityMatrix、DiagonalMatrix和其他类似命令为内置符号
    - 矩阵运算
        - 标准的矩阵运算
        - 点积
        - Det 求行列式
        - Inverse 求矩阵的逆
    - LinearSolve 求解线性系统
    - 还有用于最小化和矩阵分解的函数
18. 离散数学  
    进行基本的数论运算，
    - FactorInteger 因子分解 
    - GCD 求两个整数的最大公约数或最小公倍数
    - Prime 显示第几个质数
    - PrimeQ 判断一个数是否是质数
    - CoprimeQ 进行互质判定
    - Mod 函数求余数
    - Permutations 获取一个列表的所有可能的排列
    - Permute 用不相交Cycles 对列表应用Permute
    - PermutationOrder 求置换除数
    - Graph 根据边的列表生成Graph
    - FindShortestPath 求两个顶点间的最短路径
19. 概率
    - ！ 用数学符号计算阶乘
    - Binomial 组合
    - Probability 计算二项分布的概率
    - Expectation 计算多项式的期望
    - PDF[NormalDistribution] 获取正态分布的符号式PDF 可用Plot对结果绘图
20. 统计 
    在Wolfram语言中，统计函数可接受列表或符号分布作为参数
    - Mean 计算均值
    - Correlation 求多个列表的相关
    - StandardDeviation[PoissonDistribution] 求泊松分布的标准差
    - Moment 计算一组符号的矩
    - MomentGeneratingFunction[NormalDistribution] 获取分布的矩母函数
    - RandomVariate[NormalDistribution] 产生统计数据
    - Histogram3D 可视化所得数据
21. 绘制数据与最佳拟合曲线
    - ListPlot 绘制数据点
    - BarChart 用图表显示信息
    - 用专门的函数绘制时间序列、金融数据，还有许多其他绘图函数
    - ListLinePlot 自动对多个数据集添加不同的颜色以示区分
    - Fit 找到最佳拟合曲线
    - Show 将曲线与数据点相比较
21. 数学排版显示
    - 使用 TraditionalForm 命令以传统数学符号显示任意表达式
    - 用 SHIFT+CMD+T 把现有单元转换成 TraditionalForm