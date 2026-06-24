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
  [plotly](https://rdrr.io/pkg/plotly/man/plotly.html) object.

- color_class:

  A vector indicating the color class of each observation. If NULL
  (default), all points have the same color.

- color_label:

  Character. Label for the color class. If NULL (default), no legend for
  the color class is shown.

- palette:

  A vector with colors for each color class. If NULL (default), default
  [ggplot2](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)
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
# Create intData object
data(creditcard)
credit_card_int <- creditcard$intData

# Compute robust distances using IMCD estimates of mean and covariance
credit_card_dist <- IMah_dist(credit_card_int)

# Detect outliers using farness cutoff
credit_card_outliers <- int_outliers(credit_card_dist, 
                                     cutoff = "farness", 
                                     cutoff_lvl = 0.9)

# Compute classical distances and outliers
class_dist <- IMah_dist(credit_card_int, z = rep(1,credit_card_int@NObs))
class_outliers <- int_outliers(class_dist, cutoff = "adjbox", p = p, cutoff_lvl = 1.5)

# Create a vector indicating if the observations are outliers or inliers 
# based on the robust distance outlier detection
credit_card_is_outliers <- as.character(credit_card_outliers$is_outlier)
credit_card_is_outliers[credit_card_outliers$is_outlier] <- "Outlier"
credit_card_is_outliers[!credit_card_outliers$is_outlier] <- "Inlier"

# Plot Distance-Distance plot 
plot_dist_dist(class_dist, 
               class_cutoff = class_outliers$cutoff_value[2], 
               class_cutoff_label = "1.5 adjusted boxplot",
               rob_dist = credit_card_dist, 
               rob_cutoff = credit_card_outliers$cutoff_value, 
               rob_cutoff_label = "0.9 farness",
               color_class = credit_card_is_outliers, 
               palette = c("grey50", "red"))

{"x":{"data":[{"x":[3.6098790192595911,5.6491204129414054,2.3019637429620037,8.642887234265098,4.4960029041148095,5.7112676276636085,2.8191262118888814,2.4421048405887218,3.3606434860194372,2.3734049026762976,3.0105572349382608,9.6919899536054857,4.2524086680495596,6.7882651540162957,5.9320702139885837,6.6494014305931071,4.6618088960477806,6.127551537048423,3.9828262461082011,5.4259436453584202,3.8986145881112084,2.8361494390274897,2.2020484332224424,2.6333619120373495,5.4315524792188832,7.2189376412495685,7.0207783391727672,5.3766677860883121,3.6420929218955433,3.0772570831946262,2.0769978052421965,2.0788409440376419,3.9305502663945027],"y":[3.4595294542781776,5.3889515660109826,3.0443686312225751,9.3032175955542815,4.4115492232336235,5.8405700101606381,2.851778384889315,2.3229821085832452,3.3861925060612386,2.3997590837511069,3.3719465595433924,9.5730333393941844,4.2875351934763248,8.594364951667103,8.1055751649632999,9.678324830809542,9.1849843169134182,6.7785433239418671,4.3274588165532322,6.7527801032522161,3.6923112533871372,2.7298272072574918,2.1358076280804088,2.6559108215444356,5.9992378472747889,7.6040585544656114,6.7093271445533436,5.1110158434934085,3.4433650326685452,3.4112975809252206,2.1604939584452252,1.8781773404252076,4.4057246232203529],"text":["Classical:  3.609879<br />Robust:  3.459529<br />Name: 1_1","Classical:  5.649120<br />Robust:  5.388952<br />Name: 1_2","Classical:  2.301964<br />Robust:  3.044369<br />Name: 1_3","Classical:  8.642887<br />Robust:  9.303218<br />Name: 1_4","Classical:  4.496003<br />Robust:  4.411549<br />Name: 1_5","Classical:  5.711268<br />Robust:  5.840570<br />Name: 1_6","Classical:  2.819126<br />Robust:  2.851778<br />Name: 1_9","Classical:  2.442105<br />Robust:  2.322982<br />Name: 1_10","Classical:  3.360643<br />Robust:  3.386193<br />Name: 1_11","Classical:  2.373405<br />Robust:  2.399759<br />Name: 1_12","Classical:  3.010557<br />Robust:  3.371947<br />Name: 2_1","Classical:  9.691990<br />Robust:  9.573033<br />Name: 2_2","Classical:  4.252409<br />Robust:  4.287535<br />Name: 2_3","Classical:  6.788265<br />Robust:  8.594365<br />Name: 2_4","Classical:  5.932070<br />Robust:  8.105575<br />Name: 2_5","Classical:  6.649401<br />Robust:  9.678325<br />Name: 2_6","Classical:  4.661809<br />Robust:  9.184984<br />Name: 2_8","Classical:  6.127552<br />Robust:  6.778543<br />Name: 2_9","Classical:  3.982826<br />Robust:  4.327459<br />Name: 2_10","Classical:  5.425944<br />Robust:  6.752780<br />Name: 2_11","Classical:  3.898615<br />Robust:  3.692311<br />Name: 2_12","Classical:  2.836149<br />Robust:  2.729827<br />Name: 3_1","Classical:  2.202048<br />Robust:  2.135808<br />Name: 3_2","Classical:  2.633362<br />Robust:  2.655911<br />Name: 3_3","Classical:  5.431552<br />Robust:  5.999238<br />Name: 3_4","Classical:  7.218938<br />Robust:  7.604059<br />Name: 3_5","Classical:  7.020778<br />Robust:  6.709327<br />Name: 3_6","Classical:  5.376668<br />Robust:  5.111016<br />Name: 3_7","Classical:  3.642093<br />Robust:  3.443365<br />Name: 3_8","Classical:  3.077257<br />Robust:  3.411298<br />Name: 3_9","Classical:  2.076998<br />Robust:  2.160494<br />Name: 3_10","Classical:  2.078841<br />Robust:  1.878177<br />Name: 3_11","Classical:  3.930550<br />Robust:  4.405725<br />Name: 3_12"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(127,127,127,1)","opacity":1,"size":11.338582677165356,"symbol":"circle","line":{"width":1.8897637795275593,"color":"rgba(127,127,127,1)"}},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[10.634772863488209,10.397716468707326,9.6144376667757676],"y":[24.687425562884425,19.928684318554822,18.286475329599455],"text":["Classical: 10.634773<br />Robust: 24.687426<br />Name: 1_7","Classical: 10.397716<br />Robust: 19.928684<br />Name: 1_8","Classical:  9.614438<br />Robust: 18.286475<br />Name: 2_7"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(255,0,0,1)","opacity":1,"size":11.338582677165356,"symbol":"circle","line":{"width":1.8897637795275593,"color":"rgba(255,0,0,1)"}},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[18.125113397367986,18.125113397367986],"y":[0.73771492930224669,25.827887974007385],"text":"x: 18.12511","type":"scatter","mode":"lines","line":{"width":1.8897637795275593,"color":"rgba(0,0,0,1)","dash":"dash"},"hoveron":"points","name":"1.5 adjusted boxplot","legendgroup":"1.5 adjusted boxplot","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1.2745920256359069,18.927519176974275],"y":[13.283575028378772,13.283575028378772],"text":"y: 13.28358","type":"scatter","mode":"lines","line":{"width":1.8897637795275593,"color":"rgba(0,0,0,1)","dash":"dot"},"hoveron":"points","name":"0.9 farness","legendgroup":"0.9 farness","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":23.305936073059364,"r":7.3059360730593621,"b":41.245330012453302,"l":41.245330012453302},"plot_bgcolor":"rgba(255,255,255,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1.2745920256359069,18.927519176974275],"tickmode":"array","ticktext":["5","10","15"],"tickvals":[5,10,15],"categoryorder":"array","categoryarray":["5","10","15"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176002,"zeroline":false,"anchor":"y","title":{"text":"<b> Squared Classical Distance <\/b>","font":{"color":"rgba(0,0,0,1)","family":"","size":18.596928185969279}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.73771492930224669,25.827887974007385],"tickmode":"array","ticktext":["5","10","15","20","25"],"tickvals":[5,10,15,20,25],"categoryorder":"array","categoryarray":["5","10","15","20","25"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.68949771689498},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176002,"zeroline":false,"anchor":"x","title":{"text":"<b> Squared Robust Distance <\/b>","font":{"color":"rgba(0,0,0,1)","family":"","size":18.596928185969279}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":"rgba(255,255,255,1)","line":{"color":"rgba(51,51,51,1)","width":0.66417600664176002,"linetype":"solid"},"yref":"paper","xref":"paper","layer":"below","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.8897637795275593,"font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243},"orientation":"h","x":0.5,"y":1.02,"xanchor":"center","yanchor":"bottom","title":{"text":"Cutoff","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724}}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"1a5d204572ca":{"x":{},"y":{},"label":{},"colour":{},"type":"scatter"},"1a5d7a738d33":{"xintercept":{},"linetype":{}},"1a5d291b40b5":{"yintercept":{},"linetype":{}}},"cur_data":"1a5d204572ca","visdat":{"1a5d204572ca":["function (y) ","x"],"1a5d7a738d33":["function (y) ","x"],"1a5d291b40b5":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
