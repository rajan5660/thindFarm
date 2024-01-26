
# 
# gestation_details<-data.frame(read_sheet("https://docs.google.com/spreadsheets/d/1NanDDlcVIqXSzKd2jxTUfKt4m87pPnjIRFaf5faSfgc/edit#gid=588818546"))
# gestation_details<-gestation_details[2:nrow(gestation_details), ]
# gestation_details$Mating.Date<-strftime(gestation_details$Mating.Date, "%d-%b-%Y")
# gestation_details$Check.Heat<-strftime(gestation_details$Check.Heat, "%d-%b-%Y")
# gestation_details$Farrowing.Date<-strftime(gestation_details$Farrowing.Date, "%d-%b-%Y")
# 
# next_heat_check<-gestation_details[gestation_details$Days.Left.in.Heat>0, c(2, 3, 4, 5)]
# next_heat_check<-next_heat_check[order(next_heat_check$Days.Left.in.Heat),]
# next_heat_check
# 
# next_farrow_check<-gestation_details[gestation_details$Days.Left.in.Farrowing>0, c(2, 3, 6, 7)]
# next_farrow_check<-next_farrow_check[order(next_farrow_check$Days.Left.in.Farrowing),]
# next_farrow_check<-next_farrow_check[ !duplicated(next_farrow_check[, c("TagID")], fromLast=T),]
# next_farrow_check
# 
# output$heatStatus<-renderDataTable(
#   DT::datatable(next_heat_check,escape = TRUE ,rownames = FALSE, class = "small cell-border stripe", style="default",
#                 options= list(bPaginate= TRUE, bLengthChange=FALSE, 
#                               ordering= F, columnDefs = list (list (width='80px', targets = "_all")), 
#                               searching=TRUE, rownames=FALSE, scrollResize=TRUE, scrollCollapse=TRUE, 
#                               scrollX= TRUE, scrollY= "200px", fixedHeader = TRUE,  class = 'cell-border stripe'),
#                 editable = list(target = 'row', disable = list(columns = c(1, 3, 4))))
# )
# 
# output$farrowStatus<-renderDataTable(
#   DT::datatable(next_farrow_check,escape = TRUE ,rownames = FALSE, class = "small cell-border stripe", style="default",
#                 options= list(bPaginate= TRUE, bLengthChange=FALSE, 
#                               ordering= F, columnDefs = list (list (width='80px', targets = "_all")), 
#                               searching=TRUE, rownames=FALSE, scrollResize=TRUE, scrollCollapse=TRUE, 
#                               scrollX= TRUE, scrollY= "200px", fixedHeader = TRUE,  class = 'cell-border stripe'),
#                 editable = list(target = 'row', disable = list(columns = c(1, 3, 4))))
# )
# 
# 
# ###Litter details
# farrowing_details<-data.frame(read_sheet("https://docs.google.com/spreadsheets/d/11HQh4ajEOW7CmUrRW9BbvJE_-VgZls-p9uv-W3k4wtE/edit#gid=743936527"))
# farrowing_details<-farrowing_details[,c(2:ncol(farrowing_details)) ]
# farrowing_details$FirstIronDose<-strftime(farrowing_details$FirstIronDose, "%d-%b-%Y")
# farrowing_details$SecondIronDose<-strftime(farrowing_details$SecondIronDose, "%d-%b-%Y")
# farrowing_detailsPencilinDose<-strftime(farrowing_details$PencilinDose, "%d-%b-%Y")
# output$litterStatus<-renderDataTable(
#   DT::datatable(farrowing_details,escape = TRUE ,rownames = FALSE, class = "small cell-border stripe", style="default",
#                 options= list(bPaginate= TRUE, bLengthChange=FALSE, 
#                               ordering= F, columnDefs = list (list (width='80px', targets = "_all")), 
#                               searching=TRUE, rownames=FALSE, scrollResize=TRUE, scrollCollapse=TRUE, 
#                               scrollX= TRUE, scrollY= "200px", fixedHeader = TRUE,  class = 'cell-border stripe'),
#                 editable = list(target = 'row', disable = list(columns = c(1, 3, 4))))
# )