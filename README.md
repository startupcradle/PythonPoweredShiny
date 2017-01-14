
| Project       | Created   | Updated   | Version |
|---------------|-----------|-----------|---------|
| Shiny RESTful | 14/1/2017 | 14/1/2017 | 0.1     |

# Overview

Demonstration of using a R Shiny Dashboard calling a Python RESTful API.

## Python API

This API was created using a simple to use package called [hug](http://www.hug.rest/). **hug** aims to make developing Python driven APIs as simple as possible, but no simpler. As a result, it drastically simplifies Python API development.

### Running the API

```bash
    hug -f RESTful/SimpleAPI.py
```

### Endpoints

The API provide three endpoints:

1. cars => [http://localhost:8000/cars](http://localhost:8000/cars)
2. pressure => [http://localhost:8000/pressure](http://localhost:8000/pressure)
3. rock => [http://localhost:8000/rock](http://localhost:8000/rock)

See the [README.md](PythonRESTful/README.md) file in the Python RESTful folder

## Shiny Dashboard

Three files are used to create the Dashboard:

1.  a script to define the user interface (ui.R)
2.  a script to set the server that responds to UI actions and displays the charts (server.R)
3.  a supporting file that creates variables and functions that are globally available to bother the server and UI scripts (global.R).

### Running the Dashboard

Simply open any of the file R files; server, ui or global. Once open you will see a "Run" icon in the upper right hand side of the script pane, click that option.

Adjacent to the "Run" icon is a dropdown, select "Run External" before running.

See the [README.md](ShinyRESTful/README.md) file in the Python RESTful folder
