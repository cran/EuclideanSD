mid <- meanGuess
seq1 <- data.frame(x = seq(absmin, mid, length = 5000))
seq2 <- data.frame(x = seq(mid, absmax, length = 5000))

p <- p + geom_line( # ecdf plot
    data = data.frame(x = seq(absmin - 0.001, absmax, length=10000)),
    na.rm = TRUE,
    aes(x = x, y = func(x)),
    color = 'black'
)

p <- p + labs( # title and axes labels
    title = paste("ECDF of X (n =", n, ")"),
    x = "X",
    y = ""
)

if (e$initialized) {
    p <- p + geom_vline(
        xintercept = meanGuess,
        color = 'red'
    )
    p <- p + geom_ribbon(
        data = seq1,
        na.rm = TRUE,
        aes(ymin = 0, ymax = func(x), x = x),
        alpha = 0.4,
        fill = 'green'
    )
    p <- p + geom_ribbon(
        data = seq2,
        na.rm = TRUE,
        aes(ymin = func(x), ymax = 1, x = x),
        alpha = 0.4,
        fill = 'blue'
    )
} else {
    e$initialized <- TRUE # used to set value of variable out of scope
}
