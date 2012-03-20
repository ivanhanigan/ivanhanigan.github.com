---
name: Shane-Weiss-Reich-White-worg-approach-to-code-management
layout: post
title: The Shane-Weiss-Reich-White.worg approach to Code Management
date: 2012-03-20
categories:
- disentangle things
---

Introduction
------------
I've been thinking alot about workflows recently.  I'm talking about the data, code, decisions etc bound up in the flow of material going through any project in the collective program of work we have going on at the Centre I work at.
The group are facing tough questions about how we do things; and why.  So in my reflections I've reviewed some links I'd saved and present below a unified summary version called the...

Shane-Weiss-Reich-White.worg approach 
-------------------------------------
This a synthesis I've put together of approaches to managing code in complex data analysis projects. It's named after key exponents on various blogs, wikis and web Q-and-A sites.

Stackoverflow user [Shane] [1] posted [this excellent comment to stackoverflow] [2] to: 

"start off with one R file as you start a project (or a set of files like in the [Bernd Weiss] [3] and [Josh Reich] [4] examples), and progressively add to it (so that it grows in size) as you make discoveries."

[Bernd Weiss'] [3] projects have:
* analysis, 
* data and 
* document directories and 
* README.org (an Emacs org-mode file).  

[Josh Reich] [4] breaks projects into 4 pieces: 
* load.R, 
* clean.R, 
* func.R and 
* do.R

[John Myles White's] [7] leads the [ProjectTemplate] [8] package that has 'create.project(minimal = TRUE)' which creates the layout: 
* cache, 
* config, 
* data, 
* munge, 
* src, and 
* README

I've just added reports.  If a project is a little bit bigger than minimal I'll add admin, metadata, versions etc etc. I might contribute that idea to the ProjectTemplate discussion list... or just bolt on whatever bits suit my needs as I go (still have work to do on the blog too y'know... trying to leave comments?  Not working yet I'm afraid). 

Which Code Editor is the Best?
------------------------------
And finally the meta work holding the project together is the code editor.  Despite the old joke which describes Emacs as ["a great operating system, lacking only a decent editor"] [8], this editor has killer functions for managing code.  Check out [worg the Emacs Org-Mode Community] [10]. Recently proponents of worg wrote [this article] [11].  Previously I've REALLY enjoyed [NPPtoR] [12] (only available under windoof).

In the words of [JD Long] [13] in response to [Shane] [2] "The choice of the specific tool is more idiosyncratic and not near as important as using SOMETHING."

[1]: http://stackoverflow.com/users/163053/shane "Shane"
[2]: http://stackoverflow.com/a/2292913 "Shane's Post"
[3]: https://github.com/berndweiss "Bernd Weiss"
[4]: http://stackoverflow.com/users/136862/josh-reich "Josh Reich"
[5]: http://stackoverflow.com/a/2287177 "Weiss approach"
[6]: http://stackoverflow.com/a/1434424 "Reich approach"
[7]: http://www.johnmyleswhite.com/about/ "John Myles White" 
[8]: http://projecttemplate.net/architecture.html "ProjectTemplate"
[9]: http://upsilon.cc/~zack/blog/posts/2008/10/from_Vim_to_Emacs_-_part_1/ "Why Emacs"
[10]: http://orgmode.org/worg/ "worg" 
[11]: http://www.jstatsoft.org/v46/i03/paper "Orgmode takes over the data analysis world"
[12]: http://sourceforge.net/projects/npptor/ "NPPtoR"
[13]: http://stackoverflow.com/users/37751/jd-long "JD Long"