db_connection<-function(){
  # t1<-Sys.time()
  # mydb = dbConnect(MySQL(), user='root', password='Thind5660$', dbname='mysql', host='192.168.1.103')
  # tandh_tbl<-dbReadTable(mydb, "tandh_tbl")
  # dbDisconnect(mydb)
  # lapply(dbListConnections( dbDriver( drv = "MySQL")), dbDisconnect)
  # t2<-Sys.time()
  # print(t2-t1)
  # return(tandh_tbl[nrow(tandh_tbl),])
  
  mydb <-  dbConnect(MySQL(), user = "Rajan", password = "Rajan5660$", dbname = "thindPigFarm", host = "34.131.215.133", port = 3306)
  #dbDisconnect(mydb)
}

