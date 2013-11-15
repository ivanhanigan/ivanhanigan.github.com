library(animation)
saveHTML({ani.options(nmax = 100, interval = 0.5)
par(mar = c(3, 2.5, 0.5, 0.2), pch = 20, mgp = c(1.5, 0.5, 0))
buffon.needle(mat = matrix(c(1, 2, 1, 3), 2))}, outdir = getwd())
