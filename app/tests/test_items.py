def test_create_item(client):
    response = client.post("/items", json={"name": "test-item"})
    assert response.status_code == 201
    data = response.json()
    assert data["name"] == "test-item"
    assert "id" in data


def test_create_item_empty_name(client):
    response = client.post("/items", json={"name": ""})
    assert response.status_code == 422


def test_create_item_whitespace_name(client):
    response = client.post("/items", json={"name": "   "})
    assert response.status_code == 422


def test_list_items_empty(client):
    response = client.get("/items")
    assert response.status_code == 200
    assert response.json() == []


def test_list_items_with_data(client):
    client.post("/items", json={"name": "a"})
    client.post("/items", json={"name": "b"})
    response = client.get("/items")
    assert len(response.json()) == 2


def test_get_item(client):
    create_resp = client.post("/items", json={"name": "find-me"})
    item_id = create_resp.json()["id"]

    response = client.get(f"/items/{item_id}")
    assert response.status_code == 200
    assert response.json()["name"] == "find-me"


def test_get_item_not_found(client):
    response = client.get("/items/999")
    assert response.status_code == 404
