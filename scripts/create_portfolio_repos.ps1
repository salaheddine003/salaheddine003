$ErrorActionPreference = "Stop"

$root = "C:\Users\HOME\Desktop\source\generated-portfolio-repos"
$author = "Salaheddine Abbar"
$email = "salaheddine.abbar@gmail.com"

function Write-TextFile {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
    Set-Content -LiteralPath $Path -Value $Content -Encoding UTF8
}

function LicenseText {
    return @"
MIT License

Copyright (c) 2026 Salaheddine Abbar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@
}

function ReadmeText {
    param(
        [string]$Title,
        [string]$Year,
        [string]$Category,
        [string]$Description,
        [string]$Tech,
        [string]$RunCommand
    )
    return @"
# $Title

$Description

Author: **$author**  
Year: **$Year**  
Category: **$Category**

## Technologies

$Tech

## Features

- Clean beginner-friendly project structure
- Small realistic dataset or sample input when useful
- Simple execution flow
- Documentation ready for a GitHub portfolio

## Project Structure

```text
.
|-- README.md
|-- LICENSE
|-- src/
|-- data/
|-- docs/
```

## Installation

Clone the repository and install the dependencies listed in the project files.

## Usage

```bash
$RunCommand
```

## Future Improvements

- Add automated tests
- Add screenshots or execution logs
- Add Docker or CI/CD when relevant

## License

MIT License. See [LICENSE](LICENSE).
"@
}

