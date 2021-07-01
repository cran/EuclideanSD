vals <- seq(0, maxDev, length = 10000)
dat <- data.frame(x = vals)
dat$xtrans <- (dat$x)^2/maxDev

# Manually calculated population SD to account for rounding since slider for guessing
# mean has precision to 0.01

# This way, the RMSD and Population SD look identical on the graph when the correct
# mean is selected initially

deviation_df <- data.frame(dev = abs(df$values - meanGuess))
deviation_df$sq_dev <- deviation_df$dev^2
deviation_df$scaled_dev <- deviation_df$sq_dev / maxDev
e$popSD <- sqrt(sum(deviation_df$sq_dev) / n)
e$sampleSD <- sqrt(sum(deviation_df$sq_dev) / (n - 1))

# Value of population SD
if(popToggle() == 0) {
    session$sendCustomMessage("hidePopSD", e$popSD)
} else {
    session$sendCustomMessage("showPopSD", e$popSD)
}

# Value of sample SD
if(sampleToggle() == 0) {
    session$sendCustomMessage("hideSampleSD", e$sampleSD)
} else {
    session$sendCustomMessage("showSampleSD", e$sampleSD)
}

p <- p + labs(
    title = paste("ECDF of D (n =", n, ")"),
    x = "Deviation (D)",
    y = ""
)

p <- p + geom_vline( # 0 line
    xintercept = 0,
    color = 'red',
    # linetype = 'dashed'
)

p <- p + geom_vline( # MD line
    xintercept = fullMD(),
    color = 'black',
    linetype = 'dotted'
)

p <- p + geom_vline( # value of SMSD slider
    xintercept = fullSMSD(),
    color = 'black'
)

if (input$popSDToggle) {
    p <- p + geom_vline( # population SD
        xintercept = e$popSD,
        color = '#FF0000' # red
    )
}

if (input$sampleSDToggle) {
    p <- p + geom_vline( # sample SD
        xintercept = e$sampleSD,
        linetype = 'dashed',
        color = '#0000FF' # blue
    )

    # additional lines
    p <- p + geom_abline(
        slope = (1 - (1/n)) / fullSMSD(), # mathematically correct
        intercept = 0,
        color = 'black',
        linetype = "dashed"
    )

    p <- p + geom_vline(
        xintercept = fullSMSD() * n / (n-1),
        color = 'black',
        linetype = 'dashed'
    )

    # point on population SD line
    p <- p + geom_point(
        x = fullSMSD(),
        y = 1 - (1/n),
        # size = 1
    )
}

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
    na.rm = TRUE,
    aes(y = mdFunc(x, meanGuess), x = xtrans),
    color = 'black',
    # linetype = 'dotted'
)

p <- p + geom_line( # unscaled deviations
    data = dat,
    na.rm = TRUE,
    aes(x = x, y = mdFunc(x, meanGuess)),
    color = 'black',
    linetype = 'dashed'
)
