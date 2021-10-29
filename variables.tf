variable "list_serviceaccount" {
  description = "test"
  type = map(object({
    permissions      = list(string),
    predifined_roles = list(string),
    key              = optional(bool),
    description      = string
  }))
}
