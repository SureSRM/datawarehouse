init:
	pipenv install

notebook:
	pipenv run jupyter notebook

data:
	curl 'http://files.grouplens.org/datasets/movielens/ml-20m.zip' --output ml-20m.zip
	-unzip ml-20m.zip -d data
