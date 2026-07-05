from sqlalchemy.orm import Session

from app.models import Item


class ItemService:
    def __init__(self, db: Session):
        self.db = db

    def create_item(self, name: str) -> Item:
        db_item = Item(name=name)
        self.db.add(db_item)
        self.db.commit()
        self.db.refresh(db_item)
        return db_item

    def list_items(self) -> list[Item]:
        return self.db.query(Item).all()

    def get_item(self, item_id: int) -> Item | None:
        return self.db.query(Item).filter(Item.id == item_id).first()
