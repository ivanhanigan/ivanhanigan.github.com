---
name: worflow-flowcharts
layout: post
title: Worflow flowcharts
date: 2013-07-31
categories: 
- workflow
- disentangle
---

## What is the issue  
Most people seem to collect multiple datasets together in a single spot that can be split into 2 or more separate data packages.  I think this is a natural set up from an analysts perspective, where the results of multiple steps accumulate as 'stepping stones' toward the file they end up analysing.  

I was first taught GIS by Isabelle Balzer at Ecowise Environmental Services in Canberra.  She showed me the method of keeping a table (sticky-taped to the desk!) of all the files and transformations that were going on. This was a method that didn't allow any multitasking!  I call this the 'Balzerian Method' (I am sure others used it before Isabelle, but I think Balzerian is a great word).

I think the data wharehouse at my work is an example, and probably we'll find the key challenge for big data will be for analysts to disentangle their own filing systems.

In my experience the way people store research data is often one (or a couple, or all) of these three types:

- a database with heaps of tables and views
- a directory (and sub-directories) with heaps of files 
- a spreadsheet workbook with heaps of sheets (and links to other workbooks)

I am developing a tool based on the open source graphviz softawre. The tool I am developing addresses the challenge of graphing the links between these sequential steps.  

#### Code:introducing newnode
    # NB this only works easily on linux
    require(devtools)
    install_github("disentangle", "ivanhanigan")
    require(disentangle)
    # the core of the tool is Rgraphviz, I just built a wrapper function
    # to add newnodes to a graph of nodes
    # always start with (newgraph = T) because the newnode function ADDS
    # nodes to a graph, unless told otherwise, and fails if no 'nodes'
    # object exists
    nodes  <- newnode(name="NAME",inputs="INPUT",outputs="OUTPUT", newgraph = T)

![images/newnode1.png](/images/newnode1.png)

#### Code:adding nodes
    # now we can add nodes, and we can pass multiple inputs or outputs
    nodes  <- newnode(name="OUTPUT",inputs=c("NAME","ANOTHER THING"))
    # outputs are optional

![images/newnode2.png](/images/newnode2.png)  

It can be used in two or three ways.  

## Example one, the composite view:
So if there is a Balzerian filelist table available, convert it to a spreadsheet.  This is als similar to a labbook from Chemistry but follows a very rigid structure: NAME,        INPUTS,           OUTPUTS,         DESCRIPTION.  The first method I'll show will take one of these tables and map out the steps in the workflow.

#### Code: Composite Worflow Files List
    #    so if there is a Balzerian filelist table available,
    # either make a spreadsheet with names, inputs and outputs 
    # fileslist <- read.csv("exampleFilesList.csv", stringsAsFactors = F)
    # or 
    filesList <- read.csv(textConnection(
    'NAME,        INPUTS,           OUTPUTS,         DESCRIPTION
    FileA,        TableXYZ,         Input1,          Transformed variable
    FileB,        TableABC,         Input2,          Collapsed dimensions
    analysisFile, "Input1,Input2",  analysisResults, Merged inputs and analysed
    '), stringsAsFactors = F, strip.white = T)
    filesList

    for(i in 1:nrow(filesList))
    {
      nodes <- newnode(name = filesList[i,"NAME"],
                       inputs = strsplit(filesList$INPUTS, ",")[[i]],
                       outputs = strsplit(filesList$OUTPUTS, ",")[[i]],
                       newgraph = (i == 1)
      )
    }

## shows this result
![fileRelationships.png](/images/fileRelationships.png)

## Example two, tracking the steps while analysing data:
Structure a script into sections and document each section before evaluating the code to execute the step.  This works well with orgmode/ESS, Sweave or knitr style workflows.
For example:

#### Code: Ad Hoc Files Lists Flowcharts
    #### step one ####
    nodes <- newnode(name="FileA", inputs="TableXYZ", outputs="Input1",
                     newgraph =T) # this is required to tell newnode to
                                  # start a new graph, rather than add to
                                  # the nodes
    FileA  <- read.table("TableXYZ.txt")
    Input1 <- log(FileA$columnZ)
     
    #### step two ####
    nodes <- newnode(name="FileB", inputs="TableABC", outputs="Input2")
    FileB  <- read.table("TableABC.txt")
    Input2 <- ddply(FileB, "id", summarise,
                    duration = max(year) - min(year),
                    nteams = length(unique(team)))
     
    #### step three ####
    nodes <- newnode(name="analysisFile", inputs=c("Input1","Input2"),
                     outputs="analysisResults")
    analysisFile  <- merge(Input1, Input2, by="id")
    analysisResults  <- lm(y ~ duration + nteams, data = analysisFile)


## Example three: visualising relationships
It is not aimed at visualising the linked structure of a tree or semi-lattice but can be used in such a way but changing the nodename and inputs concept to parent/child relationships.

As an example I'll describe how a list of database tables might be displayed as a tree. I am a great fan of Josh Reich due to his [LCFD workflow](http://stackoverflow.com/a/1434424), and I also like his work on the [Simple Bank](https://www.simple.com/) so when I stumbled on this [blog post](http://blog.i2pi.com/post/52812976752/joshs-postgresql-database-conventions) in which he says:

"Show me your flowchart and conceal your tables, and I shall continue to be mystified. Show me your tables, and I won’t usually need your flowchart; it’ll be obvious."

I was switched on and I started thinking about how the graphVis tool could be used to describe a list of tables and views from a database.

Say that two groups studied the same file TableXYZ with different inputs.  One of these groups wrote a seminal paper in the field, while their rivals wrote an inferior paper with a different result.  Imagine now a subsequent group who gathered the data from the previous work into the following database tables and conducted a replication study, with a new sensitivity analysis to explain why the original two papers produced different results.  

Let's assume this database has all the data from all the groups in it and we want to get a pictorial view so we can disentangle which files belong to which study.  First get the following list of tables as INPUTS, grouping them by 'NAME' will give the tree structure and showing their results as OUTPUTS allows the subsequent replication study to use them as inputs and assume the position at the bottom of the flowchart.

#### Code: database tables and different studies       
    filesList <- read.csv(textConnection(
    'NAME                 ,             INPUTS         , OUTPUTS
    The Seminal Study     ,              FileA         , 
    The Seminal Study     ,              FileB         , 
    The Seminal Study     ,       analysisFile         , 
    The Seminal Study     ,           TableXYZ         , 
    The Seminal Study     ,           TableABC         , 
    The Seminal Study     ,      Input1,Input2         ,
    The Seminal Study     ,             Input1         , 
    The Seminal Study     ,             Input2         , 
    The Seminal Study     ,      The Seminal Study     , analysisResults 
    The Inferior Rivals   ,                FileC       , 
    The Inferior Rivals   ,        analysisFileX       , 
    The Inferior Rivals   ,             TableXYZ       , 
    The Inferior Rivals   ,               InputX       , 
    The Inferior Rivals   ,    The Inferior Rivals     , analysisResultsX       
    The Replication Study ,    "Input1,Input2,TableXYZ",  analysisResultsR     
    The Replication Study ,    "Input1,InputX,TableXYZ",  sensitivityResult 
    '), stringsAsFactors = F, strip.white = T)

    for(i in 1:nrow(filesList))
    {
      nodes <- newnode(name = filesList[i,"NAME"],
                       inputs = strsplit(filesList$INPUTS, ",")[[i]],
                       outputs = strsplit(filesList$OUTPUTS, ",")[[i]],
                       newgraph = (i == 1)
      )
    }


    


## the result
![filesRelationships2.png](/images/filesRelationships2.png)
