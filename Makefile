install:
	cd app && pipenv install

dev-install:
	cd app && \
	pipenv install --dev && \
	pipenv run pre-commit install --hook-type pre-commit --hook-type pre-push

up:
	docker compose up -d

down:
	docker compose down

shell:
	cd app && pipenv run python manage.py shell

postgres-up:
	docker compose -f local.yml up portfolio-postgres -d

superuser: postgres-up
	cd app && pipenv run python manage.py createsuperuser

local-up:
	docker compose -f local.yml up -d

local-down:
	docker compose -f local.yml down

dev-server-up: postgres-up
	cd app && pipenv run uvicorn main:app --reload

test: postgres-up
	cd app && pipenv run pytest

test-coverage: postgres-up
	cd app && pipenv run coverage erase
	rm -rf app/htmlcov
	cd app && pipenv run coverage run -m pytest
	cd app && pipenv run coverage html
