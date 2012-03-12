---
name: outlines-way-to-organise-and-to-think
layout: post
title: Outlines. A way to organise, and to think
date: 2012-03-11
categories:
- outlines
- disentangle things
---

Introduction
------------
In a [previous post] [1] I talked about the conceptual framework I draw on for organising material about complex systems. I quoted a passage by Koestler 1967 that talks about the writing process describing the use of 'outlines', albeit without using that term.  I find this quote particularly inspires me to think about how to select the material for inclusion (and identify the material ruled out of scope - those times we decide to "chop off entire flowering branches from the tree and start growing them afresh"). 

A way to organise
-----------------
Outlines are a method for writing, and also the basis of a toolbox called ['outliners'] [2]. I've been using the excellent free outliner [Keynote-NF] [3] for years and it has been great.  Recently I was inspired by this [paper by Schulte et al] [4], which very convincingly introduced me to Emacs Orgmode as a viable tool for someone without a computer science background (others had described Emacs as 'not an editor so much as a lifestyle choice' or 'a good operating system just lacking a decent editor').

A way to think
--------------
I recently had the privilege to attend a class with renowned epidemiologist Professor Nancy Krieger who gave us a valuable insight to her workflow.  She told us that for years she'd started every research project by writing out the outline and then filled out the branches much as Koestler's quote described.  Prof Krieger then said that she didn't explicitly write outlines anymore, she'd been doing it for so long it was deeply ingrained and natural part of her way of thinking.

Prof Krieger went on to describe how she conducts her research workflow through the outline

* first sketch the outline suggested by the hypotheses to be tested (data sourced,  methods applied)
* review the literature, there are very few areas of study that haven't been looked at by someone else
* create empty 'table shells' showing the form that the information will be presented in the final paper
* exploratory data analysis and graphics
* primary data analysis and interpretation of the results
* another literature review - identify the dominant story people are telling about this question
* write the discussion. Deal with any caveats head-on, how the bias may inflate or deflate estimates

Writing workflow depends on forum
---------------------------------
The flow of steps described above remind me [Andrew Gelman's point] [5] about how he writes science papers like this, but doesn't write blogs this way... he mentions thoughts on style, audience etc.  There may be a dichotomy worth exploring between clear structure vs evolving narrative.

Key features of outliner software
---------------------------------
To conclude I'll just mention the most interesting features I've found in outliner software and will discuss these in a future post:

* Nodes: these are the building blocks
* Parents and children: there is a strict ordering of the nodes into a hierarchy
* [Semilattice:] [6] this allows connections to be made across branches, not just through the hierarchy
* Folding can be used to hide entire sections of the tree, unfolding to 'drill down' to deep levels
* Hoisting: to promote and demote branches, including all children branches
* Lifting and grafting: easy reshuffling of the order
* Checked nodes: chosen nodes can be exported while the rest remain invisible

[1]: http://ivanhanigan.github.com/2012/02/the-organisation-of-material/ "The Organisation of Material"
[2]: http://en.wikipedia.org/wiki/Outliner "Wikipedia Outliners"
[3]: http://code.google.com/p/keynote-nf/ "Keynote-NF"
[4]: http://www.jstatsoft.org/v46/i03/ "jstatsoft"
[5]: http://andrewgelman.com/2011/05/my_new_writing/ "Andrew Gelman's New Writing"
[6]: http://www.patternlanguage.com/archives/alexander1.htm "A City is not a Tree"
