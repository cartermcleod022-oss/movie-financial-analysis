import pandas as pd
import duckdb
from ast import literal_eval


# Load movie dataset
movies = pd.read_csv("movies_metadata.csv.zip")


# Register main movie dataset with DuckDB
duckdb.register("movies", movies)


# -----------------------------
# Genre preprocessing
# -----------------------------

movies["genres_parsed"] = movies["genres"].apply(literal_eval)


def get_genre_names(genres):
    names = []

    for genre in genres:
        names.append(genre["name"])

    return names


movies["genre_names"] = movies["genres_parsed"].apply(get_genre_names)

# Create one row per movie-genre combination
genre_df = movies.explode("genre_names")

# Register genre table for SQL analysis
duckdb.register("genres", genre_df)


# -----------------------------
# Production company preprocessing
# -----------------------------

movies["companies_parsed"] = movies["production_companies"].apply(
    lambda x: literal_eval(x) if isinstance(x, str) else []
)


def get_company_names(companies):
    names = []

    if isinstance(companies, list):
        for company in companies:
            if isinstance(company, dict) and "name" in company:
                names.append(company["name"])

    return names


movies["company_names"] = movies["companies_parsed"].apply(get_company_names)

# Create one row per movie-company combination
company_df = movies.explode("company_names")

# Register company table for SQL analysis
duckdb.register("companies", company_df)
