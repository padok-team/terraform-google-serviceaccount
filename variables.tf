variable "service_accounts" {
  description = "test"
  type = map(object({
    permissions = optional(list(string)),
    roles       = optional(list(string)),
    key         = optional(bool),
    description = string
  }))
}
