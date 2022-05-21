python3 setup.py sdist
python3 setup.py bdist_wheel
twine upload dist/*
rm -r build
rm -r dist
rm -r gradesc.egg-info/