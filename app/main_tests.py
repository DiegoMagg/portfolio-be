def test_check_if_pytest_works(client):
    response = client.get('/')
    assert response.status_code == 200
    assert response.json() == {'msg': 'Hello World'}
