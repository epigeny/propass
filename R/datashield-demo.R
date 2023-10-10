library(DSOpal)
library(dsBaseClient)
builder <- DSI::newDSLoginBuilder()
url <- 'https://opal-demo.obiba.org'
builder$append(server = "study1",  url = url,
               user = "dsuser", password = "P@ssw0rd",
               profile = "default")
builder$append(server = "study2",  url = url,
               user = "dsuser", password = "P@ssw0rd",
               profile = "default")
logindata <- builder$build()
conns <- DSI::datashield.login(logins = logindata)

# lifestyle
datashield.assign.resource(conns, "lsres", resource = list(study1 = "ProPass.lifestyle_study1", study2 = "ProPass.lifestyle_study2"))
datashield.assign.expr(conns, 'lfst', 'as.resource.data.frame(lsres, strict = TRUE)')
datashield.aggregate(conns, 'colnamesDS("lfst")')
datashield.aggregate(conns, 'meanDS(lfst$age)')
# accelerometer
datashield.assign.resource(conns, "accres", resource = list(study1 = "ProPass.accelerometer_study1", study2 = "ProPass.accelerometer_study2"))
datashield.assign.expr(conns, 'acc', 'as.resource.data.frame(accres, strict = TRUE)')
datashield.aggregate(conns, 'colnamesDS("acc")')
datashield.aggregate(conns, 'meanDS(acc$hdl)')

datashield.logout(conns)
