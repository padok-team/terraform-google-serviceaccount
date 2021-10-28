variable "project" {
  type        = string
  description = "The ID of the project that the service account will be created in. Defaults to the provider project configuration."
}

variable "account_id" {
  type        = string
  description = "The account id that is used to generate the service account email address and a stable unique id."
  validation {
    condition     = can(regex("[a-z]([-a-z0-9]*[a-z0-9])", var.account_id)) && length(var.account_id) >= 6 && length(var.account_id) <= 30
    error_message = "The account_id is not RFC1035 compliant."
  }
}

variable "display_name" {
  type        = string
  description = "The display name for the service account. Can be updated without creating a new resource."
}

variable "create_key" {
  type        = bool
  description = "Set to true to generate a key for this service account."
  default     = false
}

variable "roles" {
  description = "A list of roles for the service account"
  type        = list(string)

  default = [
    "roles/viewer",
  ]
}
