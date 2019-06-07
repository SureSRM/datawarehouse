init: init-p1 init-p2

##############
# P1 Targets #
##############

init-p1: dbdapp

dbdapp:
	mkdir -p dbdapp
	curl 'http://webdiis.unizar.es/~silarri/TEACHING/TOOLS/DBDap-web.zip' --output dbdapp/DBDap-web.zip
	-unzip dbdapp/DBDap-web.zip -d dbdapp/
	rm dbdapp/DBDap-web.zip

app:
	cd dbdapp && java -jar DBDap.jar

##############
# P2 Targets #
##############

init-p2: data
	pipenv install

data:
	curl 'http://files.grouplens.org/datasets/movielens/ml-20m.zip' --output ml-20m.zip
	-unzip ml-20m.zip -d data
	curl 'http://files.grouplens.org/datasets/movielens/ml-latest-small.zip' --output ml-latest-small.zip
	-unzip ml-latest-small.zip -d data
	rm ml-20m.zip
	rm ml-latest-small.zip

notebook:
	pipenv run jupyter notebook

###################
# Memoria Targets #
###################

define build_entrega
	rm -Rf entrega/p$(1)
	mkdir -p entrega/p$(1)
	-pandoc -s -o entrega/p$(1)/memoria-p$(1).pdf P$(1)_Memoria.md
	cp autores.txt $(2) entrega/p$(1)/
	cd entrega && zip -FSr p$(1)-$(NIP).zip p$(1)/
endef

define build_final
	rm -Rf entrega/final
	mkdir -p entrega/final
	-pandoc -s -o entrega/final/memoria-todas.pdf P*_Memoria.md
	cp autores.txt Mejoras.txt $(1) entrega/final/
	cd entrega && zip -FSr final-$(NIP).zip final/
endef

entregas:
	$(call build_entrega,1,Makefile *.eee *.sql)
	$(call build_entrega,2,Makefile Pipfile* ETL.ipynb)
	$(call build_entrega,3,Makefile Pipfile* Recomendador.ipynb)
	$(call build_entrega,5)
	$(call build_final,Makefile *.eee *.sql Pipfile* *.ipynb)
