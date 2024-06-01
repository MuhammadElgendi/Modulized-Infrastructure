# Modulized-Terraform Infrastructure 
## 

### Clone the project

```bash
  Git clone https://github.com/MuhammadElgendi/Modulized-Infrastructure-Vodafone-Task-.git
```



### Make sure you are  in the "Modulized-Infrastructure-Vodafone-Task" dir

### Initialize Terraform:
- Initialize your Terraform working directory. This step downloads the necessary provider plugins.
```bash
  terraform init
```

### Plan the Deployment
- Create an execution plan. This step does not actually create or modify any infrastructure; it shows you what actions Terraform will take.
```bash
  terraform plan
```

### Apply the Configuration:
- Apply the Terraform configuration to create or update your infrastructure.

```bash
  terraform apply
```
- You will be prompted to confirm the action. Type yes to proceed.

### Check the State:
- After applying, you can check the current state of your infrastructure using:
```bash
  terraform show
```

### DONT MISS TO!! Destroy the Infrastructure:
- If you need to tear down the infrastructure you created, you can run:
```bash
  terraform show
```
- Similar to apply, you will be prompted to confirm the destruction. Type yes to proceed.
