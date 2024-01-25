values<-reactiveValues()
observe({
  invalidateLater(3000, session)
  tryCatch(
    {
      latest_row<-db_connection()
      values$temp<-latest_row$temp
      values$humidity<-latest_row$humidity
      values$motor_flag<-latest_row$motor_flag
    },error=function(cond) {
      print(cond)
    }
  )
  
  
  values$temp<-latest_row$temp
  values$humidity<-latest_row$humidity
})

output$tempInfoBox <- renderInfoBox({
  #invalidateLater(3000, session)
  infoBox(title = "ਤਾਪਮਾਨ",  value =  paste0(values$temp, "°C"), icon = icon("thermometer"),
          color = "maroon",subtitle = "Temperature")
  
})
output$humidityInfoBox <- renderInfoBox({
  #invalidateLater(3000, session)
  infoBox(
    title = "ਨਮੀ / Humidity", value = paste0(values$humidity, "%"), icon = icon("tint"),
    color = "aqua"
  )
})
output$foggerInfoBox <- renderInfoBox({
  #invalidateLater(3000, session)
  infoBox(
    title = "Fogger / ਫੋਗਰ", value = ifelse(values$motor_flag==1, "ON","OFF"), icon = icon("gear"),
    color = "aqua"
  )
})

output$foggerInfoBox <- renderInfoBox({
  #invalidateLater(3000, session)
  infoBox(
    title = "Fogger / ਫੋਗਰ", value = ifelse(values$motor_flag==1, "ON","OFF"), icon = icon("gear"),
    color = "aqua"
  )
})