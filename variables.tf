# Configure the Azure Provider with passing variables
provider "azurerm" {
    subscription_id = var.subscription_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    features {}
}

#Creating variables definitions

variable "subscription_id" {
  type        = string
  default     = ""
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
    type        = string
    default     = ""
    description = "Enter the client ID for application created in Azure AD"
}

variable "client_secret" {
    type        = string
    default     = ""
    description = "Enter the client secret for application created in Azure AD"
}

variable "tenant_id" {
    type        = string
    default     = ""
    description = "Enter the  tenant ID for application created in Azure AD"
}

