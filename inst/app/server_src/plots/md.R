seq1 <- data.frame(x = seq(meanGuess, fullMD() + meanGuess, length = 5000))
seq2 <- data.frame(x = seq(fullMD() + meanGuess, max, length = 5000))
dat <- data.frame(x = seq(0, max - meanGuess, length = 10000))
dat$xtrans <- (dat$x)^2/maxDev

if (input$toggleSort) { # ecdf of deviations
    p <- p + labs(
        title = paste("ECDF of D (n =", n, ")"),
        x = "Deviation (D)",
        y = ""
    )
    
    p <- p + geom_line( # uncompressed deviations
        data = dat,
        na.rm = TRUE,
        aes(x = x, y = mdFunc(x, meanGuess)),
        color = 'black'
    )

    # p <- p + geom_line( # compressed deviations
    #     data = dat,
    #     na.rm = TRUE,
    #     aes(x = xtrans, y = mdFunc(x, meanGuess)),
    #     color = 'black',
    #     linetype = 'dotted'
    # )
    
    p <- p + geom_vline( # 0 line
        xintercept = 0,
        color = 'red',
        # linetype = 'dashed'
    )
    
    p <- p + geom_vline(
        xintercept = fullMD(),
        color = 'red'
    )

    p <- p + geom_vline(
        xintercept = maxDev,
        color = 'black',
        linetype = 'dashed'
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
    
    p <- p + geom_ribbon(
        data = data.frame(x = seq(0, fullMD(), length=5000)),
        aes(ymin = 0, ymax = mdFunc(x, meanGuess), x = x),
        alpha = 0.4,
        fill = 'green'
    )

    p <- p + geom_ribbon(
        data = data.frame(x = seq(fullMD(), max - meanGuess, length=5000)),
        aes(ymax = 1, ymin = mdFunc(x, meanGuess), x = x),
        alpha = 0.4,
        fill = 'blue'
    )
} else if (!input$toggleExpand) { # full plot
    p <- p + labs(
        title = paste("Mirrored ECDF of X (n =", n, ")"),
        x = "X",
        y = ""
    )
    
    p <- p + geom_vline( # 0 line
        xintercept = meanGuess,
        color = 'red',
        # linetype = 'dashed'
    )
    
    p <- p + geom_vline(
        xintercept = fullMD() + meanGuess,
        color = 'red'
    )
    
    p <- p + geom_line(
        data = data.frame(x = seq(absmin - 0.001, absmax, length=10000)),
        na.rm = TRUE,
        aes(x = x, y = func(x)),
        color = 'black'
    )
    
    p <- p + geom_line( # mirrored plot
        data = data.frame(x = seq(meanGuess, max, length = 10000)),
        na.rm = TRUE,
        aes(y = mirroredFunc(x, meanGuess), x = x),
        color = 'black'
    )
    
    p <- p + geom_ribbon(
        data = seq1,
        na.rm = TRUE,
        aes(ymin = mirroredFunc(x, meanGuess), ymax = func(x), x = x),
        alpha = 0.4,
        fill = 'green'
    )
    
    p <- p + geom_ribbon(
        data = seq2,
        na.rm = TRUE,
        aes(ymin = 0, ymax = mirroredFunc(x, meanGuess), x = x),
        alpha = 0.4,
        fill = 'blue'
    )
    
    p <- p + geom_ribbon(
        data = seq2,
        na.rm = TRUE,
        aes(ymin = func(x), ymax = 1, x = x),
        alpha = 0.4,
        fill = 'blue'
    )
} else { # full plot to right of mean guess
    p <- p + labs(
        title = paste("Mirrored ECDF of X (n =", n, ")"),
        x = "X",
        y = ""
    )
    
    p <- p + geom_vline( # 0 line
        xintercept = meanGuess,
        color = 'red',
        # linetype = 'dashed'
    )
    
    p <- p + geom_vline(
        xintercept = fullMD() + meanGuess,
        color = 'red'
    )
    
    p <- p + geom_line( # right portion of ecdf
        data = data.frame(x = seq(meanGuess, absmax, length=10000)),
        na.rm = TRUE,
        aes(x = x, y = func(x)),
        color = 'black'
    )

    p <- p + geom_line( # mirrored plot
        data = data.frame(x = seq(meanGuess, max, length = 10000)),
        na.rm = TRUE,
        aes(y = mirroredFunc(x, meanGuess), x = x),
        color = 'black'
    )
    
    p <- p + geom_ribbon(
        data = seq1,
        na.rm = TRUE,
        aes(ymin = mirroredFunc(x, meanGuess), ymax = func(x), x = x),
        alpha = 0.4,
        fill = 'green'
    )
    
    p <- p + geom_ribbon(
        data = seq2,
        na.rm = TRUE,
        aes(ymin = 0, ymax = mirroredFunc(x, meanGuess), x = x),
        alpha = 0.4,
        fill = 'blue'
    )
    
    p <- p + geom_ribbon(
        data = seq2,
        na.rm = TRUE,
        aes(ymin = func(x), ymax = 1, x = x),
        alpha = 0.4,
        fill = 'blue'
    )
}
