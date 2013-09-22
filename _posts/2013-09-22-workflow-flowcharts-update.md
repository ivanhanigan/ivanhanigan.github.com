---
name: workflow-flowcharts-update
layout: post
title: workflow-flowcharts-update
date: 2013-09-22
categories:
- workflow
---

# Workflow flowcharts - Update
A while back I posted about my work with the Rgraphviz toolbox toward a wrapper function that will allow me to track the connections between chunks of my code as I write it.
This update includes notes from a discussion I had with Keith about this.

#### Code:
    require(disentangle)
    nodes <- newnode("NAME", "INPUT", "OUTPUT", newgraph =T)
