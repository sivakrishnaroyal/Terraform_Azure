
# Create a resource group
resource "azurerm_resource_group" "scbgroup-india" {
  name     = "scb-sivaindia"
  location = "uksouth"
}

# Create a Storage Account
resource "azurerm_storage_account" "scb-storage-india" {
  name                     = "scbindiagenreal"
  resource_group_name      = azurerm_resource_group.scbgroup-india.name
  location                 = azurerm_resource_group.scbgroup-india.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create container for HDInsight cluster storage
resource "azurerm_storage_container" "container-india" {
  name                  = "prd"
  storage_account_name  = azurerm_storage_account.scb-storage-india.name
  container_access_type = "private"
}
