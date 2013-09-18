---
name: pumilio-bushfm-test-dev-prod
layout: post
title: pumilio-bushfm-test-dev-prod
categories:
- pumilio-bushfm
- open notebook
---

# Testing the pumilio-bushfm-test-dev-prod build process, in an Open Notebook
#### Aims: 
It was suggested I could document the pumilio test build as an OpenNotebook.
I imagined that I could link this blog to github repo and doco hosted on gh-pages.

#### Methods: 
- For ie the emacs html output now goes to [http://ivanhanigan.github.io/pumilio-bushfm/](http://ivanhanigan.github.io/pumilio-bushfm/)
- then collaborators can clone/fork [https://github.com/ivanhanigan/pumilio-bushfm](https://github.com/ivanhanigan/pumilio-bushfm)
- and comment/complain at [https://github.com/ivanhanigan/pumilio-bushfm/wiki](https://github.com/ivanhanigan/pumilio-bushfm/wiki)

#### Results: 
- I did a test build a month ago on an old laptop sitting around, then rebuilt on the Nectar cloud
- Unfortunately I didn't realise that the Nectar VM had mounted /var on to the smaller root partition (the 40GB 2nd disk is on /mnt).
- then when I tried to upload a big sound file it broke :-(
- I did a bit of reading and whilst I began thinking I'd just need to move the mysql datadir via 

#### Code:
    sudo nano /etc/mysql/my.cnf

<p></p>

#### BUT
- it actually looks like there is a WAV and MP3 file under /var/www/pumilio-2...
- so I think I can [just remount /var](http://askubuntu.com/questions/39536/how-can-i-store-var-on-a-separate-partition) onto the larger /mnt secondary disk.
