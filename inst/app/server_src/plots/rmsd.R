vals <- seq(0, maxDev, length = 10000)
dat <- data.frame(x = vals)
dat$xtrans <- (dat$x)^2/maxDev

static_line <- function(x) {
    return ( (1 / maxDev) * x )
}

correct_y <- 0

observe({
    if (correctMean()) {
        meanGuess <- mean
    } else {
        meanGuess <- input$meanSlider
    }
})
max_val <- max(c(meanGuess + (meanGuess - absmin + 0.001), absmax)) # x value of meanGuess + maxDeviation
maxDev <- max - meanGuess + 0.001 # the maximum deviation

deviation_df <- data.frame(dev = abs(df$values - meanGuess))
deviation_df$scaled_dev <- deviation_df$dev^2 / maxDev

limit <- sd(deviation_df$dev) / 10

rmsd_precise <- sqrt(mean(deviation_df$dev^2))
correct_y <- mdFunc(rmsd_precise, meanGuess)

lower_x <- fullSMSD()
lower_y <- static_line(lower_x)

upper_x <- fullRMSD()
upper_y <- static_line(upper_x)

moving_line_inv <- function(y) {
    return ( (upper_x / lower_y) * y )
}

p <- p + labs(
    title = paste("ECDF of D (n =", n, ")"),
    x = "Deviation",
    y = ""
)

p <- p + geom_hline( # horizontal mapping line
    yintercept = correct_y,
    color = 'red',
    linetype = 'dashed'
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

p <- p + geom_vline( # static value
    xintercept = fullSMSD(),
    color = 'red',
    linetype = 'solid'
)

p <- p + geom_vline( # input
    xintercept = fullRMSD(),
    color = 'red',
    linetype = 'solid'
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
    na.rm = TRUE,
    linetype = 'solid'
)

p <- p + geom_line( # unscaled deviations
    data = dat,
    aes(x = x, y = mdFunc(x, meanGuess)),
    na.rm = TRUE,
    color = 'black',
    alpha = 0.6,
    linetype = 'dashed'
)

# Line from (0,0) to (R,0) (static_line)
p <- p + geom_abline(
    slope = 1 / maxDev,
    intercept = 0,
    color = 'blue',
    linetype = 'dashed'
)

# Intersection between static_line and SMSD slider
p <- p + geom_point(
    x = lower_x,
    y = lower_y,
    size = 3
)

# Lower horizontal line
p <- p + geom_hline(
    yintercept = lower_y,
    color = 'blue',
    linetype = 'dashed'
)

# Upper horizontal line
p <- p + geom_hline(
    yintercept = upper_y,
    color = 'blue',
    linetype = 'dashed'
)

# Intersection between static_line and RMSD slider
p <- p + geom_point(
    x = upper_x,
    y = upper_y,
    size = 2
)

# Line from (0,0) to (upper_x, lower_y) (moving line)
p <- p + geom_abline(
    slope = lower_y / upper_x,
    intercept = 0,
    color = 'blue',
    linetype = 'dashed'
)

# Intersection between lower horizontal line and moving line
p <- p + geom_point(
    x = upper_x,
    y = lower_y,
    size = 2
)

# Intersection between upper horizontal line and moving line
p <- p + geom_point(
    x = moving_line_inv(upper_y),
    y = upper_y,
    size = 3,
    color = '#00C400' # darker green (196)
)
