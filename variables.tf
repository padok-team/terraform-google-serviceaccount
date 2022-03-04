variable "service_accounts" {
  description = "The list of service account which will be created by Terraform. You have to provide a description. Permissions, roles and key are optional."
  type = map(object({
    permissions = optional(list(string)),
    roles       = optional(list(string)),
    key         = optional(bool),
    description = string
  }))
}
