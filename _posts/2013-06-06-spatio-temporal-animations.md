--- 
name: spatio-temporal-animations
layout: post
title: spatio-temporal-animations
date: 2013-06-06
categories: 
- spatial 
---

## Space time animations are cool

This is a graphic I made a few years ago of temperature in Sydney.  It is a GAM with smoothing splines on longitude, latitude and time (t):

    require(mgcv)
    fit <- gam(temp ~ te(lon,lat,t,d=c(2,1),bs=c("tp","cr")), data=jan06)  

![spacetimegamSydney3hrTemp.gif](/button/spacetimegamSydney3hrTemp.gif)

[Clink here for an example of where I think this kind of animation should go now](/button/index.html).

The addition of stop/play/fwd/reverse buttons adds potential for exploratory insights.

The secret to getting the play/pause/next buttons is to insert graphing code between:

    saveHTML(..., outdir = getwd())

Unfortunately the rest of the code that accompanies the graphic above is too specific to my workflow that it is not reproducible.  That was back before (during the time that) I became obsessed with the prospect of [creating reproducible data analysis workflows](http://swish-climate-impact-assessment.github.io/).
