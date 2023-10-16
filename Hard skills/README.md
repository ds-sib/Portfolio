# [Hard skills](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills)

There are a few examples of how I've applied basic DA skills.

- SQL
  - [Dashboard sales dep](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills/SQL/Dashboard%20sales%20dep)
  - [London Airbnb](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills/SQL/London%20Airbnb)
  - [Education app](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills/SQL/Education%20app)
- Python
  - [Advertisement analysis](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills/Python/Advertisement%20analysis)
- A/B testing
  - [New mechanics for a dating app](https://github.com/ds-sib/Portfolio/blob/main/Hard%20skills/A%3AB%20tests/dating_app.ipynb)
- Airflow
  - [Game sales analysis](https://github.com/ds-sib/Portfolio/tree/main/Hard%20skills/Airflow)
- Tableau
  - [Employee Satisfaction Report](https://public.tableau.com/views/EmployeeSatisfactionReport/EmployeeSatisfactionReport?:language=en-US&:display_count=n&:origin=viz_share_link)
  - [2016-2019 Profit Dashboard](https://public.tableau.com/app/profile/mikhail.konovalov/viz/KC_L2_T1_Profit_Dashboard/Dashboard)

## SQL

### Dashboard for online store sales department (Dashboard sales dep)

Redash dashboard with KPIs that would allow to understand the current state of the business as a whole and in different countries, as well as the dynamics of the most important metrics

### London Airbnb
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white) ![Plotly](https://img.shields.io/badge/Plotly-%233F4F75.svg?style=for-the-badge&logo=plotly&logoColor=white) ![Airbnb](https://img.shields.io/badge/Airbnb-%23ff5a5f.svg?style=for-the-badge&logo=Airbnb&logoColor=white)

A bit ad-hoc tasks with a dataframe about Airbnb listings in London using the pandahouse and visualisation libraries.

### Education app

We need to write an optimal query that gives information about the number of very diligent students. By diligent student we mean a student who solved 20 problems correctly for the current month.
It is also necessary to unload basic metrics about user groups in one request.

## Python

### Advertisement analysis
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white) ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black)	![Plotly](https://img.shields.io/badge/Plotly-%233F4F75.svg?style=for-the-badge&logo=plotly&logoColor=white)

Analyzing data of interactions with advertisements on some site. There are  the tasks that have been completed as part of the analysis:

1. Look at the distribution of the number of impressions and clicks
2. Calculate the moving average of impressions with window 2
3. Find on which day there is the greatest difference in modulus between the arithmetic mean and the moving average.
4. Load data on advertising clients and find the average number of days from the date of creation of an advertising client and the first launch of an ad by this client
5. Calculate the conversion rate from the creation of an advertising client to the first ad run within 365 days or less
6. Determine how many unique customers ran their first ad in their first month of existence. Visualise the categories.

### Metmuseum analysis
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black)

Analyzing data from metmuseum with API  

### Service transactions analysis
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black)

Analyzing transactions of a service using different platforms  

## A/B testing

### New mechanics for a dating app
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black) ![SciPy](https://img.shields.io/badge/SciPy-%230C55A5.svg?style=for-the-badge&logo=scipy&logoColor=%white)

The application team developed a new algorithm to find the most appropriate questionnaires. To verify the algorithm's work, an AB-test was conducted. All users were divided into two groups.

My task was to evaluate whether it is true that the new algorithm has improved the quality of service. 

## Airflow

### Game sales analysis
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![Apache Airflow](https://img.shields.io/badge/Apache%20Airflow-017CEE?style=for-the-badge&logo=Apache%20Airflow&logoColor=white)

DAG of several tasks that will result in finding answers to the following questions:

1. Which game was the best-selling game worldwide this year?
2. Which genre of games was the best-selling game in Europe? List them all if there are more than one
3. Which platform had the most games that sold over a million copies in North America? List all if there are more than one
4. Which publisher had the highest average sales in Japan? List all if there are more than one
5. How many games have sold better in Europe than in Japan?
