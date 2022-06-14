param rgname string
param location string
param vmname string
param location  string
param osdisk string
param vnet  string
param vmadmin string
param vmpass  string
param sqlsvr string
param sqladmin string
param sqlpass string
param dbSku string
param dbName string
param subscriptionId string

targetScope = 'subscription'


//RG

module RG './challenge1/rg.bicep' = {
  scope: subscription(subscriptionId)
  name: 'RG Deploy'
  params: {
    rgname: rgname
    location: location
  }
}

//VM 

module VM './challenge1/vm.bicep' = {
  scope: resourceGroup(rgname)
  name: 'VMdeploy'
  params: {
   vmname: vmname
   location: location
   osdisk: osdisk
   vnet: vnet
   vmadmin: vmadmin
   vmpass: vmpass
  }
  dependsOn: [
    RG
  ]
}

//sql server 

module sqlServer './challenge1/sqlServer.bicep' = {
  scope: resourceGroup(rgname)
  name: 'sqlServerDeploy'
  params: {
    sqlsvr: sqlsvr
    sqladmin: sqladmin
    sqlpass: sqlpass
  }
  dependsOn: [
	RG
  ]
}

//sql db
module sqlDatabase './challenge1/sqlDb.bicep' = {
  name: 'sqlDatabaseDeploy'
  scope: resourceGroup(rgname)
  params: {
    sqlsvr: sqlsvr
    dbSku: dbSku
    dbName: dbName
    subscriptionId: subscriptionId
  }
  dependsOn: [
    sqlServer
    RG
  ]
}