# Handles button presses
observeEvent(input$meanBtn, {
    # limit <- sd(df$values) / 10
    limit <- 0.1
    difference <- input$meanSlider - round(mean, digits = 2)

    output$adjustGuess <- renderText({
        if (isolate(input$meanSlider) < round(mean, digits = 2)) {
            correctMean(FALSE)
            if (abs(difference) <= limit) {
                return ("Move right slightly")
            }
            return("Move right")
        } else if (isolate(input$meanSlider) > round(mean, digits = 2)) {
            correctMean(FALSE)
            if (abs(difference) <= limit) {
                return ("Move left slightly")
            }
            return("Move left")
        } else {
            correctMean(TRUE)
            return(paste("Correct! Mean: ", round(mean,4)))
        }
    })
})

observeEvent(input$mdBtn, {
    if (correctMean()) {
        meanGuess <- mean
    } else {
        meanGuess <- input$meanSlider
    }
    max <- max(c(meanGuess + (meanGuess - absmin + 0.001), absmax)) # x value of meanGuess + maxDeviation
    maxDev <- max - meanGuess + 0.001 # the maximum deviation

    deviation_df <- data.frame(dev = abs(df$values - meanGuess))

    # limit <- sd(deviation_df$dev) / 10
    limit <- 0.1

    md_precise <- sum(deviation_df$dev) / n
    md <- round(md_precise, digits = 2)
    mdGuess <- input$mdSlider
    difference <- mdGuess - md

    # print(md_precise)

    output$adjustMD <- renderText({
        if (mdGuess < round(md, digits = 2)) {
            correctMD(FALSE)
            if (abs(difference) <= limit) {
                return("Move right slightly")
            }
            return("Move right")
        } else if (mdGuess > round(md, digits = 2)) {
            correctMD(FALSE)
            if (abs(difference) <= limit) {
                return("Move left slightly")
            }
            return("Move left")
        } else {
            correctMD(TRUE)
            fullMD(md_precise)
            return(paste("Correct! MD: ", round(fullMD(), 4)))
        }
    })
})

observeEvent(input$smsdBtn, {
    if (correctMean()) {
        meanGuess <- mean
    } else {
        meanGuess <- input$meanSlider
    }
    max <- max(c(meanGuess + (meanGuess - absmin + 0.001), absmax)) # x value of meanGuess + maxDeviation
    maxDev <- max - meanGuess + 0.001 # the maximum deviation

    deviation_df <- data.frame(dev = abs(df$values - meanGuess))
    deviation_df$scaled_dev <- deviation_df$dev^2 / maxDev

    # limit <- sd(deviation_df$scaled_dev) / 10
    limit <- 0.1

    rmsd <- sqrt(mean(deviation_df$dev^2))

    smsdGuess <- input$smsdSlider
    smsd_precise <- (rmsd^2 / maxDev)
    smsd <- round(smsd_precise, digits = 2)
    # print(smsd_precise)
    difference <- smsdGuess - smsd

    output$adjustSMSD <- renderText({
        if (smsdGuess < smsd) {
            correctSMSD(FALSE)
            if (abs(difference) <= limit) {
                return ("Move right slightly")
            }
            return("Move right")
        } else if (smsdGuess > smsd) {
            correctSMSD(FALSE)
            if (abs(difference) <= limit) {
                return("Move left slightly")
            }
            return("Move left")
        } else {
            correctSMSD(TRUE)
            fullSMSD(smsd_precise)
            return(paste("Correct! SMSD: ", round(fullSMSD(), 4)))
        }
    })
})

observeEvent(input$rmsdBtn, {
    if (correctMean()) {
        meanGuess <- mean
    } else {
        meanGuess <- input$meanSlider
    }
    max <- max(c(meanGuess + (meanGuess - absmin + 0.001), absmax)) # x value of meanGuess + maxDeviation
    maxDev <- max - meanGuess + 0.001 # the maximum deviation

    deviation_df <- data.frame(dev = abs(df$values - meanGuess))
    deviation_df$scaled_dev <- deviation_df$dev^2 / maxDev

    # limit <- sd(deviation_df$dev) / 10
    limit <- 0.1

    rmsd_precise <- sqrt(mean(deviation_df$dev^2))
    rmsd <- round(rmsd_precise, digits = 2)
    rmsdGuess <- input$rmsdSlider
    difference <- rmsdGuess - rmsd

    # print(rmsd_precise)

    output$adjustRMSD <- renderText({
        if (rmsdGuess < rmsd) {
            correctRMSD(FALSE)
            if (abs(difference) <= limit) {
                return ("Move right slightly")
            }
            return("Move right")
        } else if (rmsdGuess > rmsd) {
            correctRMSD(FALSE)
            if (abs(difference) <= limit) {
                return("Move left slightly")
            }
            return("Move left")
        } else {
            correctRMSD(TRUE)
            fullRMSD(rmsd_precise)
            if (!correctMean()) {
                return("Correct!  To find the SD, first guess the mean correctly!")
            } else {
                return(paste("Correct! RMSD: ", round(fullRMSD(), 4)))
            }
        }
    })
})
