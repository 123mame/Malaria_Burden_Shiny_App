library(shiny)
library(ggplot2)
library(dplyr) 
library(readr)
library(rsconnect)

# load your dataset here
df <- readr::read_csv("data/IHME_1990_2019_Malaria.csv")
attach(df)

# Define UI ----
ui <- fluidPage(
  titlePanel(
    HTML("<h4><b>Interactive vizualization for Burden of malaria in Ethiopia at subnational level:
         <br> findings from the Global Burden of Disease estimates 2019</b></h4>
    <h6>By Mohammed Bheser Hassen</h6>")
    
  ),
  sidebarLayout(
    sidebarPanel(
      titlePanel(
        HTML("<h5><b>Desired Characteristics and <br>Measurments</b></h5>")
      ),
      fluidRow(
        column(
          3,
          radioButtons(
            inputId = "Select_genders", 
            label = "Select Gender:",
            choices = unique(df$sex_name),
            selected = "Male"
          ),
          radioButtons(
            inputId = "Metrice",
            label = "Select Metric:",
            choices = unique(df$metric_name)
          ),
          radioButtons(
            inputId = "Mesure_id",
            label = "Select Measure:",
            choices = c(
              "DALYs" = "DALYs (Disability-Adjusted Life Years)",
              "YLLs" = "YLLs (Years of Life Lost)",
              "Deaths",
              "Incidence",
              "YLDs" = "YLDs (Years Lived with Disability)",
              "Prevalence" 
            ),
            selected = "Prevalence"
          )
        ),
        column(
          6, offset = 1,
          checkboxGroupInput(
            inputId = "Select_Region",
            label = "Select Region(s):",
            choices = unique(df$location_name),
            selected = "Ethiopia"
          ),
          hr(),
          downloadButton(
            outputId = "download_plot",
            label = "Download plot"
          ),
        )
      ) 
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel(
          "Line",
          plotOutput("line_plot1")
        ),
        tabPanel(
          "Heat Map",
          plotOutput("Heatmap")
        ),
        tabPanel(
          "Data",
          DT::dataTableOutput("raw_data")
        ),
        tabPanel(
          "About",
          hr(),
          HTML("<b>Problem Statement</b><br>
               Malaria is a life-threatening disease that is caused by parasites that are transmitted to people through the bites
               of infected female Anopheles mosquitoes. In 2019, there were an estimated 89 million people encountered as prevalence  of
               malaria worldwide, and the disease caused approximately 333,769 deaths. The burden of malaria is highest in sub-Saharan Africa, 
               where the disease is a leading cause of morbidity and mortality."),
          br(),
          hr(),
          HTML("The aim of this project is to create a data visualization tool that can be used to explore the burden of malaria in 
               Ethiopia at a subnational level. The tool should allow users to visualize trends in malaria burden over time, as well 
               as differences in burden across different regions of the country. The tool should also allow users to explore differences
               in burden by sex and by different metrics, such as incidence, prevalence, and disability-adjusted life years (DALYs)."), 
          hr(),
          HTML("<b>Methodology</b><br>
          The app utilizes data from the  <a href='https://ghdx.healthdata.org/' target='_blank'>Institute for Health Metrics and Evaluation (IHME)</a>, which provides GBD estimates for various epidemiological
          indicators, including DALYs, YLLs, deaths, incidence, YLDs, and prevalence. The data were collected from various sources, including surveys,
          health facilities, and civil registration systems, and were modeled using a range of statistical models to estimate the burden of disease at 
          the subnational level.
"),
          hr(),
          HTML("<b>App description</b><br>
               The app consists of three tabs: <b>Line Plot, Heat Map, and Data.</b> <br><br>
               <b> Line Plot tab</b><br>
               Line plot displays a line plot of the selected demographics indicator over time for the selected regions. 
               The user can select the gender(male, female, both) , metric(in number, percent in 100, rate in 100,000 ), and 
               measure(DALYs, YLLs, deaths, incidence, YLDs, and prevalence) using the radio buttons. The user can also select
               one or more regions to display on the plot using the checkbox group. The plot is displayed on the main panel, 
               and the user can see the values of the selected demographic indicator for each region over the year.
"),
          HTML("<br><br>
               <b> Heat  Map tab </b><br>
               The Heat Map tab displays a heat map of the selected demographics indicator over time and regions. The user can
               select the gender, metric, and measure using the radio buttons and the drop-down menu. The user can also select one 
               or more regions to display on the plot using the checkbox group. The plot is displayed on the main panel of the
               selected demographic indicator for each region over the year."),
          
          HTML("<br><br>
               <b> Data tab </b><br>
               The Data tab displays the raw data used to generate the plots in an interactive table. The user can sort the table
               by clicking on the column header, and the user can also search for specific values using the search box."),
          hr(),
          HTML(" <b>Disclaimer:</b> The purpose of this app is to fulfill the requirements of problem set 3 for a data visualization course and 
          the data used in this app is for demonstration purposes only and should not be used for any official
               or commercial purposes. The accuracy and completeness of the data are not guaranteed and may vary over the time, and the 
               author of this app is not liable for any errors or omissions in the data or any actions taken based on the information 
               provided by this app. The app intendend to fulfilled Vizualization of data courses problem set 3"),
          hr(),
          HTML("Author: Mohammed Bheser hassen <br>
           Email: <a href= 'mbeshir26@gmail.com'>mbeshir26@gmail.com</a> <br>
               Student at University of Washington<br>
               Research Assistant at IHME" )
        ), 
        
        
        
        
      ),
      br(),
      hr(),
      p("Welcome to Visualization of Malaria Burden in Ethiopia  Shiny App ! To use this app, manipulate the widgets on 
        the side to change the malaria burden figures according to your preferences! To download a high quality image of 
        the plot you've created, you can also download it with the download button. To see the raw data, use the  Data tab
        for an interactive form of the table. The data dictionary is as follows:"),
      tags$ul(
        tags$li(tags$b("Gender"), " - the population gender assigned under malaria burden in... "),
        tags$li(tags$b("Region"), " - the malaria burden located at ..."),
        tags$li(tags$b("Metric"), " - the burden measured at ..."),
        tags$li(tags$b("Measure"), " - Malaria burden explained at ..."),
        
      )
      
      
    )
  )
)
