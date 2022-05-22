
START=1
STATUS_PYPI=0
STATUS_DOCS=0
STATUS_DOCS_S3=0

# Exportando pacote para Pypi
if [ "$START" -eq 1 -a "$STATUS_PYPI" -eq 0 ]; then
    echo 1. Exportando pacote para Pypi
    python3 setup.py sdist
    python3 setup.py bdist_wheel
    twine upload dist/*
    rm -r build
    rm -r dist
    rm -r optym.egg-info/

    if [ $? -eq 0 ]; then
        STATUS_PYPI=1
    else
        echo "[ERROR] It was not possible to export docs to S3"
        STATUS_PYPI=0
    fi
fi

# Generating documentation
if [ "$START" -eq 1 -a "$STATUS_DOCS" -eq 0 ]; then
    echo 2. Generating documentation
    cd docs
    make html
    cd ..

    if [ $? -eq 0 ]; then
        echo OK
        STATUS_DOCS=1
    else
        echo "[ERROR] It was not possible to generate docs"
        STATUS_DOCS=0
    fi
fi


# Exporting documentation
if [ "$START" -eq 1 -a "$STATUS_DOCS_S3" -eq 0 ]; then
    echo 3. Exporting documentation to s3
    aws s3 cp --recursive docs/build/html/ s3://www.optym-lib.com/

    if [ $? -eq 0 ]; then
        echo OK
        STATUS_DOCS_S3=1
    else
        echo "[ERROR] It was not possible to export docs to S3"
        STATUS_DOCS_S3=0
    fi
fi


# The Standalone command will initialise the database, make a user,
# and start all components for you.
#airflow standalone






# You will need to set reload_on_plugin_change = True in your airflow.cfg file under the [webserver] section.

