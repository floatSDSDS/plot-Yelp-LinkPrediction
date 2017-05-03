- 首先要装一堆包

1. Yelp指标折线图
  - 打开`1 plot_evaluate.R`， 修改路径path，source code
  - 可调参数：
    - 输出文件名output.name
    - 输出文件长宽g.width; g.height，单位inch
    - 图片标题plot.title
    - 字体缩放倍率k
  - 输出结果在../plot/evaluation
2. 网络图
  - 打开`2 plot_graph_main.R`，更改设置，source code
  - 网络细节调整在`2 plot_graph.R`
  - 可调参数
    - 输出文件名output.name
    - 输出文件长宽g.width; g.height，单位inch
    - 字体缩放倍率k
    - 使用度还是权值进行过滤flag.deg=F（默认F为按权值过滤）
    - 按比例进行过滤的比例（过滤掉多少）theshold.quantiile，默认值0.98表示只保留最高的2%
  - 输出结果在../plot/graph
3. 核密度曲线
  - `3 plot_histogram_density.R`对应权值密度曲线
  - `3 plot_features_density.R`对应所有特征（包含权值）共20个密度曲线
  - 可调参数同1
  - 输出结果在../plot/density
4. 热力图
  - `4 heatmap.R` 更改路径，source code
  - 可调参数同1
  - 输出结果在../plot/heatmap
5. 热力图2
  - 打开`4.1.0 heatmap template.R`，更改路径，source code
  - 可调参数：
    - 昨天三幅图中对应三个模板，修改要画的模板序号，template.ith，c(无所谓长度)
    - 配色palette，默认"Greens"，可以查看`display.brewer.all()`和`brewer.pal.info`，选择自己喜欢的配色
    - 对应三个模板的输出文件长宽g.width,g.height，注意顺序对齐
    - 字体缩放倍率k
    - 一系列图片横纵坐标标签偏移量，角度调试参数，注意顺序对齐
    - colorbar的长宽，注意顺序对齐
    - 输出结果在../plot/heatmap/heatmap170502Selected
6. 六个数据集指标折线图
  - 打开 `5 six dataset main.R`，调整设定，source code
  - 图片细节在`5plot_evaluate_6dataset.R`
  - 可调参数同1
  - 输出结果在.../plot/evaluation
