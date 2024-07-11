"""Merge head between mwai and v4.7.4

Revision ID: 1c22007182e1
Revises: 42c45e74752b, 42c782eaa790
Create Date: 2024-07-11 05:34:22.909095

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '1c22007182e1'
down_revision = ('42c45e74752b', '42c782eaa790')
branch_labels = None
depends_on = None


def upgrade():
    pass


def downgrade():
    pass
