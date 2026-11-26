from enum import Enum

from pydantic import BaseModel, ConfigDict


class FieldType(str, Enum):
    DATE = "date"
    NUMBER = "number"
    TEXT = "text"


class RevenuePulseField(BaseModel):
    model_config = ConfigDict(frozen=True)

    name: str
    label: str
    field_type: FieldType
    required: bool = False


REVENUEPULSE_FIELDS = (
    RevenuePulseField(name="date", label="Date", field_type=FieldType.DATE, required=True),
    RevenuePulseField(name="account_id", label="Account ID", field_type=FieldType.TEXT, required=True),
    RevenuePulseField(name="account_name", label="Account name", field_type=FieldType.TEXT, required=True),
    RevenuePulseField(name="plan", label="Plan", field_type=FieldType.TEXT),
    RevenuePulseField(name="product", label="Product", field_type=FieldType.TEXT),
    RevenuePulseField(name="channel", label="Acquisition channel", field_type=FieldType.TEXT),
    RevenuePulseField(name="mrr", label="Monthly recurring revenue", field_type=FieldType.NUMBER),
    RevenuePulseField(name="revenue", label="Revenue", field_type=FieldType.NUMBER),
    RevenuePulseField(name="users", label="User count", field_type=FieldType.NUMBER),
    RevenuePulseField(name="active_users", label="Active users", field_type=FieldType.NUMBER),
    RevenuePulseField(name="status", label="Account status", field_type=FieldType.TEXT),
)
