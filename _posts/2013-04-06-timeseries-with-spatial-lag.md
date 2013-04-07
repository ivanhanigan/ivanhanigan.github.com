--- 
name: timeseries-with-spatial-lag
layout: post
title:  Timeseries with Spatial Lag 
date: 2013-04-06
categories: 
- spatial dependence
---

<head>
<title>adjacency example </title>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1"/>
<meta name="title" content="adjacency example "/>
<meta name="generator" content="Org-mode"/>
<meta name="generated" content="2013-04-06 09:34:17 EST"/>
<meta name="author" content="Ivan Hanigan"/>
<meta name="description" content=""/>
<meta name="keywords" content=""/>
<style type="text/css">
 <!--/*--><![CDATA[/*><!--*/
  html { font-family: Times, serif; font-size: 12pt; }
  .title  { text-align: center; }
  .todo   { color: red; }
  .done   { color: green; }
  .tag    { background-color: #add8e6; font-weight:normal }
  .target { }
  .timestamp { color: #bebebe; }
  .timestamp-kwd { color: #5f9ea0; }
  .right  {margin-left:auto; margin-right:0px;  text-align:right;}
  .left   {margin-left:0px;  margin-right:auto; text-align:left;}
  .center {margin-left:auto; margin-right:auto; text-align:center;}
  p.verse { margin-left: 3% }
  pre {
	border: 1pt solid #AEBDCC;
	background-color: #F3F5F7;
	padding: 5pt;
	font-family: courier, monospace;
        font-size: 90%;
        overflow:auto;
  }
  table { border-collapse: collapse; }
  td, th { vertical-align: top;  }
  th.right  { text-align:center;  }
  th.left   { text-align:center;   }
  th.center { text-align:center; }
  td.right  { text-align:right;  }
  td.left   { text-align:left;   }
  td.center { text-align:center; }
  dt { font-weight: bold; }
  div.figure { padding: 0.5em; }
  div.figure p { text-align: center; }
  div.inlinetask {
    padding:10px;
    border:2px solid gray;
    margin:10px;
    background: #ffffcc;
  }
  textarea { overflow-x: auto; }
  .linenr { font-size:smaller }
  .code-highlighted {background-color:#ffff00;}
  .org-info-js_info-navigation { border-style:none; }
  #org-info-js_console-label { font-size:10px; font-weight:bold;
                               white-space:nowrap; }
  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;
                                 font-weight:bold; }
  /*]]>*/-->
</style>
<script type="text/javascript">
<!--/*--><![CDATA[/*><!--*/
 function CodeHighlightOn(elem, id)
 {
   var target = document.getElementById(id);
   if(null != target) {
     elem.cacheClassElem = elem.className;
     elem.cacheClassTarget = target.className;
     target.className = "code-highlighted";
     elem.className   = "code-highlighted";
   }
 }
 function CodeHighlightOff(elem, id)
 {
   var target = document.getElementById(id);
   if(elem.cacheClassElem)
     elem.className = elem.cacheClassElem;
   if(elem.cacheClassTarget)
     target.className = elem.cacheClassTarget;
 }
/*]]>*///-->
</script>
<script type="text/javascript" src="http://orgmode.org/mathjax/MathJax.js">
<!--/*--><![CDATA[/*><!--*/
    MathJax.Hub.Config({
        // Only one of the two following lines, depending on user settings
        // First allows browser-native MathML display, second forces HTML/CSS
        //  config: ["MMLorHTML.js"], jax: ["input/TeX"],
            jax: ["input/TeX", "output/HTML-CSS"],
        extensions: ["tex2jax.js","TeX/AMSmath.js","TeX/AMSsymbols.js",
                     "TeX/noUndefined.js"],
        tex2jax: {
            inlineMath: [ ["\\(","\\)"] ],
            displayMath: [ ['$$','$$'], ["\\[","\\]"], ["\\begin{displaymath}","\\end{displaymath}"] ],
            skipTags: ["script","noscript","style","textarea","pre","code"],
            ignoreClass: "tex2jax_ignore",
            processEscapes: false,
            processEnvironments: true,
            preview: "TeX"
        },
        showProcessingMessages: true,
        displayAlign: "center",
        displayIndent: "2em",

        "HTML-CSS": {
             scale: 100,
             availableFonts: ["STIX","TeX"],
             preferredFont: "TeX",
             webFont: "TeX",
             imageFont: "TeX",
             showMathMenu: true,
        },
        MMLorHTML: {
             prefer: {
                 MSIE:    "MML",
                 Firefox: "MML",
                 Opera:   "HTML",
                 other:   "HTML"
             }
        }
    });
/*]]>*///-->
</script>
</head>
<body>

<div id="preamble">

</div>

<div id="content">



<hr/>

<!-- <div id="table-of-contents"> -->
<!-- <h2>Table of Contents</h2> -->
<!-- <div id="text-table-of-contents"> -->
<!-- <ul> -->
<!-- <li><a href="#sec-1">1 Introduction</a></li> -->
<!-- <li><a href="#sec-2">2 Load some test data</a></li> -->
<!-- <li><a href="#sec-3">3 spdep calculates neighbours</a></li> -->
<!-- <li><a href="#sec-4">4 plot these</a></li> -->
<!-- <li><a href="#sec-5">5 function to return adjacency list as a dataframe</a></li> -->
<!-- <li><a href="#sec-6">6 test-adjacency df</a></li> -->
<!-- </ul> -->
<!-- </div> -->
<!-- </div> -->

<div id="outline-container-1" class="outline-2">
<h2 id="sec-1"><span class="section-number-2">1</span> Introduction</h2>
<div class="outline-text-2" id="text-1">

<p>I've got a timeseries model I am fitting to a city dataset with about 45 zones.
The data are daily, stratified by Zone, Age and Sex.
Following on from learning about spatiallly correlated errors I want to see if the Standard Error on the estimated \(\beta_{1}\) from the timeseries model is affected.
</p>
<p>
I think the simplest option is to use the spatial lag model, which can be fitted with just adding a term that is the average of the set of each Zone's neighbours outcome level on each day. For this I need to find the list of each region's neighbours.  Then I'll use this to assign each zone/day/age group their neighbours values and then collapse that to get their daily means.
</p></div>

</div>

<div id="outline-container-2" class="outline-2">
<h2 id="sec-2"><span class="section-number-2">2</span> Load some test data</h2>
<div class="outline-text-2" id="text-2">




<pre class="src src-R"><span style="color: #586e75;"># </span><span style="color: #586e75;">we have access to a classic dataset for studying spatial dependence</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">in the spdep package</span>
<span style="color: #268bd2; font-weight: bold;">require</span>(spdep)
<span style="color: #268bd2; font-weight: bold;">require</span>(rgdal)
<span style="color: #268bd2; font-weight: bold;">require</span>(maps)
fn <span style="color: #268bd2; font-weight: bold;">&lt;-</span> system.file(<span style="color: #2aa198;">"etc/shapes/eire.shp"</span>, package=<span style="color: #2aa198;">"spdep"</span>)[1]
prj <span style="color: #268bd2; font-weight: bold;">&lt;-</span> CRS(<span style="color: #2aa198;">"+proj=utm +zone=30 +units=km"</span>)
eire <span style="color: #268bd2; font-weight: bold;">&lt;-</span> readShapeSpatial(fn, ID=<span style="color: #2aa198;">"names"</span>, proj4string=prj)
str(eire)
<span style="color: #586e75;"># </span><span style="color: #586e75;">reproject into a better coordinate system</span>
eire <span style="color: #268bd2; font-weight: bold;">&lt;-</span> spTransform(eire, CRS(<span style="color: #2aa198;">"+proj=longlat +datum=WGS84"</span>))
<span style="color: #586e75;"># </span><span style="color: #586e75;">check out the attributes</span>
head(eire@data)

</pre>


<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption></caption>
<colgroup><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="right" /><col class="left" />
</colgroup>
<thead>
<tr><th scope="col" class="right">A</th><th scope="col" class="right">towns</th><th scope="col" class="right">pale</th><th scope="col" class="right">size</th><th scope="col" class="right">ROADACC</th><th scope="col" class="right">OWNCONS</th><th scope="col" class="right">POPCHG</th><th scope="col" class="right">RETSALE</th><th scope="col" class="right">INCOME</th><th scope="col" class="left">names</th></tr>
</thead>
<tbody>
<tr><td class="right">34.2</td><td class="right">0.12</td><td class="right">1</td><td class="right">1087</td><td class="right">3664</td><td class="right">8.6</td><td class="right">97</td><td class="right">2962</td><td class="right">7185</td><td class="left">Carlow</td></tr>
<tr><td class="right">29.68</td><td class="right">0.01</td><td class="right">0</td><td class="right">2133</td><td class="right">5000</td><td class="right">15</td><td class="right">69</td><td class="right">4452</td><td class="right">9459</td><td class="left">Cavan</td></tr>
<tr><td class="right">26.54</td><td class="right">0.01</td><td class="right">0</td><td class="right">535</td><td class="right">4321</td><td class="right">19</td><td class="right">78</td><td class="right">3460</td><td class="right">12435</td><td class="left">Clare</td></tr>
<tr><td class="right">23.92</td><td class="right">0.03</td><td class="right">0</td><td class="right">1476</td><td class="right">4118</td><td class="right">9</td><td class="right">90</td><td class="right">28402</td><td class="right">65901</td><td class="left">Cork</td></tr>
<tr><td class="right">27.91</td><td class="right">0.03</td><td class="right">0</td><td class="right">989</td><td class="right">7500</td><td class="right">27</td><td class="right">75</td><td class="right">7478</td><td class="right">17626</td><td class="left">Donegal</td></tr>
<tr><td class="right">32.79</td><td class="right">0.61</td><td class="right">1</td><td class="right">18105</td><td class="right">3078</td><td class="right">9.4</td><td class="right">142</td><td class="right">89424</td><td class="right">164631</td><td class="left">Dublin</td></tr>
</tbody>
</table>



</div>

</div>

<div id="outline-container-3" class="outline-2">
<h2 id="sec-3"><span class="section-number-2">3</span> spdep calculates neighbours</h2>
<div class="outline-text-2" id="text-3">




<pre class="src src-R">nb <span style="color: #268bd2; font-weight: bold;">&lt;-</span> poly2nb(eire)
str(nb)
<span style="color: #586e75;">#</span><span style="color: #586e75;">List of 26</span>
nb[[1]]
<span style="color: #586e75;">#</span><span style="color: #586e75;">[1]  9 10 11 25 26</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">So this returns the set of index values for each area's neighbours</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">I'd prefer to read their names</span>
eire[[<span style="color: #2aa198;">'names'</span>]][1]
<span style="color: #586e75;"># </span><span style="color: #586e75;">&gt; [1] Carlow</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">so therefore the neighbours of area 1 "Carlow" are in the first</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">element of the list</span>
eire[[<span style="color: #2aa198;">'names'</span>]][nb[[1]]]
<span style="color: #586e75;"># </span><span style="color: #586e75;">&gt; [1] Kildare  Kilkenny Laoghis  Wexford  Wicklow</span>

</pre>



</div>

</div>

<div id="outline-container-4" class="outline-2">
<h2 id="sec-4"><span class="section-number-2">4</span> plot these</h2>
<div class="outline-text-2" id="text-4">




<pre class="src src-R"><span style="color: #586e75;">################################################################</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">name:plot these</span>
png(<span style="color: #2aa198;">"images/Fig1.png"</span>)
plot(eire)
plot(nb, coordinates(eire), add=<span style="color: #b58900;">TRUE</span>, pch=<span style="color: #2aa198;">"."</span>, lwd=2)
map.scale(ratio = F)
box()
dev.off()

</pre>


<p>
<img src="images/Fig1.png"  alt="images/Fig1.png" />
</p>
</div>

</div>

<div id="outline-container-5" class="outline-2">
<h2 id="sec-5"><span class="section-number-2">5</span> function to return adjacency list as a dataframe</h2>
<div class="outline-text-2" id="text-5">

<p>I THINK I actually want this as a dataframe so I can merge it with the master table of outcome data.
</p>



<pre class="src src-R"><span style="color: #586e75;">################################################################</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">name:adjacency_df</span>
<span style="color: #268bd2;">adjacency_df</span> <span style="color: #268bd2; font-weight: bold;">&lt;-</span> <span style="color: #859900; font-weight: bold;">function</span>(NB, shp, zone_id)
  {
    adjacencydf <span style="color: #268bd2; font-weight: bold;">&lt;-</span> as.data.frame(matrix(<span style="color: #b58900;">NA</span>, nrow = 0, ncol = 2))
    <span style="color: #859900; font-weight: bold;">for</span>(i <span style="color: #859900; font-weight: bold;">in</span> 1:length(NB))
    {
      <span style="color: #859900; font-weight: bold;">if</span>(length(shp[[zone_id]][NB[[i]]]) == 0) <span style="color: #859900; font-weight: bold;">next</span>
      adjacencydf <span style="color: #268bd2; font-weight: bold;">&lt;-</span> rbind(
                           adjacencydf,
                           cbind(
                                 as.character(shp[[zone_id]][i]),
                                 as.character(shp[[zone_id]][NB[[i]]])
                                 )
                           )
    }
    <span style="color: #859900; font-weight: bold;">return</span>(adjacencydf)
  }

</pre>


</div>

</div>

<div id="outline-container-6" class="outline-2">
<h2 id="sec-6"><span class="section-number-2">6</span> test-adjacency df</h2>
<div class="outline-text-2" id="text-6">




<pre class="src src-R"><span style="color: #586e75;">################################################################</span>
<span style="color: #586e75;"># </span><span style="color: #586e75;">name:adjacency_df</span>
adj <span style="color: #268bd2; font-weight: bold;">&lt;-</span> adjacency_df(NB = nb, shp = eire, zone_id = <span style="color: #2aa198;">'names'</span>)
adj  
</pre>


<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption></caption>
<colgroup><col class="left" /><col class="left" />
</colgroup>
<tbody>
<tr><td class="left">Carlow</td><td class="left">Kildare</td></tr>
<tr><td class="left">Carlow</td><td class="left">Kilkenny</td></tr>
<tr><td class="left">Carlow</td><td class="left">Laoghis</td></tr>
<tr><td class="left">Carlow</td><td class="left">Wexford</td></tr>
<tr><td class="left">Carlow</td><td class="left">Wicklow</td></tr>
<tr><td class="left">Cavan</td><td class="left">Leitrim</td></tr>
<tr><td class="left">Cavan</td><td class="left">Longford</td></tr>
<tr><td class="left">Cavan</td><td class="left">Meath</td></tr>
<tr><td class="left">Cavan</td><td class="left">Monaghan</td></tr>
<tr><td class="left">Cavan</td><td class="left">Westmeath</td></tr>
<tr><td class="left">Clare</td><td class="left">Galway</td></tr>
<tr><td class="left">Clare</td><td class="left">Limerick</td></tr>
<tr><td class="left">Clare</td><td class="left">Tipperary</td></tr>
<tr><td class="left">Cork</td><td class="left">Kerry</td></tr>
<tr><td class="left">Cork</td><td class="left">Limerick</td></tr>
<tr><td class="left">Cork</td><td class="left">Tipperary</td></tr>
<tr><td class="left">Cork</td><td class="left">Waterford</td></tr>
<tr><td class="left">Donegal</td><td class="left">Leitrim</td></tr>
<tr><td class="left">Dublin</td><td class="left">Kildare</td></tr>
<tr><td class="left">Dublin</td><td class="left">Meath</td></tr>
<tr><td class="left">Dublin</td><td class="left">Wicklow</td></tr>
<tr><td class="left">...</td><td class="left">Dataframe Truncated</td></tr>
</tbody>
</table>

</div>
</div>
</div>

</body>

