def test_db_isolation(client):
    resp1 = client.get("/items")
    assert len(resp1.json()) == 0

    client.post("/items", json={"name": "isolated"})

    resp2 = client.get("/items")
    assert len(resp2.json()) == 1