$projects = @(
    @{Year="2021"; Slug="python-fundamentals"; Title="Python Fundamentals"; Category="Python"; Type="python"; Description="A collection of Python fundamentals exercises covering variables, conditions, loops, functions and file handling."; Tech="- Python 3`n- CLI scripts"},
    @{Year="2021"; Slug="java-oop"; Title="Java OOP"; Category="Java"; Type="java"; Description="A small Java object-oriented programming project demonstrating classes, encapsulation, inheritance and collections."; Tech="- Java`n- OOP"},
    @{Year="2021"; Slug="html-css-portfolio"; Title="HTML CSS Portfolio"; Category="Web"; Type="web"; Description="A simple responsive personal portfolio built with HTML and CSS."; Tech="- HTML5`n- CSS3"},
    @{Year="2021"; Slug="sql-basics"; Title="SQL Basics"; Category="Databases"; Type="sql"; Description="SQL practice project with schema creation, inserts, filtering, joins and aggregations."; Tech="- SQL`n- SQLite or PostgreSQL"},
    @{Year="2021"; Slug="file-management-system"; Title="File Management System"; Category="Python"; Type="python-files"; Description="A Python CLI tool that organizes files by extension and generates a summary report."; Tech="- Python 3`n- pathlib`n- JSON"},

    @{Year="2022"; Slug="weather-app"; Title="Weather App"; Category="Web"; Type="web-api"; Description="A lightweight weather application layout using JavaScript and a mock weather API response."; Tech="- HTML5`n- CSS3`n- JavaScript"},
    @{Year="2022"; Slug="student-management-system"; Title="Student Management System"; Category="Java"; Type="java-crud"; Description="A Java CRUD application for managing students, grades and simple reports."; Tech="- Java`n- Collections`n- CLI"},
    @{Year="2022"; Slug="rest-api-java-spring-boot"; Title="REST API Java Spring Boot"; Category="Backend"; Type="spring"; Description="A Spring Boot REST API skeleton for managing students through clean controller/service layers."; Tech="- Java`n- Spring Boot`n- Maven"},
    @{Year="2022"; Slug="data-analysis-pandas"; Title="Data Analysis with Pandas"; Category="Data Science"; Type="pandas"; Description="A pandas analysis project that cleans sales data and computes useful business KPIs."; Tech="- Python`n- pandas`n- matplotlib"},
    @{Year="2022"; Slug="power-bi-dashboard"; Title="Power BI Dashboard"; Category="Business Intelligence"; Type="bi"; Description="A dashboard specification project with sample sales data, KPI definitions and Power BI layout notes."; Tech="- Power BI`n- CSV`n- Data visualization"},

    @{Year="2023"; Slug="machine-learning-classification"; Title="Machine Learning Classification"; Category="Data Science"; Type="ml"; Description="A supervised classification baseline using scikit-learn with train/test split and evaluation metrics."; Tech="- Python`n- pandas`n- scikit-learn"},
    @{Year="2023"; Slug="data-cleaning-pipeline"; Title="Data Cleaning Pipeline"; Category="Data Engineering"; Type="cleaning"; Description="A reusable data cleaning pipeline that validates rows, standardizes columns and exports clean data."; Tech="- Python`n- pandas`n- pytest"},
    @{Year="2023"; Slug="etl-python"; Title="ETL with Python"; Category="Data Engineering"; Type="etl"; Description="A basic ETL workflow extracting CSV data, transforming it and loading a clean output dataset."; Tech="- Python`n- pandas`n- CSV"},
    @{Year="2023"; Slug="web-scraping"; Title="Web Scraping"; Category="Python"; Type="scraping"; Description="A simple web scraping project that parses HTML content and exports structured results."; Tech="- Python`n- BeautifulSoup`n- requests"},
    @{Year="2023"; Slug="flask-api"; Title="Flask API"; Category="Backend"; Type="flask"; Description="A small Flask REST API exposing health checks and CRUD-like endpoints."; Tech="- Python`n- Flask`n- REST API"},
    @{Year="2023"; Slug="docker-basics"; Title="Docker Basics"; Category="DevOps"; Type="docker"; Description="A minimal containerized Python application with Dockerfile and docker-compose."; Tech="- Docker`n- Docker Compose`n- Python"},

    @{Year="2024"; Slug="ai-chatbot"; Title="AI Chatbot"; Category="Artificial Intelligence"; Type="chatbot"; Description="A rule-based chatbot prototype with intent detection and API-ready structure."; Tech="- Python`n- NLP basics`n- JSON intents"},
    @{Year="2024"; Slug="movie-recommendation"; Title="Movie Recommendation"; Category="Data Science"; Type="recommendation"; Description="A content-based movie recommendation demo using simple similarity scoring."; Tech="- Python`n- pandas`n- scikit-learn"},
    @{Year="2024"; Slug="sentiment-analysis"; Title="Sentiment Analysis"; Category="NLP"; Type="sentiment"; Description="A sentiment analysis baseline for classifying short text reviews."; Tech="- Python`n- scikit-learn`n- NLP"},
    @{Year="2024"; Slug="data-warehouse"; Title="Data Warehouse"; Category="Databases"; Type="warehouse"; Description="A star-schema data warehouse example with facts, dimensions and analytical SQL queries."; Tech="- SQL`n- PostgreSQL`n- Data modeling"},
    @{Year="2024"; Slug="airflow-pipeline"; Title="Apache Airflow Pipeline"; Category="Data Engineering"; Type="airflow"; Description="An Apache Airflow DAG example for scheduled extract, transform and load steps."; Tech="- Python`n- Apache Airflow`n- ETL"},
    @{Year="2024"; Slug="spark-data-processing"; Title="Spark Data Processing"; Category="Big Data"; Type="spark"; Description="A PySpark processing job for reading raw data, transforming it and writing analytical output."; Tech="- Python`n- PySpark`n- Parquet"},
    @{Year="2024"; Slug="tableau-dashboard"; Title="Tableau Dashboard"; Category="Business Intelligence"; Type="bi"; Description="A Tableau dashboard planning repo with dataset, KPI definitions and dashboard wireframe."; Tech="- Tableau`n- CSV`n- Analytics"},
    @{Year="2024"; Slug="fastapi-project"; Title="FastAPI Project"; Category="Backend"; Type="fastapi"; Description="A FastAPI project with typed endpoints, Pydantic models and a clean app structure."; Tech="- Python`n- FastAPI`n- Pydantic"},

    @{Year="2025"; Slug="llm-chatbot"; Title="LLM Chatbot"; Category="Artificial Intelligence"; Type="llm"; Description="A lightweight LLM chatbot skeleton with prompt templates and API-ready structure."; Tech="- Python`n- LLM API`n- FastAPI-ready"},
    @{Year="2025"; Slug="rag-application"; Title="RAG Application"; Category="Artificial Intelligence"; Type="rag"; Description="A retrieval augmented generation prototype using documents, chunks and simple vector search simulation."; Tech="- Python`n- RAG`n- embeddings concept"},
    @{Year="2025"; Slug="langchain-project"; Title="LangChain Project"; Category="Artificial Intelligence"; Type="langchain"; Description="A LangChain-style project skeleton showing chains, tools and agent workflow concepts."; Tech="- Python`n- LangChain concepts`n- tools"},
    @{Year="2025"; Slug="computer-vision"; Title="Computer Vision"; Category="AI Vision"; Type="vision"; Description="A computer vision starter project with image preprocessing and classification-ready structure."; Tech="- Python`n- OpenCV`n- Computer Vision"},
    @{Year="2025"; Slug="ocr-python"; Title="OCR with Python"; Category="AI OCR"; Type="ocr"; Description="An OCR project skeleton for image preprocessing and text extraction workflows."; Tech="- Python`n- OCR`n- OpenCV"},
    @{Year="2025"; Slug="nlp-project"; Title="NLP Project"; Category="NLP"; Type="nlp"; Description="A natural language processing project with text cleaning, tokenization and classification-ready features."; Tech="- Python`n- NLP`n- scikit-learn"},
    @{Year="2025"; Slug="mlops-pipeline"; Title="MLOps Pipeline"; Category="MLOps"; Type="mlops"; Description="An MLOps demo with training script, experiment metadata and CI-ready structure."; Tech="- Python`n- MLflow concept`n- Docker"},
    @{Year="2025"; Slug="data-lake-project"; Title="Data Lake Project"; Category="Data Engineering"; Type="lake"; Description="A data lake layout demonstrating raw, silver and gold zones with sample transformation notes."; Tech="- Data Lake`n- Parquet concept`n- Spark-ready layout"},
    @{Year="2025"; Slug="azure-data-factory"; Title="Azure Data Factory"; Category="Cloud Data"; Type="adf"; Description="An Azure Data Factory documentation repo describing ingestion, transformation and monitoring pipelines."; Tech="- Azure Data Factory`n- Cloud Data`n- ETL"},
    @{Year="2025"; Slug="kafka-streaming"; Title="Kafka Streaming"; Category="Streaming"; Type="kafka"; Description="A Kafka streaming demo with producer and consumer scripts for event-based data processing."; Tech="- Python`n- Kafka`n- Streaming"},
    @{Year="2025"; Slug="kubernetes-demo"; Title="Kubernetes Demo"; Category="DevOps"; Type="kubernetes"; Description="A Kubernetes deployment demo with app code, Dockerfile and Kubernetes manifests."; Tech="- Kubernetes`n- Docker`n- Python"},
    @{Year="2025"; Slug="ci-cd-github-actions"; Title="CI CD GitHub Actions"; Category="DevOps"; Type="cicd"; Description="A CI/CD demo repository with automated lint/test workflow using GitHub Actions."; Tech="- GitHub Actions`n- Python`n- CI/CD"}
)

