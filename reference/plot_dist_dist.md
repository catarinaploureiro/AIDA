# Distance-Distance plot for interval-valued data.

Distance-Distance plot for interval-valued data.

## Usage

``` r
plot_dist_dist(
  class_dist,
  class_cutoff = NULL,
  class_cutoff_label = NULL,
  rob_dist,
  rob_cutoff = NULL,
  rob_cutoff_label = NULL,
  obs_names = NULL,
  ggplotly = TRUE,
  color_class = NULL,
  color_label = NULL,
  palette = NULL,
  shape_class = NULL,
  shape_label = NULL,
  label_obs = NULL
)
```

## Arguments

- class_dist:

  A numeric vector containing the classical distances for each
  observation.

- class_cutoff:

  Numeric. The cutoff value for the classical distances.

- class_cutoff_label:

  Character. Label for the classical cutoff. If NULL (default), no
  legend for the classical cutoff is shown.

- rob_dist:

  A numeric vector containing the robust distances for each observation.

- rob_cutoff:

  Numeric. The cutoff value for the robust distances.

- rob_cutoff_label:

  Character. Label for the robust cutoff. If NULL (default), no legend
  for the robust cutoff is shown.

- obs_names:

  A character vector containing the names of the observations. If NULL
  (default), the names are taken from the names of class_dist.

