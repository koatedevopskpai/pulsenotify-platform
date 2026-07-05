from pydantic import BaseModel, ConfigDict, StringConstraints
from typing_extensions import Annotated


class ItemCreate(BaseModel):
    name: Annotated[str, StringConstraints(min_length=1, strip_whitespace=True)]


class ItemResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
