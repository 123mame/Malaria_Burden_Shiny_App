library(shiny)

# Define server ----
server <- function(input, output) {
  df <- readr::read_csv("data/IHME_1990_2019_Malaria.csv")
  # Filter the data based on user inputs
  filtered_data <- reactive({
    df %>% filter(sex_name == input$Select_genders,
                  location_name %in% input$Select_Region,
                  metric_name == input$Metrice,
                  measure_name %in% input$Mesure_id,
                  age_name == "All ages",
                  cause_id != 294, 
    )
    
  })
  
  
  
  # Create the line plot
  line_plot <- reactive({
    ggplot(filtered_data(), aes(x = year, y = val, col = location_name)) +
      geom_line()+
      scale_y_log10()+
      geom_point()+
      theme_bw()+
      theme(plot.background = element_rect(color = NA, linewidth = 1))+
      theme(panel.border = element_blank())+
      #paste0("Temp: ", round(temperature, 1), "\nPressure: ", round(pressure, 1)), "")
      #facet_wrap(~gender) +
      labs(title = paste0("Burden of malaria in Ethiopian regions"," "," (", input$Metrice, ")."),
           subtitle= paste0(input$Mesure_id, " ", "for", " ", input$Select_genders,  "."), x = "Year", y = input$Metrice,
           color = "Region")
  })
  
  
  
  output$Heatmap <- renderPlot({
    gg<- ggplot(filtered_data(), aes(x = year, y = location_name, fill = val))+
      geom_tile(colour = "white", size = 0.25) + # select the border of tile as white o identify easily
      scale_fill_gradient(high = "#E34A33", low = "#FEE8C8", na.value = "white")+ # Colour selection by using brewer
      # scale_x_discrete(expand = c(0, 0),
      #                  breaks = seq(1990, 2019, 3))+
      theme_bw()+
      theme(plot.background = element_rect(fill = "white")) +
      
      theme(panel.border = element_blank())+
      labs(title = paste0("Burden of malaria in Ethiopian regions"," "," (", input$Metrice, ")."),
           subtitle= paste0(input$Mesure_id, " ", "for", " ", input$Select_genders,  "."), x = "Year", y = " ",
           color = "Location")
    # Divide each plot x axis from 1990 to 2019 by 2 interval
    
    # gg <- gg + labs(x=NULL, y=NULL,
    #                 title=sprintf("%s", paste0("Malaria", " ", cc, " ", "Per 100k residents" ) )) #replace gg and put common and Dynamic(cc) title for all
    # 
    # gg <- gg + theme(axis.ticks=element_blank()) # remove ticks from the x and y axis or hyphen(-) symbol
    # gg <- gg + theme(axis.text=element_text(size=5)) # make x and y axis number or text size as 5
    # gg <- gg + theme(panel.border=element_blank()) # make border of the plot clear
    # gg <- gg + theme(plot.title=element_text(hjust=0, size=6)) # make a plot tite horizontaly adjust by 0 and make size of text 6
    # gg <- gg + theme(panel.margin.x=unit(0.5, "cm")) #make argin of the panal of x by half cm
    # #gg <- gg + theme(panel.margin.y=unit(0.5, "cm"))  #make argin of the panal of y by half cm
    # gg <- gg + theme(legend.title=element_text(size=6)) # Legend title make size 6
    # gg <- gg + theme(legend.title.align=1) # make allign with legends
    # gg <- gg + theme(legend.text=element_text(size=5)) # legend text is 5
    # gg <- gg + theme(legend.position="bottom") # kake at the bottom of the plot
    # gg <- gg + theme(legend.key.size=unit(0.1, "cm")) # make key zie of the legend
    # gg <- gg + theme(legend.key.width=unit(0.5, "cm")) # make the width of the key by half
    # 
    gg
  })
  
  
  
  output$line_plot1 <- renderPlot({
    line_plot()
  })
  
  # Download the plot
  output$download_plot <- downloadHandler(
    filename = function() {
      paste("my_plot", Sys.Date(), ".png", sep = "_")
    },
    content = function(file) {
      ggsave(file,
             line_plot(),
             width = 8, height = 5, dpi = 300)
    }
  )
  
  
  
  
  
  output$raw_data <- DT::renderDT(
    df <- filtered_data()
    
  )
  
  
  
  
  
  
  
  
  
  
  
}
