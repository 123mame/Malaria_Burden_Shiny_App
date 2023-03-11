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
