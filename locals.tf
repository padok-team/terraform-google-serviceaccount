locals {
  project_roles = flatten([
    for key, object in var.project_roles : [
      for resource in object.resources: [
        for role in object.roles : {
          resource = resource
          role     = role
        }
      ]
    ]
  ])

  secret_roles = flatten([
    for key, object in var.secret_roles : [
      for resource in object.resources: [
        for role in object.roles : {
          resource = resource
          role     = role
        }
      ]
    ]
  ])

  service_account_roles = flatten([
    for key, object in var.service_account_roles : [
      for resource in object.resources: [
        for role in object.roles : {
          resource = resource
          role     = role
        }
      ]
    ]
  ])

  bucket_roles = flatten([
    for key, object in var.bucket_roles : [
      for resource in object.resources: [
        for role in object.roles : {
          resource = resource
          role     = role
        }
      ]
    ]
  ])

  members = flatten([
    for key, object in var.members : [
      for entity in object.entities: [
        for role in object.roles : {
          resource = entity
          role     = role
        }
      ]
    ]
  ])

  kubernetes_members = [for member in var.kubernetes_members : "serviceAccount:${member.workload_identity_pool}[${member.namespace}/${member.name}]"]
}
