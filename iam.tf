resource "google_storage_bucket_iam_member" "main" {
  for_each = var.iam_members != null && length(var.iam_members) > 0 ? {
    for pair in flatten([
      for role, members in var.iam_members : [
        for member in members : {
          role   = role
          member = member
          key    = "${role}-${member}"
        }
      ]
    ]) : pair.key => pair
  } : {}

  bucket = google_storage_bucket.main.name
  role   = each.value.role
  member = each.value.member
}

locals {
  folder_role_members = {
    for pr in distinct(flatten([
      for folder, data in var.folders : [
        for role in keys(data.permissions) : "${folder}:${role}"
      ]
    ])) : pr => {
      folder  = split(":", pr)[0]
      role    = split(":", pr)[1]
      members = flatten([
        for folder2, data2 in var.folders : [
          for role2, mems in data2.permissions : mems
            if "${folder2}:${role2}" == pr
        ]
      ])
    }
  }
}

resource "google_storage_managed_folder_iam_binding" "main" {
  for_each = length(local.folder_role_members) > 0 ? local.folder_role_members : {}

  bucket         = google_storage_bucket.main.name
  managed_folder = google_storage_managed_folder.main[each.value.folder].name
  role           = each.value.role
  members        = each.value.members
}
