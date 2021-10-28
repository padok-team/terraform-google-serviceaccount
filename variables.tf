variable "project" {
  type        = string
  description = "The ID of the project that the service account will be created in. Defaults to the provider project configuration."
}

variable "account_id" {
  type        = string
  description = "The account id that is used to generate the service account email address and a stable unique id."
}

variable "display_name" {
  type        = string
  description = "The display name for the service account. Can be updated without creating a new resource."
}

# variable "email" {
#   type        = string
#   description = "The email for a human user"
# }

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
