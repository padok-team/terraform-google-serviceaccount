variable "service_accounts" {
  description = "test"
  type = map(object({
    permissions = list(string),
    roles       = list(string),
    key         = optional(bool),
    description = string
  }))
}
