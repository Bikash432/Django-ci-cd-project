This project demonstrates how to build, test, and deploy a **Django web application** using:
- ✅ **Jenkins/GitLab CI/CD**
- ✅ **Terraform for Infrastructure as Code**
- ✅ **AWS (EC2, RDS PostgreSQL, S3, Auto Scaling)**

---

## 🚀 Project Structure

django-ci-cd-project/
├── django_project/ # Django app and settings
│ └── requirements.txt # Python dependencies
├── infra/ # Terraform configuration for AWS
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── deploy.sh # EC2 deployment script
├── Jenkinsfile # Jenkins CI/CD pipeline
└── .gitlab-ci.yml # GitLab CI/CD pipeline (optional)



---

## 🔧 Setup Instructions

### 📦 1. Install Prerequisites

- [Python 3.8+](https://www.python.org/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Git](https://git-scm.com/)
- (Optional) Jenkins or GitLab Runner

---

### 🌐 2. Clone & Configure

```bash
git clone https://github.com/your-username/django-ci-cd-project.git
cd django-ci-cd-project
Create a virtual environment:

python3 -m venv venv
source venv/bin/activate
pip install -r django_project/requirements.txt
🛠️ 3. Terraform: Provision AWS Infrastructure
Update infra/main.tf with your subnet ID and AWS credentials


cd infra
terraform init
terraform apply -auto-approve
Retrieve outputs (RDS endpoint, S3 bucket name):


terraform output
⚙️ 4. Django Setup
Inside django_project/settings.py:


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'django_db',
        'USER': 'admin',
        'PASSWORD': 'YourSecurePass123',
        'HOST': '<RDS_ENDPOINT_FROM_TERRAFORM>',
        'PORT': '5432',
    }
}
For S3 storage, configure:

AWS_STORAGE_BUCKET_NAME = '<BUCKET_NAME>'
AWS_S3_REGION_NAME = 'us-east-1'
🔁 5. CI/CD Options
✅ Option 1: Jenkins
Ensure Jenkins server is configured with:

Git

Python

AWS credentials

SSH key to EC2

Jenkins will:

Lint code

Run tests

Apply Terraform

Deploy to EC2 using deploy.sh

✅ Option 2: GitLab
Push to GitLab and use .gitlab-ci.yml to:

Test

Lint

Deploy app

🧪 6. Run Locally (Optional)
bash
Copy
Edit
cd django_project
python manage.py migrate
python manage.py runserver
Visit http://127.0.0.1:8000/

📚 Features
Full DevOps pipeline

Clean code with flake8/black

Unit testing with pytest

AWS infrastructure using Terraform

Django app served by Gunicorn

📦 Technologies Used
Python + Django

Terraform (AWS Provider)

Jenkins / GitLab CI

pytest, flake8, black

AWS EC2, RDS, S3, Auto Scaling

🤝 Contributing
Feel free to fork the repo and submit a pull request. Open issues for feature suggestions or bugs.

🪪 License
MIT License – © 2025 Bikash Thapa Magar


---

### ✅ Final Tip

To push to GitHub:

```bash
git init
git remote add origin https://github.com/your-username/django-ci-cd-project.git
git add .
git commit -m "Initial commit"
git push -u origin main