function Write-ProjectFiles {
    param([hashtable]$Project)

    $dir = Join-Path $root (Join-Path $Project.Year $Project.Slug)
    $run = "python src/main.py"
    if ($Project.Type -like "java*") { $run = "javac src/Main.java && java -cp src Main" }
    if ($Project.Type -eq "web" -or $Project.Type -eq "web-api") { $run = "Open index.html in a browser" }
    if ($Project.Type -eq "sql" -or $Project.Type -eq "warehouse") { $run = "Run sql/schema.sql then sql/queries.sql" }
    if ($Project.Type -eq "spring") { $run = "mvn spring-boot:run" }
    if ($Project.Type -eq "docker") { $run = "docker compose up --build" }
    if ($Project.Type -eq "kubernetes") { $run = "kubectl apply -f k8s/" }
    if ($Project.Type -eq "bi" -or $Project.Type -eq "adf" -or $Project.Type -eq "lake") { $run = "Review docs/ and data/ assets" }

    Write-TextFile (Join-Path $dir "README.md") (ReadmeText $Project.Title $Project.Year $Project.Category $Project.Description $Project.Tech $run)
    Write-TextFile (Join-Path $dir "LICENSE") (LicenseText)
    Write-TextFile (Join-Path $dir ".gitignore") @"
__pycache__/
.venv/
*.pyc
target/
.idea/
.vscode/
node_modules/
dist/
build/
.env
"@
    Write-TextFile (Join-Path $dir "docs/notes.md") @"
# Notes

This repository is part of the professional portfolio of Salaheddine Abbar.

## Learning objective

$($Project.Description)

## Suggested GitHub topics

- portfolio
- $($Project.Category.ToLower().Replace(' ', '-'))
- $($Project.Year)
"@

    switch ($Project.Type) {
        "web" {
            Write-TextFile (Join-Path $dir "index.html") @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$($Project.Title)</title>
  <link rel="stylesheet" href="src/styles.css">
</head>
<body>
  <main>
    <h1>$author</h1>
    <p>Portfolio project focused on clean HTML and CSS.</p>
    <section class="grid">
      <article>Python</article>
      <article>Java</article>
      <article>Data</article>
    </section>
  </main>
</body>
</html>
"@
            Write-TextFile (Join-Path $dir "src/styles.css") @"
body { margin: 0; font-family: Arial, sans-serif; background: #0f172a; color: #f8fafc; }
main { max-width: 900px; margin: 0 auto; padding: 48px 24px; }
h1 { color: #60a5fa; }
.grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }
article { border: 1px solid #334155; padding: 16px; border-radius: 8px; background: #111827; }
"@
        }
        "web-api" {
            Write-TextFile (Join-Path $dir "index.html") @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Weather App</title>
  <link rel="stylesheet" href="src/styles.css">
</head>
<body>
  <main>
    <h1>Weather App</h1>
    <button id="load">Load weather</button>
    <pre id="result"></pre>
  </main>
  <script src="src/app.js"></script>
</body>
</html>
"@
            Write-TextFile (Join-Path $dir "src/styles.css") "body { font-family: Arial, sans-serif; padding: 40px; background: #0f172a; color: white; } button { padding: 10px 14px; }"
            Write-TextFile (Join-Path $dir "src/app.js") @"
const sample = { city: "Casablanca", temperature: 24, condition: "Clear" };
document.getElementById("load").addEventListener("click", () => {
  document.getElementById("result").textContent = JSON.stringify(sample, null, 2);
});
"@
        }
        "java" {
            Write-TextFile (Join-Path $dir "src/Main.java") @"
class Developer {
    private final String name;
    Developer(String name) { this.name = name; }
    String introduce() { return "Hello, I am " + name + " and I practice Java OOP."; }
}

public class Main {
    public static void main(String[] args) {
        Developer developer = new Developer("Salaheddine Abbar");
        System.out.println(developer.introduce());
    }
}
"@
        }
        "java-crud" {
            Write-TextFile (Join-Path $dir "src/Main.java") @"
import java.util.*;

record Student(int id, String name, double grade) {}

public class Main {
    public static void main(String[] args) {
        List<Student> students = List.of(
            new Student(1, "Amina", 16.5),
            new Student(2, "Youssef", 14.0),
            new Student(3, "Sara", 18.0)
        );
        students.forEach(System.out::println);
    }
}
"@
        }
        "spring" {
            Write-TextFile (Join-Path $dir "pom.xml") @"
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.salaheddine</groupId>
  <artifactId>student-api</artifactId>
  <version>1.0.0</version>
  <properties><java.version>17</java.version></properties>
</project>
"@
            Write-TextFile (Join-Path $dir "src/main/java/com/salaheddine/App.java") "package com.salaheddine; public class App { public static void main(String[] args) { System.out.println(""Student API skeleton""); } }"
            Write-TextFile (Join-Path $dir "docs/endpoints.md") "# Endpoints`n`n- GET /students`n- GET /students/{id}`n- POST /students"
        }
        "sql" {
            Write-TextFile (Join-Path $dir "sql/schema.sql") "CREATE TABLE students (id INTEGER PRIMARY KEY, name VARCHAR(100), grade NUMERIC);`nINSERT INTO students VALUES (1, 'Amina', 16.5), (2, 'Youssef', 14.0);"
            Write-TextFile (Join-Path $dir "sql/queries.sql") "SELECT * FROM students WHERE grade >= 15;`nSELECT AVG(grade) AS average_grade FROM students;"
        }
        "warehouse" {
            Write-TextFile (Join-Path $dir "sql/schema.sql") "CREATE TABLE dim_customer (customer_id INT PRIMARY KEY, city VARCHAR(80));`nCREATE TABLE fact_sales (sale_id INT PRIMARY KEY, customer_id INT, amount NUMERIC, sale_date DATE);"
            Write-TextFile (Join-Path $dir "sql/queries.sql") "SELECT c.city, SUM(f.amount) AS revenue FROM fact_sales f JOIN dim_customer c ON c.customer_id = f.customer_id GROUP BY c.city;"
        }
        "bi" {
            Write-TextFile (Join-Path $dir "data/sales.csv") "date,region,product,revenue`n2024-01-01,North,Laptop,1200`n2024-01-02,South,Phone,800"
            Write-TextFile (Join-Path $dir "docs/dashboard-spec.md") "# Dashboard Spec`n`nKPIs: revenue, sales by region, top products, monthly trend."
        }
        "adf" {
            Write-TextFile (Join-Path $dir "docs/pipeline-design.md") "# Azure Data Factory Pipeline`n`nSource: Blob Storage`nTransform: Mapping Data Flow`nSink: Azure SQL`nMonitoring: pipeline alerts."
            Write-TextFile (Join-Path $dir "data/sample_orders.csv") "order_id,customer,amount`n1,Amina,250`n2,Youssef,180"
        }
        "lake" {
            Write-TextFile (Join-Path $dir "data/raw/orders.csv") "order_id,status,amount`n1,new,120`n2,paid,300"
            Write-TextFile (Join-Path $dir "docs/lake-zones.md") "# Data Lake Zones`n`n- raw: original files`n- silver: cleaned data`n- gold: analytics-ready tables"
        }
        "docker" {
            Write-TextFile (Join-Path $dir "src/main.py") "print('Dockerized Python app running successfully')"
            Write-TextFile (Join-Path $dir "Dockerfile") "FROM python:3.12-slim`nWORKDIR /app`nCOPY src/ src/`nCMD [""python"", ""src/main.py""]"
            Write-TextFile (Join-Path $dir "docker-compose.yml") "services:`n  app:`n    build: ."
        }
        "kubernetes" {
            Write-TextFile (Join-Path $dir "src/main.py") "print('Kubernetes demo app')"
            Write-TextFile (Join-Path $dir "Dockerfile") "FROM python:3.12-slim`nWORKDIR /app`nCOPY src/ src/`nCMD [""python"", ""src/main.py""]"
            Write-TextFile (Join-Path $dir "k8s/deployment.yaml") "apiVersion: apps/v1`nkind: Deployment`nmetadata:`n  name: portfolio-demo`nspec:`n  replicas: 1`n  selector:`n    matchLabels:`n      app: portfolio-demo`n  template:`n    metadata:`n      labels:`n        app: portfolio-demo`n    spec:`n      containers:`n        - name: app`n          image: portfolio-demo:latest"
            Write-TextFile (Join-Path $dir "k8s/service.yaml") "apiVersion: v1`nkind: Service`nmetadata:`n  name: portfolio-demo`nspec:`n  selector:`n    app: portfolio-demo`n  ports:`n    - port: 80`n      targetPort: 8000"
        }
        "cicd" {
            Write-TextFile (Join-Path $dir "src/main.py") "def add(a, b):`n    return a + b`n`nif __name__ == '__main__':`n    print(add(2, 3))"
            Write-TextFile (Join-Path $dir "tests/test_main.py") "from src.main import add`n`ndef test_add():`n    assert add(2, 3) == 5"
            Write-TextFile (Join-Path $dir ".github/workflows/ci.yml") "name: CI`non: [push, pull_request]`njobs:`n  test:`n    runs-on: ubuntu-latest`n    steps:`n      - uses: actions/checkout@v4`n      - uses: actions/setup-python@v5`n        with:`n          python-version: '3.12'`n      - run: python -m pytest"
            Write-TextFile (Join-Path $dir "requirements.txt") "pytest>=8.0.0"
        }
        default {
            Write-TextFile (Join-Path $dir "src/main.py") @"
from pathlib import Path


def main() -> None:
    project = "$($Project.Title)"
    print(f"{project} - portfolio project by Salaheddine Abbar")
    data_dir = Path("data")
    data_dir.mkdir(exist_ok=True)


if __name__ == "__main__":
    main()
"@
            Write-TextFile (Join-Path $dir "requirements.txt") "pandas>=2.0.0`nscikit-learn>=1.4.0"
            Write-TextFile (Join-Path $dir "data/sample.csv") "id,value`n1,100`n2,200"
        }
    }
}

New-Item -ItemType Directory -Path $root -Force | Out-Null

foreach ($project in $projects) {
    Write-ProjectFiles $project
    $repoPath = Join-Path $root (Join-Path $project.Year $project.Slug)
    if (-not (Test-Path -LiteralPath (Join-Path $repoPath ".git"))) {
        git -C $repoPath init | Out-Null
        git -C $repoPath config user.name $author
        git -C $repoPath config user.email $email
    }
    git -C $repoPath add .
    $hasChanges = git -C $repoPath status --porcelain
    if ($hasChanges) {
        git -C $repoPath commit -m "Initial portfolio project" | Out-Null
    }
}

Write-Output "Created $($projects.Count) portfolio repositories in $root"
