param sqlsvr string
param location  string
param sqladmin string
param sqlpass  string

targetScope = 'resourceGroup'

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: sqlsvr
  location: location
  properties: {
    administratorLogin: sqladmin
    administratorLoginPassword: sqlpass
    version: '12.0'
  }
}
