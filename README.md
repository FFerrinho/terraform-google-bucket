## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.61.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.main](https://registry.terraform.io/providers/hashicorp/google/4.61.0/docs/resources/storage_bucket) | resource |
| [random_id.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_byte_length"></a> [byte\_length](#input\_byte\_length) | The byte length for the random ID. | `number` | `2` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to force destroy the bucket. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels for the bucket. | `map(string)` | <pre>{<br>  "managed": "terraform"<br>}</pre> | no |
| <a name="input_lifecycle_rule_action_storage_class"></a> [lifecycle\_rule\_action\_storage\_class](#input\_lifecycle\_rule\_action\_storage\_class) | The storage class for the lifecycle rule action. | `string` | `"NEARLINE"` | no |
| <a name="input_lifecycle_rule_action_type"></a> [lifecycle\_rule\_action\_type](#input\_lifecycle\_rule\_action\_type) | The type for the lifecycle rule action. | `string` | `"Delete"` | no |
| <a name="input_lifecycle_rule_condition_age"></a> [lifecycle\_rule\_condition\_age](#input\_lifecycle\_rule\_condition\_age) | The age for the lifecycle rule condition. | `number` | `30` | no |
| <a name="input_lifecycle_rule_condition_created_before"></a> [lifecycle\_rule\_condition\_created\_before](#input\_lifecycle\_rule\_condition\_created\_before) | The created before for the lifecycle rule condition. | `string` | `"2019-01-01"` | no |
| <a name="input_lifecycle_rule_condition_is_live"></a> [lifecycle\_rule\_condition\_is\_live](#input\_lifecycle\_rule\_condition\_is\_live) | The is live for the lifecycle rule condition. | `bool` | `false` | no |
| <a name="input_lifecycle_rule_condition_num_newer_versions"></a> [lifecycle\_rule\_condition\_num\_newer\_versions](#input\_lifecycle\_rule\_condition\_num\_newer\_versions) | The number of newer versions for the lifecycle rule condition. | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for the bucket. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name for the bucket. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project for the bucket. | `string` | n/a | yes |
| <a name="input_public_access_prevention"></a> [public\_access\_prevention](#input\_public\_access\_prevention) | Whether to enable public access prevention for the bucket. | `string` | `"inherited"` | no |
| <a name="input_random_id"></a> [random\_id](#input\_random\_id) | If a numeric random ID is to be used as suffix for resources names. | `bool` | `true` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | The storage class for the bucket. | `string` | `"STANDARD"` | no |
| <a name="input_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | Whether to enable uniform bucket-level access for the bucket. | `bool` | `false` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether to enable versioning for the bucket. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of the bucket. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource. |
| <a name="output_url"></a> [url](#output\_url) | The bucket's website URL. |
