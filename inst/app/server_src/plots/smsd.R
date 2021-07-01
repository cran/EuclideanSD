vals <- seq(0, maxDev, length = 10000)
dat <- data.frame(x = vals)
dat$xtrans <- (dat$x)^2/maxDev
dat$xtrans[n] <- maxDev

seq1 <- data.frame(x = seq(0, sqrt(fullSMSD() * maxDev), length = 5000))
seq2 <- data.frame(x = seq(sqrt(fullSMSD() * maxDev), maxDev, length = 5000))

p <- p + labs(
    title = bquote("ECDF of" ~ frac(D^2,R) ~ "(n =" ~ .(n) * ")"),
    x = bquote(frac(D^2,R)),
    y = ""
)

p <- p + geom_vline( # 0 line
    xintercept = 0,
    color = 'red',
    # linetype = 'dashed'
)

p <- p + geom_vline( # input
    xintercept = fullSMSD(),
    color = 'red'
)

p <- p + geom_vline( # MD line
    xintercept = fullMD(),
    color = 'black',
    linetype = 'dotted'
)

p <- p + geom_vline(
    xintercept = maxDev,
    color = 'black',
    # linetype = 'dashed'
)

p <- p + geom_text(
    aes(
        label = "R",
        x = maxDev,
        y = 0
    ),
    nudge_x = 0.005 * maxDev,
    nudge_y = -0.04
)

p <- p + geom_line( # scaled deviations
    data = dat,
    aes(y = mdFunc(x, meanGuess), x = xtrans),
    color = 'black',
    na.rm = TRUE
)

p <- p + geom_line( # unscaled deviations
    data = dat,
    aes(x = x, y = mdFunc(x, meanGuess)),
    na.rm = TRUE,
    color = 'black',
    linetype = 'dashed'
)

p <- p + geom_ribbon(
    data = seq1,
    aes(x = x^2/maxDev, ymax = mdFunc(x, meanGuess), ymin = 0),
    fill = 'green',
    alpha = 0.4
)

p <- p + geom_ribbon(
    data = seq2,
    aes(x = x^2/maxDev, ymin = mdFunc(x, meanGuess), ymax = 1),
    fill = 'blue',
    alpha = 0.4
)
