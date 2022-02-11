variable "service_accounts" {
  description = "List of service account which will be created by Terraform. You have to provide a description. Permissions, roles and key are optionals."
  type = map(object({
    permissions = optional(list(string)),
    roles       = optional(list(string)),
    key         = optional(bool),
    description = string
  }))
}
