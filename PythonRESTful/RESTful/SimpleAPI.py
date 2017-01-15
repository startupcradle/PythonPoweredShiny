from pprint import pprint

import hug
import pandas as pd
import logging
import sys
import json

# Logging to Command Line
log = logging.getLogger()
logging.basicConfig(stream=sys.stdout, level=logging.DEBUG,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')


@hug.get('/cars')
def cars_data():
    log.info("Loading the cars file (Data/cars.csv)")
    file_path = "Data/cars.csv"
    df = pd.read_csv(file_path)
    log.info("Loading the cars file to JSON")
    data = {"payload": df.to_json(orient="records")}
    return data


@hug.get('/pressure')
def pressure_data():
    log.info("Loading the pressure file (Data/pressure.csv)")
    file_path = "Data/pressure.csv"
    df = pd.read_csv(file_path)
    log.info("Loading the pressure file to JSON")
    data = {"payload": df.to_json(orient="records")}
    return data


@hug.get('/rock')
def rock_data():
    log.info("Loading the rock file (Data/rock.csv)")
    file_path = "Data/rock.csv"
    df = pd.read_csv(file_path)
    log.info("Loading the rock file to JSON")
    data = {"payload": df.to_json(orient="records")}
    return data

@hug.post('/data')
def recieve_put(data):
    log.info("Received Data!")
    data["Message"] = "Hello {}, Python Added this!".format(data["Name"])
    pprint(data)
    return data
