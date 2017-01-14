
| Project       | Created   | Updated   | Version |
|---------------|-----------|-----------|---------|
| Shiny RESTful | 14/1/2017 | 14/1/2017 | 0.1     |

# Overview

This API was created using a simple to use package called [hug](http://www.hug.rest/). **hug** aims to make developing Python driven APIs as simple as possible, but no simpler. As a result, it drastically simplifies Python API development.

The API provide three endpoints:
1. cars => [http://localhost:8000/cars](http://localhost:8000/cars)
2. pressure => [http://localhost:8000/pressure](http://localhost:8000/pressure)
3. rock => [http://localhost:8000/rock](http://localhost:8000/rock)

# Install Dependencies

Use the following command in your terminal / command prompt:

```bash
    pip3 install -r requirements.txt
```

# Running the API

```bash
    hug -f RESTful/SimpleAPI.py
```
