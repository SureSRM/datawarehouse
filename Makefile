init:
	pipenv install

notebook:
	pipenv run jupyter notebook

data:
	curl 'http://files.grouplens.org/datasets/movielens/ml-20m.zip' --output ml-20m.zip
	-unzip ml-20m.zip -d data
	curl 'http://files.grouplens.org/datasets/movielens/ml-latest-small.zip' --output ml-latest-small.zip
	-unzip ml-latest-small.zip -d data
	rm ml-20m.zip
	rm ml-latest-small.zip
	
