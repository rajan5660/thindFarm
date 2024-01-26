## ui.R ##
library(shinydashboard)
library(DT)
library(RMySQL)

source("db_connection.R")
#library("googlesheets4")




dashboardPage(
  dashboardHeader(title = "Thind Pig Farm", tags$li(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")), class = "dropdown")),
  dashboardSidebar(
    sidebarMenu(id= "tabs", 
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Boar Data", tabName = "boarData",icon = icon("th")),
      menuItem("Mating Data", tabName = "matingdata",icon = icon("th"),selected = TRUE)
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",shinyjs::useShinyjs(),
              fluidRow(
                box(title = "Heat Status",status = "primary", width = 6,
                    DT::dataTableOutput(outputId = "heatStatus")),
                box(title = "Gestation Status",status = "primary", width = 6,
                    DT::dataTableOutput(outputId = "farrowStatus"))
                
                ),
              fluidRow(
                box(title = "Lactating Status",status = "primary", width = 12,
                    DT::dataTableOutput(outputId = "litterStatus"))
                )
              ),
      tabItem(tabName = "boarData",
              box( width = "100%",title = "Add New Boar",collapsible = TRUE, collapsed = TRUE,solidHeader = TRUE,status = "primary",
                fluidRow(
                  column(width = 2, numericInput(inputId = "boar_tag_No", label = "Tag No",value = "",min = 1, max = 100)),
                  column(width = 2, dateInput(inputId = "date_of_import",label = "Date of Import")),
                  column(width = 2, textInput(inputId = "imported_from",label = "Imported From")),
                  column(width = 2, actionButton(inputId = "add_button_boar", "Add Boar"))
                )),
                box(width = "100%",
                  dataTableOutput("boar_data_DT")
                )
                
      ),
      tabItem(tabName = "matingdata",
              box( width = "100%",title = "Add New Mating Details",collapsible = TRUE, collapsed = FALSE,solidHeader = TRUE,status = "primary",
                   fluidRow(
                     column(width = 1, numericInput(inputId = "tag_no", label = "Tag No",value = "",min = 1, max = 100)),
                     column(width = 1, selectInput(inputId = "mate_boar_no",label = "Boar Id",choices = "",multiple = TRUE)),
                     column(width = 1, selectInput(inputId = "tag_colour",label = "Tag Colour",choices = c("Blue", "Green", "Yellow"))),
                     column(width = 2, radioButtons(inputId = "category",label = "Category",choices = c("Sow", "Gilt"), inline = TRUE)),
                     column(width = 2, selectInput(inputId = "shot_type",label = "Shot",choices = c("Single", "Double","Three" ,"Overnite"),selected = "Double")),
                     column(width = 2, dateInput(inputId = "date_of_mating",label = "Date of Mating")),
                     column(width = 2, textInput(inputId = "mating_comments",label = "Comments")),
                     column(width = 2, actionButton(inputId = "add_button_mating", "Add"))
                   )),
              box(width = "100%",
                  dataTableOutput("mating_data_DT")
              )
              
      )
    )
  )
)