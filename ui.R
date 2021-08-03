#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

   navbarPage(title="FBS Compilation",id="SuaFbs",
              
               tabPanel("Login",
                        login_module_ui("login")
               ),
              tabPanel("Home",
                       home_page_module_ui("home")
                       ),
              tabPanel("Production",
                       production_module_ui("prod")
                       ),
              tabPanel("Settings",
                       
                        settings_module_ui("settings")
              ),
              tabPanel("SUA unbalanced",
                       sua_unbalanced_module_ui("suaUn"))
              
              )
))
