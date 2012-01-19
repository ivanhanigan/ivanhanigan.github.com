--- 
name: about-my-research
layout: post
title: About My Research
date: 2012-01-19
categories: 
- thoughts
- blogger
- wordpress
- jekyll
---

I am enticed by the work out there at the moment that challenges us to use the tools of open science (open software and open access publication) to make science more reproducible, transparent and awesome.  Science December 2 2011 Volume 334 (URL [here][]) has a special section on replication and reproducibility.  Especially Roger Pengs perspective on:
limitations in our ability to evaluate published findings. Reproducibility has the potential to serve as a minimum standard for judging scientific claims when full independent replication of a study is not possible.

At the moment I am keenly aware of barriers to replicability due to the voluminous generation of data and the multitude of analysis workflow decisions that can affect the results of the kind of integrated analyses I am involved with ... choices include those relating to: which health outcomes are selected? which exposure estimates? of which environmental dataset?  

How data is linked together; population, health and environmental data is relevant to our ability to disentangle the complex relationships to be found.   I've had a difficult time due to multiple revisions on datasets and analysis plans that come from working with multidisciplinary teams of epidemiologists, environmental scientists and biostatisticians.  I studied geography and ecology in my undergraduate degree, so am able to link multiple layers of data together in a Geographical Information System (GIS), but what I think I need is an Integrative Information Systems (IIS has a nice ring to it).  

I try do all my weather/air pollution/health/demography data integrations and analysis using the Reproducible Research Reporting paradigm implemented in R/Sweave.  I do this so I can maintain tight control over modelling assumptions or data decisions at any point in the workflow, including multiple versions over the course of an evolving analysis plan.  This allows me to 'drill down' into parts of the data preparation and analysis many months after the bulk of the work has been done, change key portions that respond to the changed requirements of the project, and document the reason for the changes (in case of the inevitable change in requirements, see this xkcd comic strip [here][here2]

So in summary, I am interested in tools that enable analysts to deal with the issues of intergrated analysis networks, and tracking the many choices an analyst makes through a complex web of the analysis workflow between data, analysis, reporting and archiving activities.


[here]: http://www.sciencemag.org/content/334/6060.toc
[here2]: http://xkcd.com/844/