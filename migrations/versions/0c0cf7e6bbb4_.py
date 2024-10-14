"""Merge head between mwai and v4.8.1

Revision ID: 0c0cf7e6bbb4
Revises: ecb6985693c0_, 63eeefa8d86c
Create Date: 2024-10-14 13:03:00.041843

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import orm


# revision identifiers, used by Alembic.
revision = '0c0cf7e6bbb4'
down_revision = ('ecb6985693c0_', '63eeefa8d86c')
branch_labels = None
depends_on = None

Base = declarative_base()
class Projects(Base):
    __tablename__ = 'projects'
    id = sa.Column(sa.Integer, primary_key=True)
    total_tasks = sa.Column(sa.Integer)
class Tasks(Base):
    __tablename__ = 'tasks'
    id = sa.Column(sa.Integer, primary_key=True)
    project_id = sa.Column(sa.Integer, sa.ForeignKey('projects.id'), primary_key=True)

def upgrade():
    conn = op.get_bind()
    session = orm.Session(bind=conn)
    # Update task count if it is bad
    for project in session.query(Projects).all():
        project.total_tasks = session.query(Tasks).filter(Tasks.project_id == project.id).count()
    session.commit()

def downgrade():
    pass