- ggplotly:

  Logical. If `TRUE` (default), the plot is converted to an interactive
  [plotly::plotly](https://rdrr.io/pkg/plotly/man/plotly.html) object.

- color_class:

  A vector indicating the color class of each observation. If NULL
  (default), all points have the same color.

- color_label:

  Character. Label for the color class. If NULL (default), no legend for
  the color class is shown.

- palette:

  A vector with colors for each color class. If NULL (default), default
  [ggplot2::ggplot2](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)
  colors are used.

- shape_class:

  A vector indicating the shape class of each observation. If NULL
  (default), all points have the same shape.

- shape_label:

  Character. Label for the shape class. If NULL (default), no legend for
  the shape class is shown.

- label_obs:

  A vector with the names of the observations to be labeled in the plot
  when `ggplotly = FALSE`. Default is NULL.

## Value

Returns a Distance-Distance plot that displays the classical distances
against the robust distances for each observation, highlighting
outliers.

## Examples

``` r
#Create intData object
data(creditcard)
credit_card_int <- creditcard$intData

#Estimate the mean and covariance matrix
credit_card_IMCD<-IMCD(credit_card_int, floor(nrow(credit_card_int)*0.75), "farness", 0.9)
credit_card_outliers <- int_outliers(credit_card_IMCD$robust_dist, 
                                           p=credit_card_int@NIVar, cutoff_lvl = 0.9)

#Plot Distance-Distance plot
class_dist <- IMah_dist(credit_card_int, z=rep(1,credit_card_int@NObs))
class_outliers <- int_outliers(class_dist,cutoff = "adjbox",p=p,cutoff_lvl = 1.5)
credit_card_is_outliers <- as.character(credit_card_outliers$is_outlier)
credit_card_is_outliers[credit_card_outliers$is_outlier] <- "Outlier"
credit_card_is_outliers[!credit_card_outliers$is_outlier] <- "Inlier"
plot_dist_dist(class_dist, class_outliers$cutoff_value[2], "1.5 adjusted boxplot",
              credit_card_IMCD$robust_dist, credit_card_outliers$cutoff_value, "0.9 farness",
              color_class = credit_card_is_outliers, palette = c("grey50", "red"))

{"x":{"data":[{"x":[3.6098790192596044,5.6491204129414214,2.3019637429620072,8.6428872342650997,4.4960029041148113,5.7112676276635774,2.8191262118888729,2.4421048405887253,3.3606434860194434,2.3734049026763007,3.0105572349382554,9.6919899536054821,4.2524086680495552,6.7882651540162735,5.9320702139886015,4.6618088960477619,6.1275515370483937,3.9828262461082078,5.4259436453584193,3.8986145881111991,2.8361494390274875,2.2020484332224441,2.6333619120373482,5.4315524792188468,7.2189376412495188,7.0207783391727725,5.3766677860883147,3.642092921895554,3.0772570831946258,2.0769978052422013,2.0788409440376454,3.9305502663945142],"y":[3.3377293378196256,5.3008091903231627,4.0274070377846938,9.8638697329134288,9.545016968421999,5.9787107707092293,2.9730044755637133,2.1519656068253248,3.1789932951387301,2.509524154557206,3.372456169508343,9.8172029490732893,4.0350654554526857,10.838252709688922,24.876487776970528,22.97399221834106,6.2046215886245992,5.2759626933265311,6.6865632408466178,3.4180377972843257,3.1553979609218974,2.3754336178356352,3.0921244002948756,6.0978723018592431,7.0732880148366455,8.5159277205002208,5.6522098994850944,3.9728309156819037,3.6081692867381556,2.0615307364125615,1.7154418189550982,4.1645801526186652],"text":["Classical:  3.609879<br />Robust:  3.337729<br />Name: 1_1","Classical:  5.649120<br />Robust:  5.300809<br />Name: 1_2","Classical:  2.301964<br />Robust:  4.027407<br />Name: 1_3","Classical:  8.642887<br />Robust:  9.863870<br />Name: 1_4","Classical:  4.496003<br />Robust:  9.545017<br />Name: 1_5","Classical:  5.711268<br />Robust:  5.978711<br />Name: 1_6","Classical:  2.819126<br />Robust:  2.973004<br />Name: 1_9","Classical:  2.442105<br />Robust:  2.151966<br />Name: 1_10","Classical:  3.360643<br />Robust:  3.178993<br />Name: 1_11","Classical:  2.373405<br />Robust:  2.509524<br />Name: 1_12","Classical:  3.010557<br />Robust:  3.372456<br />Name: 2_1","Classical:  9.691990<br />Robust:  9.817203<br />Name: 2_2","Classical:  4.252409<br />Robust:  4.035065<br />Name: 2_3","Classical:  6.788265<br />Robust: 10.838253<br />Name: 2_4","Classical:  5.932070<br />Robust: 24.876488<br />Name: 2_5","Classical:  4.661809<br />Robust: 22.973992<br />Name: 2_8","Classical:  6.127552<br />Robust:  6.204622<br />Name: 2_9","Classical:  3.982826<br />Robust:  5.275963<br />Name: 2_10","Classical:  5.425944<br />Robust:  6.686563<br />Name: 2_11","Classical:  3.898615<br />Robust:  3.418038<br />Name: 2_12","Classical:  2.836149<br />Robust:  3.155398<br />Name: 3_1","Classical:  2.202048<br />Robust:  2.375434<br />Name: 3_2","Classical:  2.633362<br />Robust:  3.092124<br />Name: 3_3","Classical:  5.431552<br />Robust:  6.097872<br />Name: 3_4","Classical:  7.218938<br />Robust:  7.073288<br />Name: 3_5","Classical:  7.020778<br />Robust:  8.515928<br />Name: 3_6","Classical:  5.376668<br />Robust:  5.652210<br />Name: 3_7","Classical:  3.642093<br />Robust:  3.972831<br />Name: 3_8","Classical:  3.077257<br />Robust:  3.608169<br />Name: 3_9","Classical:  2.076998<br />Robust:  2.061531<br />Name: 3_10","Classical:  2.078841<br />Robust:  1.715442<br />Name: 3_11","Classical:  3.930550<br />Robust:  4.164580<br />Name: 3_12"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(127,127,127,1)","opacity":1,"size":11.338582677165356,"symbol":"circle","line":{"width":1.8897637795275593,"color":"rgba(127,127,127,1)"}},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[10.634772863488102,10.397716468707296,6.6494014305931319,9.6144376667757339],"y":[61.914663169214556,40.349614642637093,31.14018666560365,45.112985706671523],"text":["Classical: 10.634773<br />Robust: 61.914663<br />Name: 1_7","Classical: 10.397716<br />Robust: 40.349615<br />Name: 1_8","Classical:  6.649401<br />Robust: 31.140187<br />Name: 2_6","Classical:  9.614438<br />Robust: 45.112986<br />Name: 2_7"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(255,0,0,1)","opacity":1,"size":11.338582677165356,"symbol":"circle","line":{"width":1.8897637795275593,"color":"rgba(255,0,0,1)"}},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[18.125113397368192,18.125113397368192],"y":[-1.2945192485578749,64.924624236727524],"text":"x: 18.12511","type":"scatter","mode":"lines","line":{"width":1.8897637795275593,"color":"rgba(0,0,0,1)","dash":"dash"},"hoveron":"points","name":"1.5 adjusted boxplot","legendgroup":"1.5 adjusted boxplot","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1.2745920256359016,18.927519176974492],"y":[27.158181730519885,27.158181730519885],"text":"y: 27.15818","type":"scatter","mode":"lines","line":{"width":1.8897637795275593,"color":"rgba(0,0,0,1)","dash":"dot"},"hoveron":"points","name":"0.9 farness","legendgroup":"0.9 farness","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":23.305936073059364,"r":7.3059360730593621,"b":41.245330012453302,"l":41.245330012453302},"plot_bgcolor":"rgba(255,255,255,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1.2745920256359016,18.927519176974492],"tickmode":"array","ticktext":["5","10","15"],"tickvals":[5,10,15],"categoryorder":"array","categoryarray":["5","10","15"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176002,"zeroline":false,"anchor":"y","title":{"text":"<b> Squared Classical Distance <\/b>","font":{"color":"rgba(0,0,0,1)","family":"","size":18.596928185969279}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-1.2945192485578749,64.924624236727524],"tickmode":"array","ticktext":["0","20","40","60"],"tickvals":[0,20,40,60],"categoryorder":"array","categoryarray":["0","20","40","60"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176002,"zeroline":false,"anchor":"x","title":{"text":"<b> Squared Robust Distance <\/b>","font":{"color":"rgba(0,0,0,1)","family":"","size":18.596928185969279}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":"rgba(255,255,255,1)","line":{"color":"rgba(51,51,51,1)","width":0.66417600664176002,"linetype":"solid"},"yref":"paper","xref":"paper","layer":"below","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.8897637795275593,"font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243},"orientation":"h","x":0.5,"y":1.02,"xanchor":"center","yanchor":"bottom","title":{"text":"Cutoff","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724}}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"197926f6fc6d":{"x":{},"y":{},"label":{},"colour":{},"type":"scatter"},"19793c9ba5d9":{"xintercept":{},"linetype":{}},"19797bacaa3c":{"yintercept":{},"linetype":{}}},"cur_data":"197926f6fc6d","visdat":{"197926f6fc6d":["function (y) ","x"],"19793c9ba5d9":["function (y) ","x"],"19797bacaa3c":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
