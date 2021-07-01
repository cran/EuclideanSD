# Code for the plot
output$ecdf <- renderPlot({ # curly braces are for code blocks
    # functions
    func <- ecdf(df$values)
    mirroredFunc <- function(x, a) {
        func(-x + 2*a)
    }
    mdFunc <- function(x, a) {
        func(x+a) - mirroredFunc(x+a, a)
    }
        
    if (correctMean()) {
        meanGuess <- mean
    } else {
        meanGuess <- input$meanSlider
    }

    if (!correctRMSD()) {
        fullRMSD(input$rmsdSlider)
    }

    if (!correctSMSD()) {
        fullSMSD(input$smsdSlider)
    }

    if (!correctMD()) {
        fullMD(input$mdSlider)
    }

    # max <- max(c(meanGuess + (meanGuess - absmin + 0.001), absmax)) # x value of meanGuess + maxDeviation
    max <- max(c(meanGuess + (meanGuess - absmin), absmax)) # x value of meanGuess + maxDeviation
    # maxDev <- max - meanGuess + 0.001 # the maximum deviation
    maxDev <- max - meanGuess # the maximum deviation


    p <- ggplot(df, aes(values)) +
        geom_hline(
            yintercept = 0,
            color = 'black'
        ) +
        geom_hline(
            yintercept = 1,
            color = 'black'
        ) +
        scale_x_continuous(
            n.breaks = 20
        ) +
        scale_y_continuous(
            n.break = 10
        )
            
    if (mode() == "Mean") {
        source("server_src/plots/mean.R", local = TRUE)
    } else if (mode() == "MD") {
        source("server_src/plots/md.R", local = TRUE)
    } else if (mode() == "SMSD") {
        source("server_src/plots/smsd.R", local = TRUE)
    } else if (mode() == "RMSD") {
        source("server_src/plots/rmsd.R", local = TRUE)
    } else if (mode() == "SD") {
        source("server_src/plots/sd.R", local = TRUE)
    }
    
    p
    
})
