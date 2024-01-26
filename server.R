server <- function(input, output, session){
  
  observe({
    mydb<-db_connection()
    boar_data<-dbReadTable(mydb,"boar_table")
    colnames(boar_data)<-c("Boar ID", "Import Date", "Imported From")
    
    output$boar_data_DT<-renderDataTable(
      datatable(boar_data, escape = FALSE, rownames = FALSE, class = "cell-border stripe", selection = "none", style = "default",
                options = list(
                  bgPaginate = FALSE, bLengthChange = FALSE, ordering = FALSE, searching = TRUE, rownames = FALSE,scrollX = TRUE, 
                  scrollResize = TRUE, srollCollapse = TRUE, scrollY= "260px", fixedHeader = TRUE, class = "cell-border stripe", paging = FALSE, info = FALSE
                ))
    )
    updateSelectInput(session = session, inputId = "mate_boar_no", choices = boar_data$`Boar ID`,selected = character(0))
    
    mating_data<-dbReadTable(mydb,"mating_table")
    output$mating_data_DT<-renderDataTable(
      datatable(mating_data, escape = FALSE, rownames = FALSE, class = "cell-border stripe", selection = "none", style = "default",
                options = list(
                  bgPaginate = FALSE, bLengthChange = FALSE, ordering = FALSE, searching = TRUE, rownames = FALSE,scrollX = TRUE, 
                  scrollResize = TRUE, srollCollapse = TRUE, scrollY= "260px", fixedHeader = TRUE, class = "cell-border stripe", paging = FALSE, info = FALSE
                ))
    )
    dbDisconnect(mydb)
  })
  
  
  ####Observe Event for Boar module#####
  boar_data_proxy<- dataTableProxy("boar_data_DT")
  observeEvent(input$add_button_boar, ignoreNULL = TRUE, ignoreInit = TRUE, {
    boar_tag_No<-input$boar_tag_No
    date_of_import<-(input$date_of_import)
    imported_from<-input$imported_from
    query <- paste("INSERT INTO boar_table VALUES(", "'",boar_tag_No, "'",",", "'", date_of_import, "'",",", "'",imported_from, "'", ")", sep = "")
    tryCatch({
      mydb<-db_connection()
    }, error = function(e) {
      shinyalert::shinyalert("Not able to establish database connection")
      return(0)
    })
    
    tryCatch({
      dbGetQuery(mydb, query)
      
      shinyjs::reset("boar_tag_No")
      shinyjs::reset("date_of_import")
      shinyjs::reset("imported_from")
      shinyalert::shinyalert("Boar added succesfully.")
    }, error = function(e) {
      shinyalert::shinyalert("Not able to perform the query")
    })
    
    
    ###Get boar table data to show case in DT
    boar_data<-dbReadTable(mydb,"boar_table")
    colnames(boar_data)<-c("Boar ID", "Import Date", "Imported From")
    
    DT::replaceData(boar_data_proxy, boar_data,rownames= FALSE)
    dbDisconnect(mydb)
  })
  
  ####Observe Event for Boar module#####
  mating_data_proxy<- dataTableProxy("mating_data_DT")
  observeEvent(input$add_button_mating, ignoreNULL = TRUE, ignoreInit = TRUE, {
    tag_No<-input$tag_no
    mate_boar_no<-(input$mate_boar_no)
    tag_colour<-input$tag_colour
    category<-input$category
    shot_type<-(input$shot_type)
    date_of_mating<-input$date_of_mating
    mating_comments<-input$mating_comments
    next_heat_date<-date_of_mating+21
    farrowing_date<-date_of_mating+114
    days_in_heat<-21
    days_in_farrowing<-114
    
    query <- paste("INSERT INTO mating_table VALUES(",
                   "'", tag_No, "'",",",
                   "'", mate_boar_no, "'",",",
                   "'", tag_colour, "'",",",
                   "'", category, "'",",",
                   "'", shot_type, "'",",",
                   "'", date_of_mating, "'",",",
                   "'", next_heat_date, "'",",",
                   "'", days_in_heat, "'",",",
                   "'", farrowing_date, "'",",",
                   "'", days_in_farrowing, "'",",",
                   "'", mating_comments, "'",
                   ")", sep = "")
    tryCatch({
      mydb<-db_connection()
    }, error = function(e) {
      shinyalert::shinyalert("Not able to establish database connection")
      return(0)
    })

    tryCatch({
      dbGetQuery(mydb, query)
      shinyjs::reset("tag_no")
      shinyjs::reset("mate_boar_no")
      shinyjs::reset("tag_colour")
      shinyjs::reset("category")
      shinyjs::reset("shot_type")
      shinyjs::reset("date_of_mating")
      shinyjs::reset("mating_comments")
      shinyalert::shinyalert("Details added succesfully.")
    }, error = function(e) {
      shinyalert::shinyalert("Not able to perform the query")
    })


    ###Get boar table data to show case in DT
    mating_data<-dbReadTable(mydb,"mating_table")
    #colnames(boar_data)<-c("Boar ID", "Import Date", "Imported From")

    DT::replaceData(mating_data_proxy, mating_data,rownames= FALSE)
    dbDisconnect(mydb)
  })
  
  
}

