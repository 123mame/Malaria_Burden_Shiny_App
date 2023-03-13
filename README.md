# Shiny App for Interactive Visualization of Malaria Burden in Ethiopia 
https://mbeshir.shinyapps.io/Malaria_Burden_app/

## Here's a summary of what the code does:
1. The necessary packages are loaded: shiny, ggplot2, and dplyr – If you were not already install it, please use the following commands install. package(package_name)
2. The malaria burden data for Ethiopia is read from a CSV file and stored in a data frame called "df".
3. The UI is defined using the fluidPage() function,  which creates a Shiny app layout that contains a title, sidebarPanel, and mainPanel. The sidebarPanel contains several input controls (radio buttons and a checkbox group) that allow the user to select various options for filtering the data. The mainPanel contains several tabs that display the plots and raw data table.
4. The server is defined using the server() function. It contains a reactive() function that filters the data based on the user's selected options. Two output functions render the line plot and heat map using ggplot2.
5. The Shiny app is run using the shinyApp() function.


## DATA:
The app utilizes data from the Institute for Health Metrics and Evaluation (IHME), which provides GBD estimates for various epidemiological indicators, including DALYs, YLLs, deaths, incidence, YLDs, and prevalence. 


## To run:

1. Clone this repository to your local machine
2. Install the required packages (shiny, gg)
3. Open RStudio and set the working directory to the folder containing the app files
4. Run the following command: `shiny::runApp()`
5. The app will open in a web browser

Author: Mohammed Bheser hassen <br>
           Email: <a href= 'mbeshir26@gmail.com'>mbeshir26@gmail.com</a> <br>
               Student at University of Washington<br>
               Research Assistant at IHME" )
