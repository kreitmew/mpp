plot.new()

plot.window( xlim=c(0,(input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui)), 
             ylim=c(0,10))

segments(0, 0, 0, 10, col = "black", lty = 2)
segments(input$t1ui, 0, input$t1ui, 10, col = "black", lty = 2)
segments(0, 0, input$t1ui, 0, col = "black", lty = 1)
segments(0, 10, input$t1ui, 10, col = "black", lty = 1)

segments(input$d1ui + input$t1ui, 0, input$d1ui + input$t1ui, 10, col = "black", lty = 2)
segments(input$d1ui + input$t1ui + input$t2ui, 0, input$d1ui + input$t1ui + input$t2ui, 10, col = "black", lty = 2)
segments(input$d1ui + input$t1ui, 0, input$d1ui + input$t1ui + input$t2ui, 0, col = "black", lty = 1)
segments(input$d1ui + input$t1ui, 10, input$d1ui + input$t1ui + input$t2ui, 10, col = "black", lty = 1)

segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 0, 
         input$d1ui + input$t1ui + input$d2ui + input$t2ui, 10, col = "black", lty = 2)
segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 0, 
         input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 10, col = "black", lty = 2)    
segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 0, 
         input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 0, col = "black", lty = 2)    
segments(input$d1ui + input$t1ui + input$d2ui + input$t2ui, 10, 
         input$d1ui + input$t1ui + input$d2ui + input$t2ui + input$t3ui, 10, col = "black", lty = 2)        

segments(input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui, 0, 
         input$d1ui + input$d2ui + input$d3ui + input$t1ui + input$t2ui + input$t3ui, 10, lty = 1, lwd = 2)

axis( side=1 )
title("Systemaufbau - Querschnitt - massstabsgetreu")