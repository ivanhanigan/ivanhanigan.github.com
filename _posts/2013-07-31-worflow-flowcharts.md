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
Most people seem to collect multiple datasets together in a single spot that can be split into 2 or more separate data packages.  
I think the data wharehouse at my work is an example, and probably we'll find the key challenge for big data will be for analysts to disentangle their own filing systems.

In my experience the way people store research data is often one (or a couple, or all) of these three types:
- a database with heaps of tables and views
- a directory (and sub-directories) with heaps of files 
- a spreadsheet workbook with heaps of sheets (and links to other workbooks)

This is a natural set up from an analysts perspective, where the results of multiple steps accumulate as 'stepping stones' toward the file they end up analysing.  

My tool I am developing addresses the challenge of graphing the links between these sequential steps.  It can be used in two ways.  The first is more suited to what you might need to do retrospectively.

## Example one, the composite view:
I was first taught GIS by Isabelle Balzer at Ecowise Environmental Services in Canberra.  She showed me the method of keeping a table (sticky-taped to the desk!) of all the files and transformations that were going on.  This is similar to a labbook from Chemistry but follows a very rigid structure: FILE,        INPUTS,           OUTPUTS,         DESCRIPTION.  The first method I'll show will take one of these tables and map out the steps in the workflow.

#### Code: Composite Worflow Files List
    require(disentangle)
    # either edit a spreadsheet with filenames, inputs and outputs 
    # fileslist <- read.csv("exampleFilesList.csv", stringsAsFactors = F)
    # or 
    filesList <- read.csv(textConnection(
    'FILE,        INPUTS,           OUTPUTS,         DESCRIPTION
    FileA,        TableXYZ,         Input1,          Transformed variable
    FileB,        TableABC,         Input2,          Collapsed dimensions
    analysisFile, "Input1,Input2",  analysisResults, Merged inputs and analysed
    '), stringsAsFactors = F, strip.white = T)
    filesList
    # This is a bit kludgy, start the graph with first row
    i <- 1
    nodes <- newnode(name = filesList[i,1],
                     inputs = strsplit(filesList$INPUTS, ",")[[i]],
                     outputs = strsplit(filesList$OUTPUTS, ",")[[i]],
                     newgraph=T)
    # continue the graph for each row, handle missing outputs
    for(i in 2:nrow(filesList))
    {
      if(length(strsplit(filesList$OUTPUTS, ",")[[i]]) == 0)
      {
        nodes <- newnode(name = filesList[i,1],
                         inputs = strsplit(filesList$INPUTS, ",")[[i]]
        )    
      } else {
        nodes <- newnode(name = filesList[i,1],
                         inputs = strsplit(filesList$INPUTS, ",")[[i]],
                         outputs = strsplit(filesList$OUTPUTS, ",")[[i]]
        )
      }
    }
     
    dev.copy(png, 'fileRelationships.png')
    dev.off();

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

Say that two groups studied the same file TableXYZ with different inputs.  One of these groups wrote a seminal paper in the field, while their rivals wrote an inferior paper with a different result.  Imagine now a subsequent group who gathered the data from the previous work into the following database tables and conducted a replication study, with a new sensitivity analysis to explain why the original two papers produced different results.  The first part of this example is ugly, trying to generate a list of imaginary tables in our database.  Skip to the next section to see the finished product.

#### Code: database tables and different studies
    require(reshape)
    require(sqldf)
    filesList$STUDY <- "The Seminal Study"
    filesList2  <- melt(filesList, id.vars = "STUDY")
     
    # now there was a second study, by rivals with only one dataset
    filesList_rivals <- read.csv(textConnection(
    'FILE,        INPUTS,           OUTPUTS,         DESCRIPTION
    FileC,        TableIJK,         InputX,          Transformed variable
    analysisFileX, InputX,  analysisResultsX,          analysed
    '), stringsAsFactors = F, strip.white = T)
    filesList_rivals$STUDY <- "The Inferior Rivals"
    filesList2  <- rbind(filesList2,
                         melt(filesList_rivals, id.vars = "STUDY")
                         )
     
    # and sometime later there is a third study that replicated the first and added a
    # sensitivity test
    filesList_replication <- read.csv(textConnection(
    'FILE,        INPUTS,           OUTPUTS,            DESCRIPTION
    analysisFileR, "Input1,Input2",  analysisResultsR, Merged inputs and analysed
    sensitivityAnalysisFile, InputX, sensitivityResult, SupportForSeminalStudy'),
    stringsAsFactors = F, strip.white = T)
    filesList_replication$STUDY <- "The Replication Study"
    filesList_replication
    filesList2  <- rbind(filesList2,
                         melt(filesList_replication, id.vars = "STUDY")
                         )
    filesList2
    filesList3  <- sqldf("SELECT DISTINCT STUDY, value
    FROM filesList2
    where variable != 'DESCRIPTION'")
    filesList3
    # somehow we've converted FILE to factor
    filesList3$FILE <- as.character(filesList3$FILE)

## Ugly stuff over (mostly)
phew I am glad that is over.  Now we get the following list of tables as INPUTS, grouping them by 'FILE' will give the tree structure and showing their results as OUTPUTS allows the subsequent replication study to use them as inputs and assume the position at the bottom of the flowchart.

#### Code: database tables and different studies       
    filesList3 <- read.csv(textConnection(
    'FILE                 ,             INPUTS         , OUTPUTS
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
    The Replication Study ,      "Input1,Input2,TableXYZ",  analysisResultsR     
    The Replication Study ,      "Input1,InputX,TableXYZ",  sensitivityResult 
    '), stringsAsFactors = F, strip.white = T)
    i <- 1
     
    nodes <- newnode(name = filesList3[i,"FILE"],
                     inputs = strsplit(filesList3$INPUTS, ",")[[i]],              
                     newgraph=T)
    # continue the graph for each row, handle missing outputs
    for(i in 2:nrow(filesList3))
    {
      if(length(strsplit(filesList3$OUTPUTS, ",")[[i]]) == 0)
      {
        nodes <- newnode(name = filesList3[i,"FILE"],
                         inputs = strsplit(filesList3$INPUTS, ",")[[i]]
        )    
      } else {
        nodes <- newnode(name = filesList3[i,"FILE"],
                         inputs = strsplit(filesList3$INPUTS, ",")[[i]],
                         outputs = strsplit(filesList3$OUTPUTS, ",")[[i]]
        )
      }
    }


## the result
![filesRelationships2.png](/images/filesRelationships2.png)
