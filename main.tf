
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

# Create  HDInsight cluster for Spark
resource "azurerm_hdinsight_spark_cluster" "HDInsight-Spark" {
  name                = "spark-hdicluster-scb"
  resource_group_name = azurerm_resource_group.scbgroup-india.name
  location            = azurerm_resource_group.scbgroup-india.location
  cluster_version     = "3.6"
  tier                = "Standard"

  component_version {
    spark = "2.3"
  }

  gateway {
    enabled  = true
    username = var.username
    password = var.password
  }

  storage_account {
    storage_container_id = azurerm_storage_container.container-india.id
    storage_account_key  = azurerm_storage_account.scb-storage-india.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Large"
      username = var.username
      password = var.password
    }

    worker_node {
      vm_size               = "Large"
      username              = var.username
      password              = var.password
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Large"
      username = var.username
      password = var.password
    }
  }
}