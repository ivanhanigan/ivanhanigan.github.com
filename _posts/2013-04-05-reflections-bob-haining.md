--- 
name: reflections-bob-haining
layout: post
title: Reflections on Spatial Regression Class with Prof Bob Haining
date: 2013-04-05
categories: 
- spatial dependence
---
<head>
<title>Reflections on a class with Prof Bob Haining</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta name="title" content="Reflections on a class with Prof Bob Haining"/>
<meta name="generator" content="Org-mode"/>
<meta name="generated" content="2013-04-05"/>
<meta name="author" content="ivan hanigan"/>
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



<!-- <div id="table-of-contents"> -->
<!-- <h2>Table of Contents</h2> -->
<!-- <div id="text-table-of-contents"> -->
<!-- <ul> -->
<!-- <li><a href="#sec-1">1 Introduction</a></li> -->
<!-- <li><a href="#sec-2">2 Beta is OK but SE may be biased</a></li> -->
<!-- <li><a href="#sec-3">3 The Spatial Error Model</a></li> -->
<!-- <li><a href="#sec-4">4 The Spatial Lag Model</a></li> -->
<!-- <li><a href="#sec-5">5 Spatially Lagged Independent Variable(s)</a></li> -->
<!-- <li><a href="#sec-6">6 Discussion</a></li> -->
<!-- </ul> -->
<!-- </div> -->
<!-- </div> -->

<div id="outline-container-1" class="outline-2">
<h2 id="sec-1"><span class="section-number-2">1</span> Introduction</h2>
<div class="outline-text-2" id="text-1">

<p>I recently attended a class on spatial regression with Prof Bob Haining.  
He described the issue of spatially correlated errors and the problems this poses.
</p>
<p>
Simplistically I took away the following messages:
</p>
</div>

</div>

<div id="outline-container-2" class="outline-2">
<h2 id="sec-2"><span class="section-number-2">2</span> Beta is OK but SE may be biased</h2>
<div class="outline-text-2" id="text-2">


<p>
A standard regression model assumes independent errors:
</p>


\(Y_{i} = \beta_{0} + \beta_{1} X_{1i} + e_{i}\)

<p>
But with spatial data it is likely that the errors are spatially correlated.  
This is likely to mean the point estimate of beta 1 is OK but the Standard Error is wrong.
</p>
</div>

</div>

<div id="outline-container-3" class="outline-2">
<h2 id="sec-3"><span class="section-number-2">3</span> The Spatial Error Model</h2>
<div class="outline-text-2" id="text-3">

<p>So we could model allowing for correlated errors:
</p>


\(Y_{i} = \beta_{0} + \beta_{1} X_{1i} + \eta_{i}\)

<p>
Where:
</p>
<p>
\(\eta_{i}\) = Spatially autocorrelated errors.
</p>
</div>

</div>

<div id="outline-container-4" class="outline-2">
<h2 id="sec-4"><span class="section-number-2">4</span> The Spatial Lag Model</h2>
<div class="outline-text-2" id="text-4">

<p>Or we could include a term for the neighbours, thus absorbing the correlated errors:
</p>


\(Y_{i} = \beta_{0} + \beta_{1} X_{1i} + \rho(Neighbours Y_{ij}) + e_{i}\)

<p>
Where:
</p>
<p>
\(\rho_(Neighbours Y_{ij})\) = is an additional explanatory variable which is the value of the dependent variable in neighbouring areas. 
</p>
</div>

</div>

<div id="outline-container-5" class="outline-2">
<h2 id="sec-5"><span class="section-number-2">5</span> Spatially Lagged Independent Variable(s)</h2>
<div class="outline-text-2" id="text-5">

<p>Then we could include a term for the exposure variable in the neighbours:
</p>


\(Y_{i} = \beta_{0} + \beta_{1} X_{1i} + \beta_{2L} X_{2ij} + e_{i}\)

<p>
Where:
</p>
<p>
\(\beta_{2L} X_{2ij}\) = is the independent variable X2 that is spatially lagged.
</p>
</div>

</div>

<div id="outline-container-6" class="outline-2">
<h2 id="sec-6"><span class="section-number-2">6</span> Discussion</h2>
<div class="outline-text-2" id="text-6">


<p>
Stay tuned.
</p>
</div>
</div>
</div>

</body>
