from airflow import DAG
from airflow.operators.python import PythonOperator
from clickhouse_driver import Client
import psycopg2
import json

with open(r"/opt/airflow/dags/keys/connect.json") as json_file:
    сonnect_settings = json.load(json_file)

client = Client(
    сonnect_settings["ch_local"][0]["host"],
    user=сonnect_settings["ch_local"][0]["user"],
    password=сonnect_settings["ch_local"][0]["password"],
    verify=False,
    database="default",
    settings={"numpy_columns": True, "use_numpy": True},
    compression=True,
)


client_PG = psycopg2.connect(
    host=сonnect_settings["postgres"][0]["host"],
    user=сonnect_settings["postgres"][0]["user"],
    password=сonnect_settings["postgres"][0]["password"],
    dbname="postgres",
)

default_args = {
    "owner": "shreyder",
}

dag = DAG(dag_id="report_wbitem_volume", default_args=default_args, tags=["shreyder"])


def main():
    # Перевод объема в литры
    df = client.query_dataframe(
        f"""
        select wbitem,
               supplier_id,
               tare_sticker,
               nm_id,
               (vol / 1000) vol,
               now() dt_load
        from default.wbitemDeclaration_log
    """
    )

    cursor = client_PG.cursor()
    df = df.to_json(orient="records", date_format="iso")
    cursor.execute(f"""CALL sync.wbitem_volume_import(_src := '{df}')""")

    client_PG.commit()
    cursor.close()
    client_PG.close()

    print("\n\nДаг отработал успешно\n\n")


PythonOperator(task_id="dag", python_callable=main, dag=dag)
