Task Implementation
===================
- Overall implemetation, please see Architecture-overview.png attached
- Added the provider block for selected cloud in this case AWS
- Created an S3 bucket &a DynamoDB table for remote state and locking respectively
- S3 bucket enabled versioning for back-up
$ terraform fmt -recursive
$ terraform validate

AI 
- since I had to do this within the suggested timeframe, I used AI to quickly suggest remcommendations in which I applied the final logic based on my IaC knowledge

Further Improvements
- we can sub-devide into private and isolated Lambda submodules
- Consider having a networking module for grouping networking related resources
- Herein environment is hardcorded, we may consider to make use of Terraform workspaces or variable per environment
- Tighten security e.g. VPC Flow Logs and revisit the least privilege principle
- Oversight like monitoring CloudWatch logs, alarms and alerts
- Have good cost optimisation in place to monotr resource usage and optimal use case as needed by the business
