import pandas as pd
from datetime import timedelta
from datetime import datetime

from airflow.decorators import dag, task

# Settings for AF
default_args = {
                'owner': 'm-konovalov-40',
                'depends_on_past': False,
                'retries': 2,
                'retry_delay': timedelta(minutes=5),
                'start_date': datetime(2023, 9, 4),
                'schedule_interval': '0 10 * * *'
               }

login = 'm-konovalov-40'
year  = 1994 + hash(f'{login}') % 23

@dag(default_args=default_args, catchup=False)
def game_sales_analysis():
    
    # Read data
    @task(retries=3)
    def get_data():
        vg = pd.read_csv('/var/lib/airflow/airflow.git/dags/a.batalov/vgsales.csv').query('Year==@year')
        return vg

    # Which game was the best-selling game worldwide this year?
    @task(retries=4, retry_delay=timedelta(10))
    def top_game(vg):
        top_game = vg.sort_values('Global_Sales').tail(1).iloc[0]['Name']
        return top_game

    # Which genre of games was the best-selling game in Europe?
    @task()
    def top_sold_eu_by_genre(vg):
        top_sold_eu_by_genre  = vg.groupby('Genre', as_index=False).agg({'EU_Sales': 'max'})
        max_sales_eu_by_genre = top_sold_eu_by_genre.EU_Sales.max()
        top_sold_eu_by_genre  = top_sold_eu_by_genre.query('EU_Sales==@max_sales_eu_by_genre').Genre.tolist()
        return top_sold_eu_by_genre

    # Which platform had the most games that sold over a million copies in North America?
    @task()
    def top_sold_na_by_platform(vg):
        top_sold_na_by_platform  = vg.query('NA_Sales > 1') \
                                     .groupby('Platform', as_index=False) \
                                     .agg({'Name': 'count'}) \
                                     .rename(columns={'Name': 'unicorn_games'})
        max_sales_na_by_platform = top_sold_na_by_platform.unicorn_games.max()
        top_sold_na_by_platform  = top_sold_na_by_platform.query('unicorn_games==@max_sales_na_by_platform').Platform.tolist()
        return top_sold_na_by_platform

    # Which publisher had the highest average sales in Japan?
    @task()
    def top_sold_jp_by_publisher(vg):
        top_sold_jp_by_publisher  = vg.groupby('Publisher', as_index=False) \
                                      .agg({'JP_Sales': 'mean'})
        max_sales_jp_by_publisher = top_sold_jp_by_publisher.JP_Sales.max()
        top_sold_jp_by_publisher  = top_sold_jp_by_publisher.query('JP_Sales==@max_sales_jp_by_publisher').Publisher.tolist()
        return top_sold_jp_by_publisher

    # How many games have sold better in Europe than in Japan?
    @task()
    def eu_better_than_jp(vg):
        eu_better_than_jp = vg.query('EU_Sales > JP_Sales').shape[0]
        return eu_better_than_jp

    # Print results to logs
    @task()
    def print_data(top_game, eu_better_than_jp, top_sold_eu_by_genre, top_sold_na_by_platform, top_sold_jp_by_publisher):

        print(f'The most popular game in {year} is {top_game}')

        print(f'The most popular genre(s) in {year}:')
        print(*top_sold_eu_by_genre, sep=', ')

        print(f'Platform(s) with the most 1m games in {year} in N.A.:')
        print(*top_sold_na_by_platform, sep=', ')

        print(f'Publisher(s) with highest average sales in {year} in Japan:')
        print(*top_sold_jp_by_publisher, sep=', ')

        print(f'{eu_better_than_jp} games sold better in EU than in Japan in {year}')

    # Task ordering
    vg                       = get_data()
    top_game                 = top_game(vg)
    top_sold_eu_by_genre     = top_sold_eu_by_genre(vg)
    top_sold_na_by_platform  = top_sold_na_by_platform(vg)
    top_sold_jp_by_publisher = top_sold_jp_by_publisher(vg)
    eu_better_than_jp        = eu_better_than_jp(vg)

    print_data(top_game, eu_better_than_jp, top_sold_eu_by_genre, top_sold_na_by_platform, top_sold_jp_by_publisher)


game_sales_analysis = game_sales_analysis()