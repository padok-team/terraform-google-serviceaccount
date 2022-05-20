variable "names" {
  description = ""
  type        = list(string)
}

variable "project_id" {
  description = "The project to deploy the ressrouces to."
  type        = string
}

variable "display_name" {
  description = ""
  type        = string
}

variable "project_roles" {
  description = ""
  type        = list(string)
}

variable "external_project_roles" {
  description = ""
  type        = list(string)
}

variable "secret_roles" {
  description = ""
  type        = list(string)
}

variable "service_account_roles" {
  description = ""
  type        = list(string)
}

variable "kubernetes_members" {
  description = ""
  type        = list(string)
}

variable "bucket_roles" {
  description = ""
  type        = list(string)
}
