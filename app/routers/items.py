from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.item import ItemCreate, ItemResponse
from app.services.item_service import ItemService

router = APIRouter(prefix="/items", tags=["items"])


@router.post("", response_model=ItemResponse, status_code=201)
def create_item(item: ItemCreate, db: Session = Depends(get_db)):
    service = ItemService(db)
    db_item = service.create_item(item.name)
    return db_item


@router.get("", response_model=list[ItemResponse])
def list_items(db: Session = Depends(get_db)):
    service = ItemService(db)
    return service.list_items()


@router.get("/{item_id}", response_model=ItemResponse)
def get_item(item_id: int, db: Session = Depends(get_db)):
    service = ItemService(db)
    db_item = service.get_item(item_id)
    if not db_item:
        raise HTTPException(status_code=404, detail="Item not found")
    return db_item
